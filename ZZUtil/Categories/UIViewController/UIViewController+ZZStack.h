//
//  UIViewController+stack.h
//  Pods
//
//  Created by ZhangZhan on 16/3/30.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (ZZStack)

+ (BOOL)classIsAtStackOfParentControler:(UIViewController *)parentController;
/** 返回递归层次下的所有需要的calss */
- (NSMutableArray *)getVCArrayAtStackWithClassString:(NSString *)aClassString;
/** 返回当前层次下的第一个calss */
- (UIViewController *)getVCAtStackWithClassString:(NSString *)aClassString;

- (UIViewController *)getVCAtStackWithClass:(Class)aClass;

@end
