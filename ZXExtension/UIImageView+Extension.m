//
//  UIImageView+Extension.m
//  ZXExtension
//
//  Created by Max on 2020/7/16.
//  Copyright © 2020 QNVIP. All rights reserved.
//

#import "UIImageView+Extension.h"
#import <Photos/Photos.h>//相册 8.0版本之后可使用
@implementation UIImageView (Extension)

- (void)imageWithPHAsset:(id)asset {
    
    if ([asset isKindOfClass:[PHAsset class]]) {
        
        
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.resizeMode = PHImageRequestOptionsResizeModeFast;//控制照片尺寸
        option.version = PHImageRequestOptionsVersionUnadjusted;
        option.networkAccessAllowed = NO;
        
        __block UIImageView *imageView = self;
                        
                        
        [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
            if (image) {
                imageView.image = image;
            }
        }];

        
    }
    
}

@end
