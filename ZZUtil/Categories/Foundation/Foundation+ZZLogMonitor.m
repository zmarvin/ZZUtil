//
//  EMTableViewController.h
//  EnjoyMusic
//
//  Created by zz on 2017/2/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "Foundation+ZZLogMonitor.h"
#import <objc/runtime.h>

@implementation NSObject(ZZLogMonitor)

+ (void)swizzleClassMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector
{
    Method otherMehtod = class_getClassMethod(class, otherSelector);
    Method originMehtod = class_getClassMethod(class, originSelector);
    // 交换2个方法的实现
    method_exchangeImplementations(otherMehtod, originMehtod);
}

+ (void)swizzleInstanceMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector
{
    Method otherMehtod = class_getInstanceMethod(class, otherSelector);
    Method originMehtod = class_getInstanceMethod(class, originSelector);
    // 交换2个方法的实现
    method_exchangeImplementations(otherMehtod, originMehtod);
}

+ (void)zz_startDeallocMonitor
{
    [self swizzleInstanceMethod:self originSelector:NSSelectorFromString(@"dealloc") otherSelector:@selector(zz_dealloc)];
}

- (void)zz_dealloc{
    NSLog(@"生命周期监控：%@ has dealloc",NSStringFromClass(self.class));
    [self zz_dealloc];
}

@end


