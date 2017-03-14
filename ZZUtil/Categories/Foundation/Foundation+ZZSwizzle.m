//
//  Foundation+swizzle.m
//
//
//  Created by zmarvin on 15-11-25.
//  Copyright (c) 2015年 zmarvin. All rights reserved.
//

#import "Foundation+ZZSwizzle.h"
#import <objc/runtime.h>

@implementation NSObject(ZZSwizzle)

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

@end

@implementation NSArray(ZZSwizzle)
/**
 *  只要分类被装载到内存中，就会调用1次
 */
+ (void)load
{
//    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayI") originSelector:@selector(objectAtIndex:) otherSelector:@selector(swizzle_objectAtIndex:)];
}

- (id)swizzle_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self swizzle_objectAtIndex:index];
    } else {
        return nil;
    }
}

@end

@implementation NSMutableArray(ZZSwizzle)

+ (void)load
{
//    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(addObject:) otherSelector:@selector(swizzle_addObject:)];
//    [self swizzleInstanceMethod:NSClassFromString(@"__NSArrayM") originSelector:@selector(objectAtIndex:) otherSelector:@selector(swizzle_objectAtIndex:)];
}

- (void)swizzle_addObject:(id)object
{
    if (object != nil) {
        [self swizzle_addObject:object];
    }
}

- (id)swizzle_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self swizzle_objectAtIndex:index];
    } else {
        return nil;
    }
}

@end
