//
//  NSObject+Extension.h
//  ZXExtension
//
//  Created by Max on 2020/7/16.
//  Copyright © 2020 QNVIP. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Extension)

+ (NSString *)zx_className;
- (NSString *)zx_className;

+ (void)zx_swizzleInstanceMethodsWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
+ (void)zx_swizzleClassMethodsWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

/**
 返回值 -   0 [相等]  1 [version1 大]  2 [version2 大]
  @param version1 版本号
  @param version2 版本号
 */
+ (NSInteger)compareVersion1:(NSString *)version1 version2:(NSString *)version2;
- (NSInteger)compareVersion1:(NSString *)version1 version2:(NSString *)version2;

/*!
 * 对象序列成字典
 *
 * @param obj 需要序列化的对象
 *
 * @return 字典
 */
+ (NSDictionary*)zx_getDictionaryFromObject:(id)obj;



@end

NS_ASSUME_NONNULL_END
