//
//  BaseNavigationController.m
//  wangwanglife
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 kajiter. All rights reserved.
//

#import "BaseNavigationController.h"

@implementation BaseNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        //统一设置返回图片
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back2_pgnews"] style:UIBarButtonItemStylePlain target:self action:@selector(navGoBack)];
    }
    [super pushViewController:viewController animated:YES];
}


#pragma mark - action
- (void)navGoBack{
    [self popViewControllerAnimated:YES];
}

@end
