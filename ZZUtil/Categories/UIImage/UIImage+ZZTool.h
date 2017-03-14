//
//  UIImage+tool.h
//  QQ
//
//  Created by My Mac OS on 14-8-26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZZTool)

/**
 * 传入一个图像名字，返回一个经过（极限）拉伸的图像
 */
+ (UIImage *)resizableImageWithString:(NSString *)imageName;


/** 截取指定视图中的图像 */
+ (UIImage *)captureImageWithView:(UIView *)view;


/**
 *  打图片水印
 *
 *  @param bg   背景图片 默认大小为图片大小
 *  @param logo 右下角的水印图片
 */
+ (instancetype)waterImageWithBg:(NSString *)bg logo:(NSString *)logo;

/**
 *  打文字水印
 *
 *  @param bg   背景图片 默认大小为200*200
 *  @param text 右下角度的水印文字 默认文字为红色
 */
+ (UIImage *)waterImageWithBgImageName:(NSString *)bg text:(NSString *)text;

/**
 *  带边框的图片裁减成圆形，直径为图片宽度（包括边框宽度）
 *
 *  @param name        裁减圆形图片
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 带边框的被裁减成圆形的图片UIImage对象
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

+ (instancetype)circleImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  截屏
 *
 *  @param view 要被截取的那个view上的视图
 *
 *  @return UIImage对象
 */
+ (instancetype)captureWithView:(UIView *)view;


#pragma mark -
#pragma mark - 拉伸

/**
 函数功能：
 拉伸图片
 参数说明：
 leftCapWidth:左端盖距离
 topCapHeight:右端盖距离
 返回值：
 具有拉伸属性的图片
 */
- (UIImage *)stretchableImage:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;


#pragma mark -
#pragma mark - 平铺

/**
 函数功能：
 将模板图片生成颜色模板
 参数说明：
 无
 返回值：
 颜色模板
 */
- (UIColor *)patternColor;

/**
 函数功能：
 将模板图片生成颜色模板
 参数说明：
 patternImageName:模板图片名字
 返回值：
 颜色模板
 */
+ (UIColor *)patternColor:(NSString *)patternImageName;

/**
 函数功能:
 把一个模式图片平铺成指定的大小
 参数说明:
 size:要平铺到的大小
 返回值:
 平铺后的图片
 */
- (UIImage *)tileImage:(CGSize)size;

/**
 函数功能:
 把一个模式图片平铺成指定的大小
 参数说明:
 imageName:要平铺的图片
 size:要平铺到的大小
 返回值:
 平铺后的图片
 */
+ (UIImage *)tileImage:(NSString *)imageName size:(CGSize)size;


+ (UIImage *)getImageWithIphoneImage:(UIImage*)iphoneImage  andIpadImage:(UIImage*)ipadImage;

/**
 函数功能:
 获得一个有毛玻璃效果的UIImage
 */
+ (UIImage *)blurryImage:(CIColor *)color size:(CGSize)aSize;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

/** 内部方法,核心代码,封装了毛玻璃效果 参数:半径,颜色,色彩饱和度 */
/**
 *  内部方法,核心代码,封装了毛玻璃效果
 *
 *  @param blurRadius            半径
 *  @param tintColor             颜色
 *  @param saturationDeltaFactor 色彩饱和度
 *  @param maskImage             Image
 *
 *  @return Image
 */
- (UIImage *)imageBluredWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;


/**
 *  用Quart2D画一个自定义颜色图形,size为：@{10,10}
 *
 *  @param color 要画上去的颜色
 *
 *  @return UIImage对象
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
