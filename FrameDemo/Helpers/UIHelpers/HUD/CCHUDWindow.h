//
//  CCHUDWindow.h
//  OC_Tools
//
//  Created by apple on 16/10/28.
//  Copyright © 2016年 Cher. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HideHUD                 [[CCHUDWindow sharedInstance] hideProgressHUD:YES]

//手动隐藏
#define ShowLoadingHUD(_MSG_)   [[CCHUDWindow sharedInstance] showProgressHUDWithMessage:_MSG_]
#define ShowLoading ShowLoadingHUD(@"请稍候...")

//自动2秒隐藏
#define ShowSuccessHUD(_MSG_)   [[CCHUDWindow sharedInstance] showCompleteHUDWithMessage:_MSG_ image:[UIImage imageNamed:@"tips_success"]]

#define ShowErrorHUD(_MSG_)     [[CCHUDWindow sharedInstance] showCompleteHUDWithMessage:_MSG_ image:[UIImage imageNamed:@"tips_failed"]]

#define ShowDelayErrorHUD(_MSG_,_Delay_)     [[CCHUDWindow sharedInstance] showCompleteHUDWithMessage:_MSG_ image:[UIImage imageNamed:@"tips_failed"] delay:_Delay_]

#define ShowWarningHUD(_MSG_)   [[CCHUDWindow sharedInstance] showCompleteHUDWithMessage:_MSG_ image:[UIImage imageNamed:@"tips_warning"]]


@interface CCHUDWindow : UIWindow

+ (CCHUDWindow *)sharedInstance;

- (void)showProgressHUDWithMessage:(NSString *)message;
- (void)showCompleteHUDWithMessage:(NSString *)message image:(UIImage *)image;
- (void)showCompleteHUDWithMessage:(NSString *)message image:(UIImage *)image delay:(NSTimeInterval)delay;

- (void)hideProgressHUD;
- (void)hideProgressHUD:(BOOL)animated;

@end
