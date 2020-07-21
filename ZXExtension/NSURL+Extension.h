//
//  NSURL+Extension.h
//  ZXExtension
//
//  Created by Max on 2020/7/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (Extension)

/**
 *  获取当前 query 的参数列表。
 *
 *  @return query 参数列表，以字典返回。如果 absoluteString 为 nil 则返回 nil
 */
@property(nonatomic, copy, readonly) NSDictionary<NSString *, NSString *> *zx_queryItems;

@end

NS_ASSUME_NONNULL_END
