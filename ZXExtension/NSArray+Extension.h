//
//  NSArray+Extension.h
//  ZXExtension
//
//  Created by Max on 2020/7/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (Extension)
/**
 将多个对象合并成一个数组，如果参数类型是数组则会将数组内的元素拆解出来加到 return 内（只会拆解一层，所以多维数组不处理）

 @param object 要合并的多个数组
 @return 合并完的结果
 */
+ (instancetype)zx_arrayWithObjects:(ObjectType)object, ...;
@end

NS_ASSUME_NONNULL_END
