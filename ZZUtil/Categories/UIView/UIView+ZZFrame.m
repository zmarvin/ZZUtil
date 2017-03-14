//
//  UIView+ZZFrame.m
//  EnjoyMusic
//
//  Created by zz on 2017/1/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "UIView+ZZFrame.h"

#define ZZ_assertFloatIsnan(value) \
do { \
if (isnan(value)) { \
    return; \
} \
} while (0); \

@implementation UIView (ZZFrame)

#pragma mark ---
#pragma mark --- set方法

- (void)setMaxX:(CGFloat)maxX
{
    ZZ_assertFloatIsnan(maxX);
    self.x = maxX - self.width;
}

- (void)setMaxY:(CGFloat)maxY
{
    ZZ_assertFloatIsnan(maxY);
    self.y = maxY - self.height;
}

- (void)setWidth:(CGFloat)width
{
    ZZ_assertFloatIsnan(width);
    CGRect customFrame = self.frame;
    customFrame.size.width = width;
    self.frame = customFrame;
}

- (void)setHeight:(CGFloat)height
{
    ZZ_assertFloatIsnan(height);
    CGRect customFrame = self.frame;
    customFrame.size.height = height;
    self.frame = customFrame;
}

- (void)setX:(CGFloat)x
{
    ZZ_assertFloatIsnan(x);
    CGRect customFrame = self.frame;
    customFrame.origin.x = x;
    self.frame = customFrame;
}

- (void)setY:(CGFloat)y
{
    ZZ_assertFloatIsnan(y);

    CGRect customFrame = self.frame;
    customFrame.origin.y = y;
    self.frame = customFrame;
}

- (void)setSize:(CGSize)size
{

    CGRect customFrame = self.frame;
    customFrame.size = size;
    self.frame = customFrame;
}
- (void)setOrigin:(CGPoint)origin{
    CGRect customFrame = self.frame;
    customFrame.origin = origin;
    self.frame = customFrame;
}

- (void)setCenterX:(CGFloat)centerX
{
    ZZ_assertFloatIsnan(centerX);

    CGPoint tempCenter = self.center;
    tempCenter.x = centerX;
    self.center = tempCenter;
}

- (void)setCenterY:(CGFloat)centerY
{
    ZZ_assertFloatIsnan(centerY);

    CGPoint tempCenter = self.center;
    tempCenter.y = centerY;
    self.center = tempCenter;
}

#pragma mark ---
#pragma mark --- get方法

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}
- (CGPoint)origin {
    return self.frame.origin;
}


// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen
{
    if (self == nil) {
        return FALSE;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return FALSE;
    }
    
    // 若view 隐藏
    if (self.hidden) {
        return FALSE;
    }
    
    // 若没有superview
    if (self.superview == nil) {
        return FALSE;
    }
    
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  FALSE;
    }
    
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }
    
    return TRUE;
}


@end
