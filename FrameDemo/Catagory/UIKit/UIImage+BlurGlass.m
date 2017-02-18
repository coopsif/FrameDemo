//
//  UIImage+BlurGlass.m
//  Chuangdou
//
//  Created by Cher on 15/10/10.
//  Copyright © 2015年 com.saiku. All rights reserved.
//

#import "UIImage+BlurGlass.h"
#import <Accelerate/Accelerate.h>
@implementation UIImage (BlurGlass)

/*
 1.白色,参数:
 透明度 0~1,  0为白,   1为深灰色
 半径:默认30,推荐值 3   半径值越大越模糊 ,值越小越清楚
 色彩饱和度(浓度)因子:  0是黑白灰, 9是浓彩色, 1是原色  默认1.8
 “彩度”，英文是称Saturation，即饱和度。将无彩色的黑白灰定为0，最鲜艳定为9s，这样大致分成十阶段，让数值和人的感官直觉一致。
 */
- (UIImage *)imgWithLightAlpha:(CGFloat)alpha radius:(CGFloat)radius colorSaturationFactor:(CGFloat)colorSaturationFactor
{
     UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:alpha];
     return [self imgBluredWithRadius:radius tintColor:tintColor saturationDeltaFactor:colorSaturationFactor maskImage:nil];
}
// 2.封装好,供外界调用的
- (UIImage *)imgWithBlur
{
     // 调用方法1
     return [self imgWithLightAlpha:0.1 radius:3 colorSaturationFactor:1];
}




// 内部方法,核心代码,封装了毛玻璃效果 参数:半径,颜色,色彩饱和度
- (UIImage *)imgBluredWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage
{
     
     CGRect imageRect = { CGPointZero, self.size };
     UIImage *effectImage = self;
     BOOL hasBlur = blurRadius > __FLT_EPSILON__;
     BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
     if (hasBlur || hasSaturationChange) {
          UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
          CGContextRef effectInContext = UIGraphicsGetCurrentContext();
          CGContextScaleCTM(effectInContext, 1.0, -1.0);
          CGContextTranslateCTM(effectInContext, 0, -self.size.height);
          CGContextDrawImage(effectInContext, imageRect, self.CGImage);
          UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
          CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
          vImage_Buffer effectOutBuffer;
          effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
          effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
          effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
          effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
          
          if (hasBlur) {
               CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
               int radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
               if (radius % 2 != 1) {
                    radius += 1; // force radius to be odd so that the three box-blur methodology works.
               }
               vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
               vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
               vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
          }
          BOOL effectImageBuffersAreSwapped = NO;
          if (hasSaturationChange) {
               CGFloat s = saturationDeltaFactor;
               CGFloat floatingPointSaturationMatrix[] = {
                    0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                    0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                    0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                    0,                    0,                    0,  1,
               };
               const int32_t divisor = 256;
               NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
               int16_t saturationMatrix[matrixSize];
               for (NSUInteger i = 0; i < matrixSize; ++i) {
                    saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
               }
               if (hasBlur) {
                    vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                    effectImageBuffersAreSwapped = YES;
               }
               else {
                    vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
               }
          }
          if (!effectImageBuffersAreSwapped)
               effectImage = UIGraphicsGetImageFromCurrentImageContext();
          UIGraphicsEndImageContext();
          
          if (effectImageBuffersAreSwapped)
               effectImage = UIGraphicsGetImageFromCurrentImageContext();
          UIGraphicsEndImageContext();
     }
     
     // 开启上下文 用于输出图像
     UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
     CGContextRef outputContext = UIGraphicsGetCurrentContext();
     CGContextScaleCTM(outputContext, 1.0, -1.0);
     CGContextTranslateCTM(outputContext, 0, -self.size.height);
     
     // 开始画底图
     CGContextDrawImage(outputContext, imageRect, self.CGImage);
     
     // 开始画模糊效果
     if (hasBlur) {
          CGContextSaveGState(outputContext);
          if (maskImage) {
               CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
          }
          CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
          CGContextRestoreGState(outputContext);
     }
     
     // 添加颜色渲染
     if (tintColor) {
          CGContextSaveGState(outputContext);
          CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
          CGContextFillRect(outputContext, imageRect);
          CGContextRestoreGState(outputContext);
     }
     
     // 输出成品,并关闭上下文
     UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     
     return outputImage;
}

//压缩图片
- (UIImage *)imageCompressTargetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}


@end
