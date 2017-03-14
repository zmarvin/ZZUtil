//
//  NSString+Base64.m
//  数据加密
//  Created by zmarvin on 15-11-25.
//  Copyright (c) 2015年 zmarvin. All rights reserved.
//

#import "NSString+ZZBase64.h"

@implementation NSString (ZZBase64)

- (NSString *)base64Encode
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64Decode
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
