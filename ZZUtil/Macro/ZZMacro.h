//
//  Macro.h
//  LBOX
//
//  Created by ZhangZhan on 15-11-25.
//  Copyright (c) 2015年 LeTV. All rights reserved.
//

#ifndef ZZMacro_h
#define ZZMacro_h

#import "ZZSingleton.h"

#define __MAIN_SCREEN_BOUNDS    [[UIScreen mainScreen] bounds]
#define __MAIN_SCREEN_WIDTH     (__MAIN_SCREEN_BOUNDS.size.width)
#define __MAIN_SCREEN_HEIGHT    (__MAIN_SCREEN_BOUNDS.size.height)

#define SCRREN_PORTRAIT_WIDTH     ([LBGlobalMethods screenBoundsWithPortraitOrientation].size.width)
#define SCRREN_PORTRAIT_HEIGHT    ([LBGlobalMethods screenBoundsWithPortraitOrientation].size.height)


#define IS_IPHONE5      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE6      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE6PLUS  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define SYSTEM_VERSION                      [[[UIDevice currentDevice] systemVersion] doubleValue]
#define SYSTEM_VERSION_IS_ALLOWED(version)  ([[[UIDevice currentDevice] systemVersion] doubleValue] >= version)

#define IOS7_OR_LATER                       ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IS_IOS_8                            ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f)
#define IS_IOS_9                            ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0f)

#define COLOR_HEX(rgbValue)       [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define COLOR_RGB_(R, G, B, A)    [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define COLOR_RGB(r,g,b)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define COLOR_TITLE               COLOR_RGB( 68,  68,  68)
#define COLOR_TITLE_ASSISTANT     COLOR_RGB(161, 161, 161)
#define COLOR_BTN_TITLE_NORMAL    COLOR_RGB( 88, 149, 237)
#define COLOR_BTN_TITLE_SELECTED  COLOR_RGB(204, 204, 204)

#define FONT(args)                [UIFont systemFontOfSize:args]
#define FONT_TITLE                FONT(14)
#define FONT_TITLE_ASSISTANT      FONT(11)


#define STRING_FORMAT(...)        [NSString stringWithFormat:__VA_ARGS__]


#define NAVIGATION_BAR_HEIGHT     (44)


#define MAIN_BUNDLE_IMAGE(A)      [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]


#define NUMBER_OF_ROW(x,y)        (((x)%(y)) ? (x)/(y) + 1 : (x)/(y))// Get row number in matrix view or panel view


#define APP_DELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)


#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\n%s [line:%d]: %s\n",[NSDate date].description.UTF8String, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define NSLogFunc(FORMAT, ...) fprintf(stderr,"\n%s [line:%d]: %s\n at func:%s",[NSDate date].description.UTF8String, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String], __FUNCTION__);
#else
#define NSLog(FORMAT, ...) nil;
#endif


#if TARGET_OS_IPHONE//iPhone Device

#endif
#if TARGET_IPHONE_SIMULATOR//iPhone Simulator

#endif


#endif

