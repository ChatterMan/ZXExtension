//
//  UICollectionView+Extension.m
//  ZXExtension
//
//  Created by Max on 2020/7/21.
//

#import "UICollectionView+Extension.h"

@implementation UICollectionView (Extension)

- (void)zx_clearsSelection {
    NSArray *selectedItemIndexPaths = [self indexPathsForSelectedItems];
    for (NSIndexPath *indexPath in selectedItemIndexPaths) {
        [self deselectItemAtIndexPath:indexPath animated:YES];
    }
}
/// 递归找到view在哪个cell里，不存在则返回nil
- (UICollectionViewCell *)parentCellForView:(UIView *)view {
    if (!view.superview) {
        return nil;
    }
    
    if ([view.superview isKindOfClass:[UICollectionViewCell class]]) {
        return (UICollectionViewCell *)view.superview;
    }
    
    return [self parentCellForView:view.superview];
}

- (NSIndexPath *)zx_indexPathForItemAtView:(id)sender {
    if (sender && [sender isKindOfClass:[UIView class]]) {
        UIView *view = (UIView *)sender;
        UICollectionViewCell *parentCell = [self parentCellForView:view];
        if (parentCell) {
            return [self indexPathForCell:parentCell];
        }
    }
    
    return nil;
}

- (BOOL)zx_itemVisibleAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *visibleItemIndexPaths = self.indexPathsForVisibleItems;
    for (NSIndexPath *visibleIndexPath in visibleItemIndexPaths) {
        if ([indexPath isEqual:visibleIndexPath]) {
            return YES;
        }
    }
    return NO;
}
@end
