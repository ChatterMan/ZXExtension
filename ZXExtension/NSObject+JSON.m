//
//  NSObject+JSON.m
//  youyidai
//
//  Created by Max on 2020/6/17.
//  Copyright © 2020 QNVIP. All rights reserved.
//

#import "NSObject+JSON.h"

@implementation NSObject (JSON)

+(id)zx_loadLocalJSONFile:(NSString *)fileName {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    id initData = [NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingMutableContainers
                                                    error:nil];
    return initData;
}

@end
