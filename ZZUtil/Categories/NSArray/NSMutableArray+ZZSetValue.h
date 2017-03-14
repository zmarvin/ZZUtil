//
//  NSMutableArray+ZZSetValue.h
//  EnjoyMusic
//
//  Created by zz on 2017/1/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableArray (ZZSetValue)

-(void)addObj:(id)i;

-(void)addString:(NSString*)i;

-(void)addBool:(BOOL)i;

-(void)addInt:(int)i;

-(void)addInteger:(NSInteger)i;

-(void)addUnsignedInteger:(NSUInteger)i;

-(void)addCGFloat:(CGFloat)f;

-(void)addChar:(char)c;

-(void)addFloat:(float)i;

-(void)addPoint:(CGPoint)o;

-(void)addSize:(CGSize)o;

-(void)addRect:(CGRect)o;

@end
