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

+ (UIColor *)hexStringToColor:(NSString *)string;

+ (UIColor *)randomColor;

@end

NS_ASSUME_NONNULL_END
