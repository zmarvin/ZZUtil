//
//  NSDictionary+ZZMerge.h
//  EnjoyMusic
//
//  Created by zz on 2017/1/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ZZMerge)
+ (NSDictionary *)dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;
- (NSDictionary *)dictionaryByMergingWith:(NSDictionary *)dict;
@end
