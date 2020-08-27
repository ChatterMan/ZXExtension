//
//  NSObject+JSON.h
//  youyidai
//
//  Created by Max on 2020/6/17.
//  Copyright © 2020 QNVIP. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JSON)
/// 加载本地json文件
+ (id)zx_loadLocalJSONFile:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
