//
//  UIImage+Extension.m
//  ZXExtension
//
//  Created by Max on 2020/7/16.
//  Copyright © 2020 QNVIP. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)imageWithColor:(UIColor *)color Size:(CGSize)size
{

    CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);

    UIGraphicsBeginImageContext(size);

    CGContextRef ref = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(ref, [color CGColor]);

    CGContextFillRect(ref, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return image;

}

+ (UIImage *)imageWithColor:(UIColor *)color
{

    CGRect rect = CGRectMake(0.0, 0.0, 1.f, 1.f);

    UIGraphicsBeginImageContext(CGSizeMake(1.f, 1.f));

    CGContextRef ref = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(ref, [color CGColor]);

    CGContextFillRect(ref, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return image;

}




/**
 压缩图片到指定大小（先压缩质量，如果还是达不到，再压缩宽高） -- 推荐 --

 @param image 目标图片
 @param maxLength 需要压缩到的byte值
 @return 压缩后的图片
 */
+ (UIImage *)imageWithCompressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength
{
    
    NSData *data = [self dataWithCompressImageQuality:image toByte:maxLength];
    
    UIImage *resultImage = [UIImage imageWithData:data];
    
    return resultImage;
}

+ (NSData *)dataWithCompressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
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
                resultImage = [self compressByImageIOFromData:data maxPixelSize:MAX(size.width, size.height)];
                data = UIImageJPEGRepresentation(resultImage, compression);
            }
        }
    }
    
    return data;
}

// 根据指定size 使用 ImageIO 重新绘图
+ (UIImage *)compressByImageIOFromData:(NSData *)data maxPixelSize:(NSUInteger)maxPixelSize
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

@end
