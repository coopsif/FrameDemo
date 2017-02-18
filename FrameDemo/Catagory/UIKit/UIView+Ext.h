//
//  UIView+Ext.h
//  Here
//
//  Created by liumadu on 15-1-5.
//  Copyright (c) 2015年 lmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Ext)

@property(nonatomic,assign) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property(nonatomic,readonly) CGFloat screenX;
@property(nonatomic,readonly) CGFloat screenY;
@property(nonatomic,readonly) CGFloat screenViewX;
@property(nonatomic,readonly) CGFloat screenViewY;
@property(nonatomic,readonly) CGRect screenFrame;

@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize size;

@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic, strong) IBInspectable UIColor *borderColor;

@property(nonatomic) BOOL visible;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;


/**
 * Calculates the offset of this view from another view in screen coordinates.
 */
- (CGPoint)offsetFromView:(UIView*)otherView;


/**
 * The view controller whose view contains this view.
 */
- (UIViewController*)viewController;

- (void)addSubviews:(NSArray *)views;

- (void)removeAllRecognizers;

- (void)addTapCallBack:(id)target sel:(SEL)selector;

- (void)addlongCallBack:(id)target sel:(SEL)selector;//长按事件
//拖拽手势
- (void)addpanCallBack:(id)target sel:(SEL)selector;
//左清扫手势
- (void)addSwipeLeftCallBack:(id)target sel:(SEL)selector;
//右清扫手势
- (void)addSwipeRightCallBack:(id)target sel:(SEL)selector;
#pragma mark - 拖拽手势
- (void)addPanCallBack:(id)target sel:(SEL)selector;

- (void)setLeft:(CGFloat)x;

/**
 *  获取当前视图控制器
 *
 *  @return 当前视图控制器对象
 */
- (UIViewController *)getCurrentVC;

//block 响应单击
- (void)tap_block:(void (^)(UIGestureRecognizer *sender))block;

//loadNib
+ (id)loadNib;

@end
