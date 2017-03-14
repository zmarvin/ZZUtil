//
//  NSString+LBNetWork.h
//  LBOX
//
//  Created by zmarvin on 15/12/16.
//  Copyright © 2015年 zmarvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZZNetWork)

/** 获取URL中query，从？号开始 */
+ (NSString *)queryStringFromParameters:(NSDictionary *)parameters;

+ (NSString *)completedUrlStringFromParameters:(NSDictionary *)parameters baseUrl:(NSString *)baseUrl;

@end
