//
//  UIViewController+MLInputDodger.m
//  NengZhe
//
//  Created by Cher on 16/5/31.
//  Copyright © 2016年 LiuKun. All rights reserved.
//

#import "UIViewController+MLInputDodger.h"
#import <objc/runtime.h>
#import "SDImageCache.h"
@implementation UIViewController (MLInputDodger)


/**
 *
 *  注意事项
 
 Swizzling通常被称作是一种黑魔法，容易产生不可预知的行为和无法预见的后果。虽然它不是最安全的，但如果遵从以下几点预防措施的话，还是比较安全的：
 
 总是调用方法的原始实现(除非有更好的理由不这么做)：API提供了一个输入与输出约定，但其内部实现是一个黑盒。Swizzle一个方法而不调用原始实现可能会打破私有状态底层操作，从而影响到程序的其它部分。
 避免冲突：给自定义的分类方法加前缀，从而使其与所依赖的代码库不会存在命名冲突。
明白是怎么回事：简单地拷贝粘贴swizzle代码而不理解它是如何工作的，不仅危险，而且会浪费学习Objective-C运行时的机会。阅读Objective-C Runtime Reference和查看<objc/runtime.h>头文件以了解事件是如何发生的。
  小心操作：无论我们对Foundation, UIKit或其它内建框架执行Swizzle操作抱有多大信心，需要知道在下一版本中许多事可能会不一样。
 *
 */

/**
 *  方法置换 在viewDidAppear设置
 */
+(void)initialize{
     
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
          Class cla = [self class];
          //视图已经出现
          SEL orgSel = @selector(didReceiveMemoryWarning);
          SEL newSel = @selector(mLInputDodger_didReceiveMemoryWarning);
          Method orgMethod = class_getInstanceMethod(cla, orgSel);
          Method newMethod = class_getInstanceMethod(cla, newSel);
          BOOL didAddMethod = class_addMethod(cla, orgSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
          if (didAddMethod) {
               class_replaceMethod(cla, newSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
          }else{
               method_exchangeImplementations(orgMethod, newMethod);
          }
     });
}

#pragma mark - Method Swizzling 内存警告
- (void)mLInputDodger_didReceiveMemoryWarning{
     
     [[SDImageCache sharedImageCache] clearDisk];
     [[SDImageCache sharedImageCache] clearMemory];
     [self mLInputDodger_didReceiveMemoryWarning];
     //NSLog(@"viewDidAppear: %@", self);
}


@end
