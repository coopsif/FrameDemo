//
//  CHADViewController.m
//  FrameDemo
//
//  Created by apple on 17/1/13.
//  Copyright © 2017年 Master. All rights reserved.
//

#import "CHADViewController.h"
#import "CHADView.h"
#import "AppConfig.h"

@interface CHADViewController ()

@property (nonatomic, weak) CHADView *adLaunchView;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation CHADViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addADLaunchView];
    
    [self loadData];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _adLaunchView.frame = self.view.bounds;
}

- (void)addADLaunchView
{
    CHADView *adLaunchView = [CHADView new];
    adLaunchView.skipBtn.hidden = YES;
    adLaunchView.launchImageView.image = [UIImage ty_getLaunchImage];
    [adLaunchView.skipBtn addTarget:self action:@selector(skipADAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:adLaunchView];
    _adLaunchView = adLaunchView;
}

const char *requestNubKey;
- (void)loadData
{
    @weakify(self);
   NSNumber *requestNub = [[CHRequestManager share] requestWithUrl:@"" type:Net_GET parameters:nil success:^(id responseObject) {
        @strongify(self);
        NSString *imageURL = (NSString *)responseObject[@"data"];
        if (!imageURL || ![imageURL isKindOfClass:[NSString class]]) {
            [self dismissController];
        }else{
            [self showADImageWithURL:[NSURL URLWithString:imageURL]];
        }
    } failure:^(NSString *errorDescription) {
        @strongify(self);
        [self dismissController];
    }];
    if (requestNub) {
        objc_setAssociatedObject(self, &requestNubKey, requestNub, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}


#pragma mark - private

- (void)showADImageWithURL:(NSURL *)url
{
    @weakify(self);
    [_adLaunchView.adImageView sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self);
        // 启动倒计时
        [self scheduledGCDTimer];
    }];
}

- (void)showSkipBtnTitleTime:(int)timeLeave
{
    NSString *timeLeaveStr = [NSString stringWithFormat:@"跳过 %ds",timeLeave];
    [_adLaunchView.skipBtn setTitle:timeLeaveStr forState:UIControlStateNormal];
    _adLaunchView.skipBtn.hidden = NO;
}

- (void)scheduledGCDTimer
{
    [self cancleGCDTimer];
    __block int timeLeave = 3; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    __typeof (self) __weak weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        if(timeLeave <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(weakSelf.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //关闭界面
                [weakSelf dismissController];
            });
        }else{
            int curTimeLeave = timeLeave;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面
                [weakSelf showSkipBtnTitleTime:curTimeLeave];
                
            });
            --timeLeave;
        }
    });
    dispatch_resume(_timer);
}

- (void)cancleGCDTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

#pragma mark - action

- (void)skipADAction{
    [self dismissController];
}

- (void)dismissController{
    NSNumber *requestNub = objc_getAssociatedObject(self, &requestNubKey);
    if (requestNub) {
        [[CHRequestManager share] cancelRequestWithRequestID:requestNub];
    }
    [self cancleGCDTimer];
    [UIView animateWithDuration:0.6 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [self cancleGCDTimer];
}

@end
