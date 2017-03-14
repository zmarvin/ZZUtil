//
//  UIButton+Tool.m
//  LBOX
//
//  Created by ZhangZhan on 15/11/26.
//  Copyright © 2015年 LeTV. All rights reserved.
//

#import "UIView+ZZTool.h"

@implementation UIView (ZZTool)

- (void)setUpBorderColor:(UIColor *)color cornerRadius:(CGFloat)radius borderWidth:(CGFloat)width{
    
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius]; //设置矩形四个圆角半径
    [self.layer setBorderWidth:width]; //边框宽度
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = color.CGColor;
    [self.layer setBorderColor:colorref];//边框颜色
    CGColorRelease(colorref);
    CGColorSpaceRelease(colorSpace);
}

-(void)setBorderColorWithRed:(CGFloat)red withColorGreen:(CGFloat)green withColorBlue:(CGFloat)blue{
        
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [self.layer setBorderWidth:1]; //边框宽度
    
    [self setBorderColorWithRed:red green:green blue:blue];
}

- (void)setBorderColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ red/255.f, green/255.f, blue/255.f, 1 });
    [self.layer setBorderColor:colorref];//边框颜色
    CGColorRelease(colorref);
    CGColorSpaceRelease(colorSpace);
}

@end



