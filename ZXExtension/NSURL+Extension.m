//
//  NSURL+Extension.m
//  ZXExtension
//
//  Created by Max on 2020/7/21.
//

#import "NSURL+Extension.h"

@implementation NSURL (Extension)
- (NSDictionary<NSString *, NSString *> *)zx_queryItems {
    if (!self.absoluteString.length) {
        return nil;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:self.absoluteString];
    
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.name) {
            [params setObject:obj.value ?: [NSNull null] forKey:obj.name];
        }
    }];
    return [params copy];
}
@end
