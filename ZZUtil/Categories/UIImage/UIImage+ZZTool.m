//
//  UIImage+tool.m
//  QQ
//
//  Created by My Mac OS on 14-8-26.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+ZZTool.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (ZZTool)

+ (UIImage *)resizableImageWithString:(NSString *)imageName{
    
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat w = image.size.width*0.5;
    CGFloat h = image.size.height*0.5;

    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}


/** 截取指定视图中的图像 */
+ (UIImage *)captureImageWithView:(UIView *)view
{
    // 1. 开启图像上下文
    UIGraphicsBeginImageContext(view.bounds.size);
    
    // *** 一旦开启了图像上下文，现在再获取到的上下文，就是图像上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2. 绘图=>将视图(图层)中的所有内容，“渲染=>”输出到上下文中
    [view.layer renderInContext:ctx];
    
    // 3. 从图像上下文中取出结果
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4. 关闭上下文
    UIGraphicsEndImageContext();
    
    return result;
}

+ (instancetype)waterImageWithBg:(NSString *)bg logo:(NSString *)logo
{
    UIImage *bgImage = [UIImage imageNamed:bg];
    
    // 1.创建一个基于位图的上下文(开启一个基于位图的上下文)
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    
    // 2.画背景
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    // 3.画右下角的水印
    UIImage *waterImage = [UIImage imageNamed:logo];
    CGFloat scale = 0.2;
    CGFloat margin = 5;
    CGFloat waterW = waterImage.size.width * scale;
    CGFloat waterH = waterImage.size.height * scale;
    CGFloat waterX = bgImage.size.width - waterW - margin;
    CGFloat waterY = bgImage.size.height - waterH - margin;
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    
    // 4.从上下文中取得制作完毕的UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)waterImageWithBgImageName:(NSString *)bg text:(NSString *)text
{
    UIImage *image = [UIImage imageNamed:bg];
    
    // 创建图像的大小
    CGSize size = CGSizeMake(200, 200);
    // 水印文字与边框的间距
    CGFloat padding = 10;
    
    // 1. 开启图像的上下文之后，所有的绘制方法，都会画到这个上下文中
    UIGraphicsBeginImageContext(size);
    
    // 2.1 绘制图像
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 2.2 绘制文本
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor redColor]};
    // 计算文本占用区域，r.x = 0, r.y = 0
    CGRect r = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    
    r.origin.x = size.width - r.size.width - padding;
    r.origin.y = size.height - r.size.height - padding;
    
    [text drawInRect:r withAttributes:dict];
    
    // 3. 从上下文中拿到绘制结果
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4. 关闭上下文
    UIGraphicsEndImageContext();
    
    return result;
}

// 截取圆形图片
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    
    return [self circleImage:[UIImage imageNamed:name] borderWidth:borderWidth borderColor:borderColor];
}

+ (instancetype)circleImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    // 1.加载原图
    UIImage *oldImage = image;
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}



// 截取view，返回一个PNG图片
+ (instancetype)captureWithView:(UIView *)view
{
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    // 2.将控制器view的layer渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}



#pragma mark -
#pragma mark - 拉伸

- (UIImage *)stretchableImage:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight {
    
    UIImage *tempImage = nil;
    
    double systemVersion = [[[UIDevice currentDevice] systemVersion] doubleValue];
    if (systemVersion < 5) {
        tempImage = [self stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    }
    else {
        CGSize size = self.size;
        double rightCapWidth = size.width - leftCapWidth - 1;
        double bottomCapHeight = size.height - topCapHeight - 1;
        
        UIEdgeInsets insets = UIEdgeInsetsMake(topCapHeight, leftCapWidth, bottomCapHeight, rightCapWidth);
        tempImage = [self resizableImageWithCapInsets:insets];
    }
    
    return tempImage;
}


#pragma mark -
#pragma mark - 平铺

- (UIColor *)patternColor {
    UIColor *color = [UIColor colorWithPatternImage:self];
    
    return color;
}

+ (UIColor *)patternColor:(NSString *)patternImageName {
    UIImage *image = [UIImage imageNamed:patternImageName];
    UIColor *color = [image patternColor];
    
    return color;
}

- (UIImage *)tileImage:(CGSize)size {
    CGSize finalSize = size;
    
    UIGraphicsBeginImageContext(finalSize);
    
    CGRect originalRect;
    originalRect.origin = CGPointMake(0.0, 0.0);
    originalRect.size = CGSizeMake(self.size.width, self.size.height);
    
    CGContextRef imageContext = UIGraphicsGetCurrentContext();
    CGContextDrawTiledImage(imageContext, originalRect, self.CGImage);
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return finalImage;
}

+ (UIImage *)tileImage:(NSString *)imageName size:(CGSize)size {
    if ([imageName length] == 0) {
        return nil;
    }
    
    UIImage *originalImage = [UIImage imageNamed:imageName];
    UIImage *finalImage = [originalImage tileImage:size];
    
    return finalImage;
}

+(UIImage*)getImageWithIphoneImage:(UIImage *)iphoneImage andIpadImage:(UIImage *)ipadImage
{
#ifdef LT_IPAD_CLIENT
    return ipadImage;
#else
    return iphoneImage;
#endif
}

/**
 函数功能:
 获得一个有毛玻璃效果的UIImage
 */
+ (UIImage *)blurryImage:(CIColor *)color size:(CGSize)aSize
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *image = [CIImage imageWithColor:color];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@2.0f forKey: @"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:CGRectMake(0, 0,aSize.width, aSize.height)];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    return blurImage;
}


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [color set];
    CGContextFillRect(context, CGRectMake(.0, .0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    @try {
        //        error = vImageBoxConvolve_ARGB8888(&inBuffer,
        //                                           &outBuffer,
        //                                           NULL,
        //                                           0,
        //                                           0,
        //                                           boxSize,
        //                                           boxSize,
        //                                           NULL,
        //                                           kvImageEdgeExtend);
    } @catch (NSException *exception) {
        error = 0;
    } @finally {
        
    }
    
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

// 内部方法,核心代码,封装了毛玻璃效果 参数:半径,颜色,色彩饱和度
- (UIImage *)imageBluredWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage {
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (short)radius, (short)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, (short)radius, (short)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (short)radius, (short)radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // 开启上下文 用于输出图像
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // 开始画底图
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // 开始画模糊效果
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // 添加颜色渲染
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // 输出成品,并关闭上下文
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

/**
 *  用Quart2D画一个自定义颜色图形
 *
 *  @param color 要画上去的颜色
 *
 *  @return UIImage对象
 */
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGFloat imageW = 10;
    CGFloat imageH = 10;
    // 1.开启基于位图的图形上下文，这个方法画图比较清晰，，NO代表透明，YES代表不透明,0.0代表伸缩属性
    // UIGraphicsBeginImageContext(<#CGSize size#>);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    
    // 2.画一个color颜色的矩形框
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    
    // 3.拿到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
