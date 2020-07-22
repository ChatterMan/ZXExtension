//
//  ZXExtension.h
//  ZXExtension
//
//  Created by Max on 2020/7/16.
//  Copyright © 2020 QNVIP. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifndef _ZXEXTENSION_
    #define _ZXEXTENSION_

#if __has_include(<ZXExtension/ZXExtension.h>)

    FOUNDATION_EXPORT double ZXToolsVersionNumber;

    FOUNDATION_EXPORT const unsigned char ZXToolsVersionString[];
    
    #import <ZXExtension/NSArray+Extension.h>
    #import <ZXExtension/NSObject+Extension.h>
    #import <ZXExtension/NSObject+Macro.h>
    #import <ZXExtension/NSParagraphStyle+Extension.h>
    #import <ZXExtension/NSString+Extension.h>
    #import <ZXExtension/NSURL+Extension.h>
    #import <ZXExtension/UICollectionView+Extension.h>
    #import <ZXExtension/UIColor+Extension.h>
    #import <ZXExtension/UIImage+Extension.h>
    #import <ZXExtension/UIImageView+Extension.h>
    #import <ZXExtension/UITableView+Extension.h>
    #import <ZXExtension/UIView+Extension.h>
    #import <ZXExtension/UIViewController+Extension.h>

#else
    
    #import "NSArray+Extension.h"
    #import "NSObject+Extension.h"
    #import "NSObject+Macro.h"
    #import "NSParagraphStyle+Extension.h"
    #import "NSString+Extension.h"
    #import "NSURL+Extension.h"
    #import "UICollectionView+Extension.h"
    #import "UIColor+Extension.h"
    #import "UIImage+Extension.h"
    #import "UIImageView+Extension.h"
    #import "UITableView+Extension.h"
    #import "UIView+Extension.h"
    #import "UIViewController+Extension.h"

#endif /* __has_include */

#endif /* _ZXEXTENSION_ */


