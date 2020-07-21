//
//  NSString+Extension.h
//  ZXExtension
//
//  Created by Max on 2020/7/16.
//  Copyright © 2020 QNVIP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

+ (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font;
+ (CGFloat)getHeightWithText:(NSString *)text width:(CGFloat)width font:(CGFloat)font;

+ (CGFloat)getFontWidthWithText:(NSString *)text height:(CGFloat)height font:(UIFont *)font;
+ (CGFloat)getFontHeightWithText:(NSString *)text width:(CGFloat)width font:(UIFont *)font;

/// 获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)FirstCharactor:(NSString *)pString;

/// 去掉整段文字内的所有空白字符（包括换行符）
@property(readonly, copy) NSString *zx_trimAllWhiteSpace;

/// 把该字符串转换为对应的 md5
@property(readonly, copy) NSString *zx_md5;

@end

NS_ASSUME_NONNULL_END
