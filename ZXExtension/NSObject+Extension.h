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

@end

NS_ASSUME_NONNULL_END
