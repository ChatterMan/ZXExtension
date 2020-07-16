//
//  UIImage+Extension.h
//  ZXExtension
//
//  Created by Max on 2020/7/16.
//  Copyright © 2020 QNVIP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)
///根据颜色Color 和 尺寸Size 返回图片UIImage
+ (UIImage *)imageWithColor:(UIColor *)color Size:(CGSize)size;
///根据颜色Color 返回默认1*1尺寸的图片UIImage
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 压缩图片到指定大小（先压缩质量，如果还是达不到，再压缩宽高） -- 推荐 --

 @param image 目标图片
 @param maxLength 需要压缩到的byte值
 @return 压缩后的图片
 */
+ (UIImage *)imageWithCompressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;
+ (NSData *)dataWithCompressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;

// 根据指定size 使用 ImageIO 重新绘图
+ (UIImage *)compressByImageIOFromData:(NSData *)data maxPixelSize:(NSUInteger)maxPixelSize;


@end

NS_ASSUME_NONNULL_END
