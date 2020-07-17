//
//  UIImage+Extension.h
//  ZXExtension
//
//  Created by Max on 2020/7/16.
//  Copyright © 2020 QNVIP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 从(image)data获取图片格式
 */
typedef NS_ENUM(NSInteger, ZXImageType) {
    ZXImageType_JPEG,
    ZXImageType_PNG,
    ZXImageType_Unknown
};

CG_INLINE ZXImageType NSPUIImageTypeFromData(NSData *imageData) {
    if (imageData.length > 4) {
        const unsigned char * bytes = [imageData bytes];
        if (bytes[0] == 0xff &&
            bytes[1] == 0xd8 &&
            bytes[2] == 0xff) {
            return ZXImageType_JPEG;
        }
        if (bytes[0] == 0x89 &&
            bytes[1] == 0x50 &&
            bytes[2] == 0x4e &&
            bytes[3] == 0x47) {
            return ZXImageType_PNG;
        }
    }
    return ZXImageType_Unknown;
}


@interface UIImage (Extension)
/** 通过 颜色 生成图片 */
+ (UIImage *)zx_createImageWithColor:(UIColor *)color;
/** 通过 颜色/尺寸 生成图片 */
+ (UIImage *)zx_createImageWithColor:(UIColor *)color
                                size:(CGSize)size;
/** 通过 颜色/尺寸/圆角 生成图片 */
+ (UIImage *)zx_createImageWithColor:(UIColor *)color
                                size:(CGSize)size
                        cornerRadius:(CGFloat)cornerRadius;
/** 通过 颜色/尺寸/指定圆角 生成图片 */
+ (UIImage *)zx_createImageWithColor:(UIColor *)color
                                size:(CGSize)size
                        cornerRadius:(CGFloat)cornerRadius
                   byRoundingCorners:(UIRectCorner)corners;

/** 通过 渐变颜色 生成图片 */
+ (UIImage *)zx_gradientImageWithColors:(NSArray *)colors
                              locations:(NSArray *)locations
                             startPoint:(CGPoint)startPoint
                               endPoint:(CGPoint)endPoint
                                   size:(CGSize)size;
/** 通过 渐变颜色/圆角 生成图片 */
+ (UIImage *)zx_gradientImageWithColors:(NSArray *)colors
                              locations:(NSArray *)locations
                             startPoint:(CGPoint)startPoint
                               endPoint:(CGPoint)endPoint
                                   size:(CGSize)size
                           cornerRadius:(CGFloat)cornerRadius;
/** 通过 渐变颜色/圆角数值/指定圆角 生成图片 */
+ (UIImage *)zx_gradientImageWithColors:(NSArray *)colors
                              locations:(NSArray *)locations
                             startPoint:(CGPoint)startPoint
                               endPoint:(CGPoint)endPoint
                                   size:(CGSize)size
                           cornerRadius:(CGFloat)cornerRadius
                      byRoundingCorners:(UIRectCorner)corners;

/**
 压缩图片到指定大小（先压缩质量，如果还是达不到，再压缩宽高） -- 推荐 --

 @param image 目标图片
 @param maxLength 需要压缩到的byte值
 @return 压缩后的图片
 */
+ (UIImage *)zx_imageCompressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;
///压缩图片到指定大小（先压缩质量，如果还是达不到，再压缩宽高） 返回NSData
+ (NSData *)zx_dataCompressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;

// 根据指定size 使用 ImageIO 重新绘图
+ (UIImage *)zx_compressByImageIOFromData:(NSData *)data maxPixelSize:(NSUInteger)maxPixelSize;


/** 修正图片的方向 */
- (UIImage *)zx_fixOrientation;
/** 按指定方向旋转图片 */
- (UIImage *)zx_rotate:(UIImageOrientation)orientation;

/** 裁剪图片 */
- (UIImage *)zx_clipImageInRect:(CGRect)rect scale:(CGFloat)scale;

/** 图片中间区域切圆 */
- (UIImage *)zx_imageByRoundWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/** UI缩略（按比例缩略） */
- (UIImage *)zx_uiResizeImageWithScale:(CGFloat)scale;
/** UI缩略（按逻辑宽度缩略） */
- (UIImage *)zx_uiResizeImageWithLogicWidth:(CGFloat)logicWidth;
/** UI缩略（按像素宽度缩略） */
- (UIImage *)zx_uiResizeImageWithPixelWidth:(CGFloat)pixelWidth;

/** CG缩略（按比例缩略） */
- (UIImage *)zx_cgResizeImageWithScale:(CGFloat)scale;
/** CG缩略（按逻辑宽度缩略） */
- (UIImage *)zx_cgResizeImageWithLogicWidth:(CGFloat)logicWidth;
/** CG缩略（按像素宽度缩略） */
- (UIImage *)zx_cgResizeImageWithPixelWidth:(CGFloat)pixelWidth;

/** IO缩略（按比例缩略） */
- (UIImage *)zx_ioResizeImageWithScale:(CGFloat)scale isPNGType:(BOOL)isPNGType;
/** IO缩略（按逻辑宽度缩略） */
- (UIImage *)zx_ioResizeImageWithLogicWidth:(CGFloat)logicWidth isPNGType:(BOOL)isPNGType;
/** IO缩略（按像素宽度缩略） */
- (UIImage *)zx_ioResizeImageWithPixelWidth:(CGFloat)pixelWidth isPNGType:(BOOL)isPNGType;

/** 图片宽高比 */
- (CGFloat)zx_whRatio;
/** 图片高宽比 */
- (CGFloat)zx_hwRatio;

@end

NS_ASSUME_NONNULL_END
