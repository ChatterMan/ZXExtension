//
//  UIImage+Extension.m
//  ZXExtension
//
//  Created by Max on 2020/7/16.
//  Copyright © 2020 QNVIP. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)zx_createImageWithColor:(UIColor *)color {
    return [self zx_createImageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)zx_createImageWithColor:(UIColor *)color
                                size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)zx_createImageWithColor:(UIColor *)color
                                size:(CGSize)size
                        cornerRadius:(CGFloat)cornerRadius {
    return [self zx_createImageWithColor:color
                                    size:size
                            cornerRadius:cornerRadius
                       byRoundingCorners:UIRectCornerAllCorners];
}

+ (UIImage *)zx_createImageWithColor:(UIColor *)color
                                size:(CGSize)size
                        cornerRadius:(CGFloat)cornerRadius
                   byRoundingCorners:(UIRectCorner)corners {
    if (cornerRadius == 0) {
        return [self zx_createImageWithColor:color size:size];
    }
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, size.width, size.height);
    layer.backgroundColor = color.CGColor;
    layer.masksToBounds = YES;
    if (cornerRadius > 0) {
        if (corners == UIRectCornerAllCorners) {
            layer.cornerRadius = cornerRadius;
        } else {
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:layer.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)].CGPath;
            layer.mask = maskLayer;
        }
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)zx_gradientImageWithColors:(NSArray *)colors
                              locations:(NSArray *)locations
                             startPoint:(CGPoint)startPoint
                               endPoint:(CGPoint)endPoint
                                   size:(CGSize)size {
    return [self zx_gradientImageWithColors:colors
                                  locations:locations
                                 startPoint:startPoint
                                   endPoint:endPoint
                                       size:size
                               cornerRadius:0];
}

+ (UIImage *)zx_gradientImageWithColors:(NSArray *)colors
                              locations:(NSArray *)locations
                             startPoint:(CGPoint)startPoint
                               endPoint:(CGPoint)endPoint
                                   size:(CGSize)size
                           cornerRadius:(CGFloat)cornerRadius {
    return [self zx_gradientImageWithColors:colors
                                  locations:locations
                                 startPoint:startPoint
                                   endPoint:endPoint
                                       size:size
                               cornerRadius:cornerRadius
                          byRoundingCorners:UIRectCornerAllCorners];
}

+ (UIImage *)zx_gradientImageWithColors:(NSArray *)colors
                              locations:(NSArray *)locations
                             startPoint:(CGPoint)startPoint
                               endPoint:(CGPoint)endPoint
                                   size:(CGSize)size
                           cornerRadius:(CGFloat)cornerRadius
                      byRoundingCorners:(UIRectCorner)corners {
    if (colors.count == 0) return nil;
    UIImage *gradientImage;
    if (colors.count == 1) {
        UIColor *color = [UIColor colorWithCGColor:(__bridge CGColorRef)(colors.firstObject)];
        gradientImage = [self zx_createImageWithColor:color
                                                 size:size
                                         cornerRadius:cornerRadius
                                    byRoundingCorners:corners];
    } else {
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        CAGradientLayer *gLayer = [CAGradientLayer layer];
        gLayer.masksToBounds = YES;
        gLayer.bounds = CGRectMake(0, 0, size.width, size.height);
        gLayer.startPoint = startPoint;
        gLayer.endPoint = endPoint;
        gLayer.colors = colors;
        if (locations) gLayer.locations = locations;
        if (cornerRadius > 0) {
            if (corners == UIRectCornerAllCorners) {
                gLayer.cornerRadius = cornerRadius;
            } else {
                CAShapeLayer *maskLayer = [CAShapeLayer layer];
                maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:gLayer.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)].CGPath;
                gLayer.mask = maskLayer;
            }
        }
        [gLayer renderInContext:UIGraphicsGetCurrentContext()];
        gradientImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return gradientImage;
}




/**
 压缩图片到指定大小（先压缩质量，如果还是达不到，再压缩宽高） -- 推荐 --

 @param image 目标图片
 @param maxLength 需要压缩到的byte值
 @return 压缩后的图片
 */
+ (UIImage *)zx_imageCompressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength
{
    
    NSData *data = [self zx_dataCompressImageQuality:image toByte:maxLength];
    
    UIImage *resultImage = [UIImage imageWithData:data];
    
    return resultImage;
}

+ (NSData *)zx_dataCompressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) {
        return data;
    }
    CGFloat max = 1;
    CGFloat min = 0;
    // 二分最大10次，区间范围精度最大可达0.00097657；第6次，精度可达0.015625，10次，0.000977
    for (int i = 0; i < 10; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    
    // 如果二分法之后，还是不符合大小
    if (data.length > maxLength) {
        
        UIImage *resultImage = [UIImage imageWithData:data];
        while (data.length > maxLength) {
            @autoreleasepool {
                CGFloat ratio = (CGFloat)maxLength / data.length;
                // 使用NSUInteger不然由于精度问题，某些图片会有白边
                CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                         (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
                resultImage = [self zx_compressByImageIOFromData:data maxPixelSize:MAX(size.width, size.height)];
                data = UIImageJPEGRepresentation(resultImage, compression);
            }
        }
    }
    
    return data;
}

// 根据指定size 使用 ImageIO 重新绘图
+ (UIImage *)zx_compressByImageIOFromData:(NSData *)data maxPixelSize:(NSUInteger)maxPixelSize
{
    UIImage *imgResult = nil;
    
    if (data == nil) {
        return imgResult;
    }
    if (data.length <= 0) {
        return imgResult;
    }
    if (maxPixelSize <= 0) {
        return imgResult;
    }
    
    const float scale = [UIScreen mainScreen].scale;
    const int sizeTo = maxPixelSize * scale;
    CFDataRef dataRef = (__bridge CFDataRef)data;

    CFDictionaryRef dicOptionsRef = (__bridge CFDictionaryRef) @{
                                                                 (id)kCGImageSourceCreateThumbnailFromImageIfAbsent : @(YES),
                                                                 (id)kCGImageSourceThumbnailMaxPixelSize : @(sizeTo),
                                                                 (id)kCGImageSourceShouldCache : @(YES),
                                                                 };
    CGImageSourceRef src = CGImageSourceCreateWithData(dataRef, nil);
    // 注意：如果设置 kCGImageSourceCreateThumbnailFromImageIfAbsent为 NO，那么 CGImageSourceCreateThumbnailAtIndex 会返回nil
    CGImageRef thumImg = CGImageSourceCreateThumbnailAtIndex(src, 0, dicOptionsRef);
    
    CFRelease(src); // 注意释放对象，否则会产生内存泄露
    
    imgResult = [UIImage imageWithCGImage:thumImg scale:scale orientation:UIImageOrientationUp];
    
    if (thumImg != nil) {
        // 注意释放对象，否则会产生内存泄露
        CFRelease(thumImg);
    }
    
    return imgResult;
}

/** 修正图片的方向 */
- (UIImage *)zx_fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp)
        return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
/** 按指定方向旋转图片 */
- (UIImage *)zx_rotate:(UIImageOrientation)orientation {
    
    CGImageRef imageRef = self.CGImage;
    CGRect bounds = CGRectMake(0, 0, CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
    CGRect rect = bounds;
    CGAffineTransform transform = CGAffineTransformIdentity;

    switch (orientation)
    {
        case UIImageOrientationUp:
            return self;
            
        case UIImageOrientationUpMirrored:
            transform = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(rect.size.width, rect.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformMakeTranslation(0.0, rect.size.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeft:
            bounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.height, bounds.size.width);
            transform = CGAffineTransformMakeTranslation(0.0, rect.size.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeftMirrored:
            bounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.height, bounds.size.width);
            transform = CGAffineTransformMakeTranslation(rect.size.height, rect.size.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRight:
            bounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.height, bounds.size.width);
            transform = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored:
            bounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.height, bounds.size.width);
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            return self;
    }
    
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    switch (orientation)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextScaleCTM(ctx, -1.0, 1.0);
            CGContextTranslateCTM(ctx, -rect.size.height, 0.0);
            break;
            
        default:
            CGContextScaleCTM(ctx, 1.0, -1.0);
            CGContextTranslateCTM(ctx, 0.0, -rect.size.height);
            break;
    }
    
    CGContextConcatCTM(ctx, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, imageRef);
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/** 裁剪Image */
- (UIImage *)zx_clipImageInRect:(CGRect)rect scale:(CGFloat)scale {
    
    CGFloat x = rect.origin.x * scale;
    CGFloat y = rect.origin.y * scale;
    CGFloat w = rect.size.width * scale;
    CGFloat h = rect.size.height * scale;
    CGRect cgRect = CGRectMake(x, y, w, h);
    
    @autoreleasepool {
        CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, cgRect);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        return image;
    }
    
}
/** 图片中间区域切圆 */
- (UIImage *)zx_imageByRoundWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    CGFloat w = self.size.width;
    CGFloat h = self.size.height;
    CGFloat minSide = MIN(w, h);
    CGFloat cornerRadius = minSide * 0.5;
    CGSize size = CGSizeMake(minSide, minSide);
    
    if (borderWidth >= cornerRadius) return self;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -size.height);
    
    UIRectCorner corners = UIRectCornerAllCorners;
    CGRect roundRect = (CGRect){CGPointZero, size};
    
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:roundRect byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, 0)];
    [roundPath closePath];
    [roundPath addClip];
    
    CGRect rect = (CGRect){CGPointMake((size.width - w) * 0.5, (size.height - h) * 0.5), self.size};
    CGContextDrawImage(context, rect, self.CGImage);
    
    if (borderWidth > 0 && borderColor) {
        CGFloat strokeInset = borderWidth * 0.5;
        CGRect strokeRect = CGRectInset(roundRect, strokeInset, strokeInset);
        CGFloat strokeRadius = strokeRect.size.width * 0.5;
        
        UIBezierPath *strokePath = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius, 0)];
        [strokePath closePath];
        strokePath.lineWidth = borderWidth;
        
        [borderColor setStroke];
        [strokePath stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** UI缩略（按比例缩略） */
- (UIImage *)zx_uiResizeImageWithScale:(CGFloat)scale {
    return [self zx_uiResizeImageWithLogicWidth:(self.size.width * scale)];
}

/** UI缩略（按逻辑宽度缩略） */
- (UIImage *)zx_uiResizeImageWithLogicWidth:(CGFloat)logicWidth {
    if (logicWidth >= self.size.width) return self;
    CGFloat w = logicWidth;
    CGFloat h = w * self.zx_hwRatio;
    @autoreleasepool {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, h), NO, self.scale);
        [self drawInRect:CGRectMake(0, 0, w, h)];
        UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return resizedImage;
    }
}

/** UI缩略（按像素宽度缩略） */
- (UIImage *)zx_uiResizeImageWithPixelWidth:(CGFloat)pixelWidth {
    return [self zx_uiResizeImageWithLogicWidth:(pixelWidth / self.scale)];
}

/** CG缩略（按比例缩略） */
- (UIImage *)zx_cgResizeImageWithScale:(CGFloat)scale {
    return [self zx_cgResizeImageWithLogicWidth:(self.size.width * scale)];
}

/** CG缩略（按逻辑宽度缩略） */
- (UIImage *)zx_cgResizeImageWithLogicWidth:(CGFloat)logicWidth {
    return [self zx_cgResizeImageWithPixelWidth:(logicWidth * self.scale)];
}

/** CG缩略（按像素宽度缩略） */
- (UIImage *)zx_cgResizeImageWithPixelWidth:(CGFloat)pixelWidth {
    CGImageRef cgImage = self.CGImage;
    if (!cgImage) return self;
    
    if (pixelWidth >= (self.size.width * self.scale)) return self;
    CGFloat pixelHeight = pixelWidth * self.zx_hwRatio;
    
//    size_t bitsPerComponent = CGImageGetBitsPerComponent(cgImage);
//    size_t bytesPerRow = CGImageGetBytesPerRow(cgImage);
//    CGColorSpaceRef colorSpace = CGImageGetColorSpace(cgImage);
//    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(cgImage);
//    CGContextRef context = CGBitmapContextCreate(NULL, pixelWidth, pixelHeight, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo);
    /**
     * 在某些手机快捷键屏幕截图生成的图片，通过上面方式创建的 context 为空
     * 因为生成的图片的 CGBitmapInfo 为 kCGImageAlphaLast 或 kCGImageByteOrder16Little，iOS不支持这种格式。
     * 参考：https://www.jianshu.com/p/2e45a2ea7b62
     * 解决方法：context 的创建采用了 YYKit 的方式。
     */
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(cgImage) & kCGBitmapAlphaInfoMask;
    BOOL hasAlpha = NO;
    if (alphaInfo == kCGImageAlphaPremultipliedLast ||
        alphaInfo == kCGImageAlphaPremultipliedFirst ||
        alphaInfo == kCGImageAlphaLast ||
        alphaInfo == kCGImageAlphaFirst) {
        hasAlpha = YES;
    }
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Host;
    bitmapInfo |= hasAlpha ? kCGImageAlphaPremultipliedFirst : kCGImageAlphaNoneSkipFirst;
    
    CGContextRef context = CGBitmapContextCreate(NULL, pixelWidth, pixelHeight, 8, 0, colorSpace, bitmapInfo);
    
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextDrawImage(context, CGRectMake(0, 0, pixelWidth, pixelHeight), cgImage);
    CGImageRef resizedCGImage = CGBitmapContextCreateImage(context);
    
    UIImage *resizedImage = [UIImage imageWithCGImage:resizedCGImage scale:self.scale orientation:self.imageOrientation];
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CGImageRelease(resizedCGImage);
    
    return resizedImage;
}

/** IO缩略（按比例缩略） */
- (UIImage *)zx_ioResizeImageWithScale:(CGFloat)scale isPNGType:(BOOL)isPNGType {
    return [self zx_ioResizeImageWithLogicWidth:(self.size.width * scale) isPNGType:isPNGType];
}

/** IO缩略（按逻辑宽度缩略） */
- (UIImage *)zx_ioResizeImageWithLogicWidth:(CGFloat)logicWidth isPNGType:(BOOL)isPNGType {
    return [self zx_ioResizeImageWithPixelWidth:(logicWidth * self.scale) isPNGType:isPNGType];
}

/** IO缩略（按像素宽度缩略） */
- (UIImage *)zx_ioResizeImageWithPixelWidth:(CGFloat)pixelWidth isPNGType:(BOOL)isPNGType {
    if (pixelWidth >= (self.size.width * self.scale)) return self;
    
    NSData *data = isPNGType ? UIImagePNGRepresentation(self) : UIImageJPEGRepresentation(self, 1);
    if (!data) return nil;
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)data, nil);
    
    CGFloat maxPixelValue = (self.zx_hwRatio > 1.0) ? (pixelWidth * self.zx_hwRatio) : pixelWidth;
    // 因为kCGImageSourceCreateThumbnailFromImageAlways会一直创建缩略图，造成内存浪费
    // 所以使用kCGImageSourceCreateThumbnailFromImageIfAbsent
    NSDictionary *options = @{(id)kCGImageSourceCreateThumbnailWithTransform : @(YES),
                              (id)kCGImageSourceCreateThumbnailFromImageIfAbsent : @(YES),
                              (id)kCGImageSourceThumbnailMaxPixelSize : @(maxPixelValue)};
    
    CGImageRef resizedCGImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, (CFDictionaryRef)options);
    UIImage *resizedImage = [UIImage imageWithCGImage:resizedCGImage scale:self.scale orientation:self.imageOrientation];
    
    CFRelease(imageSource);
    CGImageRelease(resizedCGImage);
    
    return resizedImage;
}

- (CGFloat)zx_whRatio {
    return (self.size.width / self.size.height);
}

- (CGFloat)zx_hwRatio {
    return (self.size.height / self.size.width);
}

@end
