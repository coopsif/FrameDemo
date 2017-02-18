//
//  CCHUDWindow.m
//  OC_Tools
//
//  Created by apple on 16/10/28.
//  Copyright © 2016年 Cher. All rights reserved.
//

#import "CCHUDWindow.h"
#import "MBProgressHUD.h"

#define DefualtAfterDelay 1.5f

static CCHUDWindow *tipWin = nil;

@interface CCHUDWindow () <MBProgressHUDDelegate> {
    UIImageView *_imageView;
    MBProgressHUD *_progressHUD;
    
}

@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation CCHUDWindow

+ (CCHUDWindow *)sharedInstance {
    
    @synchronized(tipWin) {
        if (tipWin == nil) {
            tipWin = [[CCHUDWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        }
    }
    return tipWin;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.windowLevel = UIWindowLevelAlert - 10;
        self.backgroundColor = [UIColor clearColor];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
        _imageView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (MBProgressHUD *)progressHUD {
    if (!_progressHUD) {
        
        _progressHUD = [[MBProgressHUD alloc] initWithView:self];
        _progressHUD.minSize = CGSizeMake(140, 90);
        _progressHUD.delegate = self;
        _progressHUD.bezelView.backgroundColor = [UIColor blackColor];
        _progressHUD.label.textColor = [UIColor whiteColor];
        _progressHUD.contentColor = [UIColor whiteColor];
        [self addSubview:_progressHUD];
    }
    return _progressHUD;
}

- (void)showProgressHUDWithMessage:(NSString *)message {
    
    self.progressHUD.label.text = message;
    self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    [self.progressHUD showAnimated:YES];
    self.hidden = NO;
}

- (void)showCompleteHUDWithMessage:(NSString *)message image:(UIImage *)image{
    _imageView.image = image;
    self.progressHUD.customView = _imageView;
    self.progressHUD.label.text = message;
    self.progressHUD.mode = MBProgressHUDModeCustomView;
    [self.progressHUD showAnimated:YES];
    [self.progressHUD hideAnimated:YES afterDelay:DefualtAfterDelay];
    self.hidden = NO;
}

- (void)showCompleteHUDWithMessage:(NSString *)message image:(UIImage *)image delay:(NSTimeInterval)delay{
    _imageView.image = image;
    self.progressHUD.customView = _imageView;
    self.progressHUD.label.text = message;
    self.progressHUD.mode = MBProgressHUDModeCustomView;
    [self.progressHUD showAnimated:YES];
    [self.progressHUD hideAnimated:YES afterDelay:delay];
    self.hidden = NO;
}

- (void)hideProgressHUD {
    [self hideProgressHUD:YES];
}

- (void)hideProgressHUD:(BOOL)animated {
    if (self.progressHUD.mode == MBProgressHUDModeIndeterminate) {
        [self.progressHUD hideAnimated:animated];
    }
}

#pragma mark MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
    self.hidden = YES;
}


@end
