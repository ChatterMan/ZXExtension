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
@end

NS_ASSUME_NONNULL_END
