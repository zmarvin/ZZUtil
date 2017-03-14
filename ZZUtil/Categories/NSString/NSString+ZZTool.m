//
//  NSString+LBTool.m
//  Pods
//
//  Created by zmarvin on 15/12/2.
//  Copyright © 2015年 zmarvin. All rights reserved.
//

#import "NSString+ZZTool.h"
#import <Foundation/Foundation.h>

@implementation NSString (ZZTool)

- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    CGSize size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size;
}


+ (BOOL)isEmptyString:(NSString *)string{
    
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if (    [string isEqual:nil]
        ||  [string isEqual:Nil]){
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (0 == [string length]){
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    if([string isEqualToString:@"(null)"]){
        return YES;
    }
    
    return NO;
}


+ (NSString*)safeString:(NSString *)string{
    
    if ([NSString isEmptyString:string]) {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%@", string];
    
}

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)parameters{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:kNilOptions
                                                         error:&error];
    if (jsonData == nil) {
#ifdef DEBUG
        NSLog(@"fail to get JSON from dictionary: %@, error: %@", self, error);
#endif
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

@end
