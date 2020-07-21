//
//  NSObject+Extension.m
//  ZXExtension
//
//  Created by Max on 2020/7/16.
//  Copyright © 2020 QNVIP. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>
@implementation NSObject (Extension)
+ (NSString *)zx_className {
    return NSStringFromClass(self);
}
- (NSString *)zx_className {
    return NSStringFromClass(self.class);
}

+ (void)zx_swizzleInstanceMethodsWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}
+ (void)zx_swizzleClassMethodsWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Class metaCls = object_getClass(self);
    Method originalMethod = class_getClassMethod(metaCls, originalSelector);
    Method swizzledMethod = class_getClassMethod(metaCls, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (NSInteger)compareVersion1:(NSString *)version1 version2:(NSString *)version2 {
    
    if (version1 == version2) {
        NSLog(@"version1:%@ == version2:%@",version1,version2);
        return 0;
    }
    if ([version1 compare:version2 options:NSNumericSearch] == NSOrderedDescending)
    {
        NSLog(@"%@ is bigger",version1);
        return 1;
    } else {
        NSLog(@"%@ is bigger",version2);
        return 2;
        
    }
    
}

- (NSInteger)compareVersion1:(NSString *)version1 version2:(NSString *)version2 {
    
    if (version1 == version2) {
        NSLog(@"version1:%@ == version2:%@",version1,version2);
        return 0;
    }
    if ([version1 compare:version2 options:NSNumericSearch] == NSOrderedDescending)
    {
        NSLog(@"%@ is bigger",version1);
        return 1;
    } else {
        NSLog(@"%@ is bigger",version2);
        return 2;
        
    }
    
}

@end
