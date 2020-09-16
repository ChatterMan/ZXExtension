//
//  NSObject+Macro.h
//  ZXExtension
//
//  Created by Max on 2020/7/16.
//  Copyright © 2020 QNVIP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#pragma mark - 屏幕坐标

#define kSTATUSBAR_HEIGHT [self zx_statusBarHight]
#define kSCREEN_BOUNDS [UIScreen mainScreen].bounds
#define kSCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define kSCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

#pragma mark - 图片加载
// 加载图片
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
// 读取本地图片 （文件名，后缀名）
#define kGetBundleImage(__FILENAME__,__EXTENSION__) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:__FILENAME__ ofType:__EXTENSION__]]


#pragma mark - 判断数据是否为空
// 字符串是否为空
#define kISNullString(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
// 数组是否为空
#define kISNullArray(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0 ||[array isEqual:[NSNull null]])
// 字典是否为空
#define kISNullDict(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0 || [dic isEqual:[NSNull null]])
// 是否是空对象
#define kISNullObject(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

#pragma mark - 控制台打印
#ifdef DEBUG
#define ZXLog(fmt, ...) NSLog((@"\n[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
//#define ZXLog(fmt, ...) NSLog((@"\n[函数名:%s]\n" fmt), __FUNCTION__, ##__VA_ARGS__)
#else
#define ZXLog(...) NSLog(...)
#endif


/** 单例（声明） */
#define ZXSingtonInterface + (instancetype)sharedInstance;
/** 单例（实现） */
#define ZXSingtonImplement(class) \
\
static class *sharedInstance_; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        sharedInstance_ = [super allocWithZone:zone]; \
    }); \
    return sharedInstance_; \
} \
\
+ (instancetype)sharedInstance { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        sharedInstance_ = [[class alloc] init]; \
    }); \
    return sharedInstance_; \
} \
\
- (id)copyWithZone:(NSZone *)zone { \
    return sharedInstance_; \
}


#pragma mark - weakSelf
#define WeakSelf(type) __weak typeof(type) weak##type = type


#pragma mark -圆角边框
#define ViewBoardRadius(View, Radius, Width, UIColor)\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[UIColor CGColor]]

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Macro)

/// 状态栏高度
- (CGFloat)zx_statusBarHight;
/// 获取Window
- (UIWindow *)zx_keyWindow;
/// 安全范围区域
- (UIEdgeInsets)zx_safeAreaInserts;

@end

NS_ASSUME_NONNULL_END
