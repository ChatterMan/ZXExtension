//
//  UITableView+Extension.h
//  ZXExtension
//
//  Created by Max on 2020/7/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Extension)

/**
 *  获取某个 view 在 tableView 里的 indexPath
 *
 *  使用场景：例如每个 cell 内均有一个按钮，在该按钮的 addTarget 点击事件回调里可以用这个方法计算出按钮所在的 indexPath
 *
 *  @param view 要计算的 UIView
 *  @return view 所在的 indexPath，若不存在则返回 nil
 */
- (nullable NSIndexPath *)zx_indexPathForRowAtView:(nullable UIView *)view;

/**
 *  计算某个 view 处于当前 tableView 里的哪个 sectionHeaderView 内
 *  @param view 要计算的 UIView
 *  @return view 所在的 sectionHeaderView 的 section，若不存在则返回 -1
 */
- (NSInteger)zx_indexForSectionHeaderAtView:(nullable UIView *)view;


/// 取消选择状态
- (void)zx_clearsSelection;
@end

NS_ASSUME_NONNULL_END
