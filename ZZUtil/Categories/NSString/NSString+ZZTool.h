//
//  NSString+LBTool.h
//  Pods
//
//  Created by zmarvin on 15/12/2.
//  Copyright © 2015年 zmarvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ZZTool)

- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

+ (BOOL)isEmptyString:(NSString *)string;

+ (NSString*)safeString:(NSString *)string;

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)parameters;


@end
