//
//  NSObject+ZZResetProperty.h
//  ZZUtil
//
//  Created by zz on 2017/2/10.
//  Copyright © 2017年 zz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZZResetProperty)

- (void)zz_resetProperty;

- (void)zz_resetPropertyWithIgnorePropertyKeyPaths:(NSArray *)KeyPaths;

@end
