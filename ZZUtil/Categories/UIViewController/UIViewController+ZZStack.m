//
//  UIViewController+stack.m
//  Pods
//
//  Created by ZhangZhan on 16/3/30.
//
//

#import "UIViewController+ZZStack.h"

@implementation UIViewController (ZZStack)

+ (BOOL)classIsAtStackOfParentControler:(UIViewController *)parentController{
    BOOL isExist = NO;
    for (UIViewController *viewConroller in parentController.childViewControllers) {
        
        if ([viewConroller isKindOfClass:[self class]]) {
            isExist = YES;
            break;
        }
    }
    
    return isExist;
}

- (NSMutableArray *)getVCArrayAtStackWithClassString:(NSString *)aClassString{
    Class aClass = NSClassFromString(aClassString);
    
    NSMutableArray *vcArr = [NSMutableArray array];
    
    for (UIViewController *viewConroller in self.childViewControllers) {
        
        if ([viewConroller isKindOfClass:aClass])
            [vcArr addObject:viewConroller];
        
        NSMutableArray *insideVCArr = [viewConroller getVCArrayAtStackWithClassString:aClassString];
        [vcArr addObjectsFromArray:insideVCArr];
    }
    
    return vcArr;
}
- (UIViewController *)getVCAtStackWithClassString:(NSString *)aClassString{
    Class aClass = NSClassFromString(aClassString);
    
    for (UIViewController *viewConroller in self.childViewControllers) {
        
        if ([viewConroller isKindOfClass:aClass]) {
            
            return viewConroller;
        }
        
        UIViewController *insideVC = [viewConroller getVCAtStackWithClassString:aClassString];
        if (insideVC != nil)
            return insideVC;
    }
    
    return nil;
}

- (UIViewController *)getVCAtStackWithClass:(Class)aClass{
    NSString *aClassString = NSStringFromClass(aClass);
    
    for (UIViewController *viewConroller in self.childViewControllers) {
        
        if ([viewConroller isKindOfClass:aClass]) {
            
            return viewConroller;
        }
        
        UIViewController *insideVC = [viewConroller getVCAtStackWithClassString:aClassString];
        if (insideVC != nil)
            return insideVC;
    }
    
    return nil;
}

@end
