//
//  UIColor+Extension.m
//  ZXExtension
//
//  Created by Max on 2020/7/16.
//  Copyright © 2020 QNVIP. All rights reserved.
//

#import "UIColor+Extension.h"
#import "UIImage+Extension.h"
@implementation UIColor (Extension)

+ (UIColor *)zx_colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha {
    NSString *cString = [[hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 charactersif ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appearsif ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)zx_colorWithHexString:(NSString *)hexStr {
    return [self zx_colorWithHexString:hexStr alpha:1.0f];
}


+ (UIColor *)zx_randomColor {
    //detail implementation
    //arc4random() % 78 will return a number between 0 and 77, for example.
    CGFloat hue = arc4random() % 100 / 100.0; //色调：0.0 ~ 1.0
    CGFloat saturation = (arc4random() % 50 / 100) + 0.5; //饱和度：0.5 ~ 1.0
    CGFloat brightness = (arc4random() % 50 / 100) + 0.5; //亮度：0.5 ~ 1.0
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


+ (UIColor *)zx_gradientColorWithColors:(NSArray *)colors locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint size:(CGSize)size {
    if (colors.count == 0) return nil;
    if (colors.count == 1) {
        CGColorRef cgColor = (__bridge CGColorRef)(colors.firstObject);
        return [UIColor colorWithCGColor:cgColor];
    }
    UIImage *patternImage = [UIImage zx_gradientImageWithColors:colors locations:locations startPoint:startPoint endPoint:endPoint size:size];
    return [UIColor colorWithPatternImage:patternImage];
}

@end
