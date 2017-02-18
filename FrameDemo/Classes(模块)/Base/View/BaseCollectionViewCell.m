//
//  BaseCollectionViewCell.m
//  wangwanglife
//
//  Created by apple on 16/11/1.
//  Copyright © 2016年 kajiter. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

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
