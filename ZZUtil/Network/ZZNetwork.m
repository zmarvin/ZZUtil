//
//  ZZNetwork.m
//  EnjoyMusic
//
//  Created by zz on 2017/1/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ZZNetwork.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation ZZNetwork

+ (NSString *)deviceWifiName{
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    NSString *wifiName = nil;
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
#if TARGET_IPHONE_SIMULATOR
    if (!wifiInterfaces) { // for debug
        return @"";
    }
#else
    if (!wifiInterfaces) {
        return @"";
    }
#endif
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
#pragma clang diagnostic pop
    return wifiName;
}

@end
