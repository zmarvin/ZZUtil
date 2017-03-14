//
//  NSObject+LBObjectEmpty.h
//  LBOX
//
//  Created by ZhangZhan on 15/12/25.
//  Copyright © 2015年 LeTV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZZCheckup)

+ (BOOL)empty:(NSObject *)o;

+ (BOOL)memberIsClassTypeWithName:(const char *)keyPath;
    
@end

