//
//  NSObject+ZZResetProperty.m
//  ZZUtil
//
//  Created by zz on 2017/2/10.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "NSObject+ZZResetProperty.h"
#import <objc/runtime.h>

static NSArray * zz_IgnoreResetPropertyKeyPaths() {
    static NSArray *_ignoreKeyPaths = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ignoreKeyPaths = [NSArray arrayWithObjects:@"hash",@"superclass",@"description",@"debugDescription", nil];
    });
    return _ignoreKeyPaths;
}

@implementation NSObject (ZZResetProperty)

- (void)zz_resetProperty{
    
    [self zz_resetPropertyWithIgnorePropertyKeyPaths:nil];
    
}
- (void)zz_resetPropertyWithIgnorePropertyKeyPaths:(NSArray *)KeyPaths{
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t propertie = properties[i];
        NSString *keyPath = [NSString stringWithUTF8String:property_getName(propertie)];
        
        NSMutableArray *IgnorePropertyKeyPaths = [NSMutableArray arrayWithArray:zz_IgnoreResetPropertyKeyPaths()];
        
        if (KeyPaths.count) {
            [IgnorePropertyKeyPaths addObjectsFromArray:KeyPaths];
        }
        if ([IgnorePropertyKeyPaths containsObject:keyPath]) continue;
        
        NSMutableString *upperFirstKeyPath = [NSMutableString string];
        [upperFirstKeyPath appendString:[NSString stringWithFormat:@"%c", [keyPath characterAtIndex:0]].uppercaseString];
        if (keyPath.length >= 2) [upperFirstKeyPath appendString:[keyPath substringFromIndex:1]];
        
        SEL setSel = NSSelectorFromString([NSString stringWithFormat:@"set%@:",upperFirstKeyPath]);
        
        @try {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
            if ([self respondsToSelector:setSel]) {
                [self performSelector:setSel withObject:NULL];
            }
#pragma clang diagnostic pop
        } @catch (NSException *exception) {
            NSLog(@"when [%@ zz_resetProperty] thow exception %@",NSStringFromClass(self.class),exception);
        }
        
    }
}


@end
