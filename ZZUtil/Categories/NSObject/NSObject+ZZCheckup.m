//
//  NSObject+LBObjectEmpty.m
//  LBOX
//
//  Created by ZhangZhan on 15/12/25.
//  Copyright © 2015年 LeTV. All rights reserved.
//

#import "NSObject+ZZCheckup.h"
#import <objc/runtime.h>

@implementation NSObject (ZZCheckup)

+ (BOOL)empty:(NSObject *)o{
    
    if (o==nil) {
        return YES;
    }
    if (o==NULL) {
        return YES;
    }
    if (o==[NSNull new]) {
        return YES;
    }
    if ([o isKindOfClass:[NSString class]]) {
        return [self isEmptyString:(NSString *)o];
    }
    if ([o isKindOfClass:[NSData class]]) {
        return [((NSData *)o) length]<=0;
    }
    if ([o isKindOfClass:[NSDictionary class]]) {
        return [((NSDictionary *)o) count]<=0;
    }
    if ([o isKindOfClass:[NSArray class]]) {
        return [((NSArray *)o) count]<=0;
    }
    if ([o isKindOfClass:[NSSet class]]) {
        return [((NSSet *)o) count]<=0;
    }
    return NO;
}

+ (BOOL)isEmptyString:(NSString *)string{
    
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if (    [string isEqual:nil]
        ||  [string isEqual:Nil]){
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (0 == [string length]){
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    if([string isEqualToString:@"(null)"]){
        return YES;
    }
    
    return NO;
}

+ (BOOL)memberIsClassTypeWithName:(const char *)keyPath{
    
    objc_property_t p = class_getProperty([self class], keyPath);
    objc_property_attribute_t *attrbutes = property_copyAttributeList(p, NULL);
    objc_property_attribute_t attribute = attrbutes[0];
    if (attribute.name[0] == 'T' && attribute.value[0] == '@') {
        return YES;
    }else{
        return NO;
    }
    
}
    
@end
