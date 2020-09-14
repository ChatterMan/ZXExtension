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



/*!
 * 对象序列成字典
 *
 * @param obj 需要序列化的对象
 *
 * @return 字典
 */
+ (NSDictionary*)zx_getDictionaryFromObject:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++) {
        objc_property_t prop = props[i];
        id value = nil;
 
        @try {
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
            value = [self zx_getObjectInternal:[obj valueForKey:propName]];
            if(value != nil) {
                [dic setObject:value forKey:propName];
            }
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
 
    }
    free(props);
    return dic;
}
 
+ (id)zx_getObjectInternal:(id)obj
{
    if(!obj
       || [obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]]) {
        return obj;
    }
 
    if([obj isKindOfClass:[NSArray class]]) {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++) {
            [arr setObject:[self zx_getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
 
    if([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys) {
            [dic setObject:[self zx_getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self zx_getDictionaryFromObject:obj];
}

@end
