//
//  NSString+Factory.m
//  OC_Tools
//
//  Created by apple on 16/10/28.
//  Copyright © 2016年 Cher. All rights reserved.
//

#import "NSString+Factory.h"

@implementation NSString (Factory)

//判断字符是否是纯数字
- (BOOL)isPureNumandCharacters
{
    NSString *selfStr = self;
    selfStr = [selfStr stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(selfStr.length > 0){
        return NO;
    }
    return YES;
}


//返回文本高度(文本固定宽度)
- (CGFloat)textHeightWithFontSize:(NSInteger)fontSize FixedWidth:(CGFloat)width{
    
    NSDictionary *attribute  = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                  attributes:attribute
                                     context:nil];
    
    return rect.size.height;
}

//返回文本宽度
- (CGFloat)textWidthWithFontSize:(NSInteger)fontSize
{
    NSDictionary *attribute  = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                     options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                  attributes:attribute
                                     context:nil];
    return rect.size.width;
}

static NSDateFormatter *format = nil;

- (NSString *)dateStrWith:(NSInteger )formatType{
    if (!self.length) return @"";
    NSString *formatStr = nil;
    switch (formatType) {
        case 0:
        {
            formatStr = @"yyyy年M月d日 HH:mm";
        }
            break;
        case 1:
        {
            formatStr = @"yyyy-M-d HH:mm:ss";
        }
            break;
        case 2:
        {
            formatStr = @"yyyy.MM.dd H:mm";
        }
            break;
        case 3:
        {
            formatStr = @"yyyy-MM-dd H:mm";
        }
            break;
        case 4:
        {
            formatStr = @"yyyy-M-d";
        }
            break;
            
        default:
            break;
    }
    NSString * timeStr = self;
    NSTimeInterval interval = [[timeStr substringToIndex:10] doubleValue];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:interval];
    if (!format) {
        format = [[NSDateFormatter alloc] init];
    }
    [format setDateFormat:formatStr];
    NSString * formatTime = [format stringFromDate:date];
    return formatTime;
}

- (NSDate *)dateWithTimeStamp{
    NSString * timeStr = self;
    NSTimeInterval interval = [[timeStr substringToIndex:10] doubleValue];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:interval];
    return date;
}

- (BOOL)nowTimeDifference:(NSInteger)hour
{
    NSString * timeStr = self;
    NSTimeInterval el = [[timeStr substringToIndex:10] doubleValue];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    NSTimeInterval cha = ABS(now-el);//相差时间
    NSLog(@"相差时间戳%f",cha);
    BOOL result = cha>60*60*24*hour?YES:NO;
    return result;
}

//身份证号(很准确)
- (BOOL)checkIsIdentityCard
{
    NSString *identityCard = self;
    //判断是否为空
    if (identityCard == nil||identityCard.length <= 0) {
        return NO;
    }
    //判断是否是18位，末尾是否是x
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if(![identityCardPredicate evaluateWithObject:identityCard]){
        return NO;
    }
    //判断生日是否合法
    NSRange range = NSMakeRange(6,8);
    NSString *datestr = [identityCard substringWithRange:range];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyyMMdd"];
    if([formatter dateFromString:datestr]==nil){
        return NO;
    }
    
    //判断校验位
    if(identityCard.length==18)
    {
        NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
        NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
        for(int i=0;i<17;i++){
            idCardWiSum+=[[identityCard substringWithRange:NSMakeRange(i,1)] intValue]*[idCardWi[i] intValue];
        }
        
        int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
        NSString *idCardLast=[identityCard substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast intValue]==[idCardY[idCardMod] intValue]){
                return YES;
            }else{
                return NO;
            }
        }
    }
    return NO;
}

- (NSMutableAttributedString *)drawlineOnCenter{
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attribtDic];
    return attribtStr;
}

- (NSMutableAttributedString *)drawlineOnBottom{
    //下划线
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attribtDic];
    return attribtStr;
}

@end
