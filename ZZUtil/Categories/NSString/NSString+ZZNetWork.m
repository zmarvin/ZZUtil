//
//  NSString+LBNetWork.m
//  LBOX
//
//  Created by zmarvin on 15/12/16.
//  Copyright © 2015年 zmarvin. All rights reserved.
//

#import "NSString+ZZNetWork.h"

@implementation NSString (ZZNetWork)

+ (NSString *)queryStringFromParameters:(NSDictionary *)parameters
{
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:@"?"];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"%@=%@&",key,obj];
    }];
    NSString *tempStr = [strM substringToIndex:strM.length - 1];
    return tempStr;
}

+ (NSString *)completedUrlStringFromParameters:(NSDictionary *)parameters baseUrl:(NSString *)baseUrl{
    NSString *parameterUrl = [self queryStringFromParameters:parameters];
    return [baseUrl stringByAppendingString:parameterUrl];
}

@end
