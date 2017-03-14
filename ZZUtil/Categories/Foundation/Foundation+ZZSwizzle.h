//
//  Foundation+ZZSwizzle.h
//  EnjoyMusic
//
//  Created by zz on 2017/1/27.
//  Copyright © 2017年 Mac. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSObject(ZZSwizzle)

+ (void)swizzleClassMethod:(Class)aClass originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector;

+ (void)swizzleInstanceMethod:(Class)aClass originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector;

@end

@interface NSArray(ZZSwizzle)

- (id)swizzle_objectAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray(ZZSwizzle)


- (void)swizzle_addObject:(id)object;


- (id)swizzle_objectAtIndex:(NSUInteger)index;

@end
