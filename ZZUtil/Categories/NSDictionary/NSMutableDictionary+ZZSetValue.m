//
//  NSMutableDictionary+ZZSetValue.m
//  EnjoyMusic
//
//  Created by zz on 2017/1/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "NSMutableDictionary+ZZSetValue.h"
#import <UIKit/UIKit.h>

@implementation NSMutableDictionary (ZZSetValue)

-(void)setObj:(id)i forKey:(NSString*)key{
    if (i!=nil) {
        self[key] = i;
    }
}
-(void)setString:(NSString*)i forKey:(NSString*)key;
{
    [self setValue:i forKey:key];
}
-(void)setBool:(BOOL)i forKey:(NSString *)key
{
    self[key] = @(i);
}
-(void)setInt:(int)i forKey:(NSString *)key
{
    self[key] = @(i);
}
-(void)setInteger:(NSInteger)i forKey:(NSString *)key
{
    self[key] = @(i);
}
-(void)setUnsignedInteger:(NSUInteger)i forKey:(NSString *)key
{
    self[key] = @(i);
}
-(void)setCGFloat:(CGFloat)f forKey:(NSString *)key
{
    self[key] = @(f);
}
-(void)setChar:(char)c forKey:(NSString *)key
{
    self[key] = @(c);
}
-(void)setFloat:(float)i forKey:(NSString *)key
{
    self[key] = @(i);
}
-(void)setPoint:(CGPoint)o forKey:(NSString *)key
{
    self[key] = NSStringFromCGPoint(o);
}
-(void)setSize:(CGSize)o forKey:(NSString *)key
{
    self[key] = NSStringFromCGSize(o);
}
-(void)setRect:(CGRect)o forKey:(NSString *)key
{
    self[key] = NSStringFromCGRect(o);
}

@end
