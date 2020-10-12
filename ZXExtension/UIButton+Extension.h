//
//  UIButton+Extension.h
//  ZXExtension
//
//  Created by Max on 2020/10/12.
//

#import <UIKit/UIKit.h>

/*
 针对同时设置了Image和Title的场景时UIButton中的图片和文字的关系
 */
typedef NS_ENUM(NSInteger, ZXButtonImageTitleStyle ) {
    ZXButtonImageTitleStyleDefault = 0,       //图片在左，文字在右，整体居中。
    ZXButtonImageTitleStyleLeft  = 0,         //图片在左，文字在右，整体居中。
    ZXButtonImageTitleStyleRight     = 2,     //图片在右，文字在左，整体居中。
    ZXButtonImageTitleStyleTop  = 3,          //图片在上，文字在下，整体居中。
    ZXButtonImageTitleStyleBottom    = 4,     //图片在下，文字在上，整体居中。
    ZXButtonImageTitleStyleCenterTop = 5,     //图片居中，文字在上距离按钮顶部。
    ZXButtonImageTitleStyleCenterBottom = 6,  //图片居中，文字在下距离按钮底部。
    ZXButtonImageTitleStyleCenterUp = 7,      //图片居中，文字在图片上面。
    ZXButtonImageTitleStyleCenterDown = 8,    //图片居中，文字在图片下面。
    ZXButtonImageTitleStyleRightLeft = 9,     //图片在右，文字在左，距离按钮两边边距
    ZXButtonImageTitleStyleLeftRight = 10,    //图片在左，文字在右，距离按钮两边边距
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Extension)

/*
 * 调整按钮的文本和image的布局，前提是title和image同时存在才会调整。
 * padding是调整布局时整个按钮和图文的间隔。
 */
- (void)zx_setZXButtonImageTitleStyle:(ZXButtonImageTitleStyle)style padding:(CGFloat)padding;

@end

NS_ASSUME_NONNULL_END
