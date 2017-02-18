//
//  BaseView.m
//  wangwanglife
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 kajiter. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self installView];
    }
    return self;
}

- (void)installView{
    
}

@end
