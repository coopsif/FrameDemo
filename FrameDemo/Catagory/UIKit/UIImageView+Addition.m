//
//  UIImageView+Addition.m
//  Demo
//
//  Created by Suteki on 16/7/9.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#import "UIImageView+Addition.h"
#import "UIImageView+WebCache.h"
@implementation UIImageView (Addition)

- (void)setImageWithURL:(NSString *)url placeholder:(NSString *)placeholder {
    if ([url isKindOfClass:[NSString class]]) {
        if (!placeholder.length) {
            [self sd_setImageWithURL:[NSURL URLWithString:url]];
        }
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholder]];
    } else {
        NSLog(@"warning!");
    }
}

@end
