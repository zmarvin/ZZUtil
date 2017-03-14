//
//  NSMutableDictionary+ZZSetValue.h
//  EnjoyMusic
//
//  Created by zz on 2017/1/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSMutableDictionary (ZZSetValue)

-(void)setObj:(id)i forKey:(NSString*)key;

-(void)setString:(NSString*)i forKey:(NSString*)key;

-(void)setBool:(BOOL)i forKey:(NSString*)key;

-(void)setInt:(int)i forKey:(NSString*)key;

-(void)setInteger:(NSInteger)i forKey:(NSString*)key;

-(void)setUnsignedInteger:(NSUInteger)i forKey:(NSString*)key;

-(void)setCGFloat:(CGFloat)f forKey:(NSString*)key;

-(void)setChar:(char)c forKey:(NSString*)key;

-(void)setFloat:(float)i forKey:(NSString*)key;

-(void)setPoint:(CGPoint)o forKey:(NSString*)key;

-(void)setSize:(CGSize)o forKey:(NSString*)key;

-(void)setRect:(CGRect)o forKey:(NSString*)key;

@end
