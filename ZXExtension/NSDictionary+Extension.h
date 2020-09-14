//
//  NSDictionary+Extension.h
//  Pods
//
//  Created by Max on 2020/9/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Extension)

+ (NSDictionary *)zx_dictionaryWithJsonString:(NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END
