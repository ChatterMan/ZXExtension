//
//  UIColor+Extension.h
//  ZXExtension
//
//  Created by Max on 2020/7/16.
//  Copyright © 2020 QNVIP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extension)

+ (UIColor *)zx_colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;
+ (UIColor *)zx_colorWithHexString:(NSString *)hexStr;
+ (UIColor *)zx_randomColor;
+ (UIColor *)zx_gradientColorWithColors:(NSArray *)colors locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint size:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
