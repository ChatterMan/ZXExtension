//
//  NSDictionary+Extension.m
//  Pods
//
//  Created by Max on 2020/9/14.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

/// JSON字符串转化为字典
+ (NSDictionary *)zx_dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



@end
