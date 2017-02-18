//
//  BaseFunc.h
//  Pocket91
//
//  Created by Liu Jinyong on 14-6-28.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CHECK_INPUT(__OBJ__,__TIP__) if(![Utility checkInput:__OBJ__ tip:__TIP__]) {return;}


@interface Utility : NSObject

+ (BOOL)checkInput:(id)object tip:(NSString *)tip;

@end
