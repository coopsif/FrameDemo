//
//  NSObject+Addtion.m
//  OC_Tools
//
//  Created by apple on 16/10/31.
//  Copyright © 2016年 Cher. All rights reserved.
//

#import "NSObject+Addtion.h"

@implementation NSObject (Addtion)

- (NSDictionary *)jsonToDictionary{
    
    NSDictionary *responseDic = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:(NSData *)self options:NSJSONReadingMutableLeaves error:nil];
    return responseDic;
}


@end
