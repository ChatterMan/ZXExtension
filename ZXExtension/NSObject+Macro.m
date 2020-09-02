//
//  NSObject+Macro.m
//  ZXExtension
//
//  Created by Max on 2020/7/16.
//  Copyright © 2020 QNVIP. All rights reserved.
//

#import "NSObject+Macro.h"

@implementation NSObject (Macro)
- (CGFloat)zx_statusBarHight; {
    float statusBarHeight = 0.f;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    }
    else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}

- (UIWindow *)zx_keyWindow {
    if (@available(iOS 13.0, *)) {
        return [UIApplication sharedApplication].windows.firstObject;
    }
    else {
        return [UIApplication sharedApplication].keyWindow;
    }
}

- (UIEdgeInsets)zx_safeAreaInserts {
    UIWindow *window = [self zx_keyWindow];
    
    if (@available(iOS 11.0, *)) {
        return window.safeAreaInsets;
    } else {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}




@end
