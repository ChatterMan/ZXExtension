//
//  UICollectionView+Extension.h
//  ZXExtension
//
//  Created by Max on 2020/7/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (Extension)
/**
 *  清除所有已选中的item的选中状态
 */
- (void)zx_clearsSelection;
/**
 *  获取某个view在collectionView内对应的indexPath
 *
 *  例如某个view是某个cell里的subview，在这个view的点击事件回调方法里，就能通过`qmui_indexPathForItemAtView:`获取被点击的view所处的cell的indexPath
 *
 *  @warning 注意返回的indexPath有可能为nil，要做保护。
 */
- (NSIndexPath *)zx_indexPathForItemAtView:(id)sender;

/**
 *  判断当前 indexPath 的 item 是否为可视的 item
 */
- (BOOL)zx_itemVisibleAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
