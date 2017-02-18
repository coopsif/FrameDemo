//
//  UIView+Ext.m
//  Here
//
//  Created by liumadu on 15-1-5.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import "UIView+Ext.h"
#import <objc/runtime.h>

static const int target_key;

@implementation UIView (Ext)

- (BOOL)visible{
    return !self.hidden;
}

- (void)setVisible:(BOOL)visible{
    self.hidden = !visible;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)screenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}

- (CGFloat)screenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}

- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}

- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}


- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}



- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0, y = 0;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += view.left;
        y += view.top;
    }
    return CGPointMake(x, y);
}

- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}

- (UIView*)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
    } else if (self.superview) {
        return [self.superview ancestorOrSelfWithClass:cls];
    } else {
        return nil;
    }
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


- (void)addSubviews:(NSArray *)views
{
    for (UIView* v in views) {
        [self addSubview:v];
    }
}

- (void)removeAllRecognizers
{
  [self.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       [self removeGestureRecognizer:obj];
  }];
}

- (void)addTapCallBack:(id)target sel:(SEL)selector
{
  self.userInteractionEnabled = YES;
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
  [self addGestureRecognizer:tap];
}

//长按手势
- (void)addlongCallBack:(id)target sel:(SEL)selector
{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tap];
}
//拖拽手势
- (void)addpanCallBack:(id)target sel:(SEL)selector
{
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:selector];
    pan.minimumNumberOfTouches = 1;
    pan.maximumNumberOfTouches = 1;
    [self addGestureRecognizer:pan];
}

//左清扫手势
- (void)addSwipeLeftCallBack:(id)target sel:(SEL)selector
{
     self.userInteractionEnabled = YES;
     UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:selector];
     swipe.direction = UISwipeGestureRecognizerDirectionLeft;
     [self addGestureRecognizer:swipe];
}

//右清扫手势
- (void)addSwipeRightCallBack:(id)target sel:(SEL)selector
{
     self.userInteractionEnabled = YES;
     UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:selector];
     swipe.direction = UISwipeGestureRecognizerDirectionRight;
     [self addGestureRecognizer:swipe];
}

#pragma mark - 拖拽手势
- (void)addPanCallBack:(id)target sel:(SEL)selector
{
     self.userInteractionEnabled = YES;
     UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:selector];
     pan.minimumNumberOfTouches = 1;
     pan.maximumNumberOfTouches = 1;
     [self addGestureRecognizer:pan];
}


- (UIViewController *)getCurrentVC
{
     UIViewController *result = nil;
     UIWindow * window = [[UIApplication sharedApplication] keyWindow];
     if (window.windowLevel != UIWindowLevelNormal)
     {
          NSArray *windows = [[UIApplication sharedApplication] windows];
          for(UIWindow * tmpWin in windows)
          {
               if (tmpWin.windowLevel == UIWindowLevelNormal){
                    window = tmpWin;
                    break;
               }
          }
     }
     UIView *frontView = [[window subviews] objectAtIndex:0];
     id nextResponder = [frontView nextResponder];
     
     if ([nextResponder isKindOfClass:[UIViewController class]])
          result = nextResponder;
     else
          result = window.rootViewController;
     return result;
}

//block
- (void)tap_block:(void (^)(UIGestureRecognizer *sender))block{
    self.userInteractionEnabled = YES;
    [self addActionBlock:block];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizer:)];
    [self addGestureRecognizer:tap];
}

- (void)addActionBlock:(void (^)(UIGestureRecognizer *))block {
    if (block) {
        objc_setAssociatedObject(self, &target_key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)gestureRecognizer:(UIGestureRecognizer *)sender{
    
    void (^block)(UIGestureRecognizer *) = objc_getAssociatedObject(self, &target_key);
    if (block) {
        block(sender);
    }
}

//loadNib
+ (id)loadNib{
    NSString *nibName = NSStringFromClass([self class]);
    id ob = [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] firstObject];
    //NSAssert(ob, @"ob不能为空");
    return ob;
}


@end
