//
//  UITableView+Extension.m
//  ZXExtension
//
//  Created by Max on 2020/7/21.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)
- (NSIndexPath *)zx_indexPathForRowAtView:(UIView *)view {
    if (!view || !view.superview) {
        return nil;
    }
    
    if ([view isKindOfClass:[UITableViewCell class]] && ([NSStringFromClass(view.superview.class) isEqualToString:@"UITableViewWrapperView"] ? view.superview.superview : view.superview) == self) {
        // iOS 11 下，cell.superview 是 UITableView，iOS 11 以前，cell.superview 是 UITableViewWrapperView
        return [self indexPathForCell:(UITableViewCell *)view];
    }
    
    return [self zx_indexPathForRowAtView:view.superview];
}

- (NSArray<NSNumber *> *)zx_indexForVisibleSectionHeaders {
    NSArray<NSIndexPath *> *visibleCellIndexPaths = [self indexPathsForVisibleRows];
    NSMutableArray<NSNumber *> *visibleSections = [[NSMutableArray alloc] init];
    NSMutableArray<NSNumber *> *result = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < visibleCellIndexPaths.count; i++) {
        if (visibleSections.count == 0 || visibleCellIndexPaths[i].section != visibleSections.lastObject.integerValue) {
            [visibleSections addObject:@(visibleCellIndexPaths[i].section)];
        }
    }
    for (NSInteger i = 0; i < visibleSections.count; i++) {
        NSInteger section = visibleSections[i].integerValue;
        if ([self zx_isHeaderVisibleForSection:section]) {
            [result addObject:visibleSections[i]];
        }
    }
    if (result.count == 0) {
        result = nil;
    }
    return result;
}

- (BOOL)zx_isHeaderVisibleForSection:(NSInteger)section {
    if (self.style != UITableViewStylePlain) return NO;
    if (section >= [self numberOfSections]) return NO;
    
    // 不存在 header 就不用判断
    CGRect rectForSectionHeader = [self rectForHeaderInSection:section];
    if (CGRectGetHeight(rectForSectionHeader) <= 0) return NO;
    
    // 系统这个接口获取到的 rect 是在 contentSize 里的 rect，而不是实际看到的 rect
    CGRect rectForSection = [self rectForSection:section];
    BOOL isSectionScrollIntoBounds = CGRectGetMinY(rectForSection) < self.contentOffset.y + CGRectGetHeight(self.bounds);
    BOOL isSectionStayInContentInsetTop = self.contentOffset.y + self.zx_contentInset.top < CGRectGetMaxY(rectForSection);// 表示这个 section 还没被完全滚走
    BOOL isVisible = isSectionScrollIntoBounds && isSectionStayInContentInsetTop;
    return isVisible;
}

- (UIEdgeInsets)zx_contentInset {
    if (@available(iOS 11, *)) {
        return self.adjustedContentInset;
    } else {
        return self.contentInset;
    }
}

- (void)zx_clearsSelection {
    NSArray<NSIndexPath *> *selectedIndexPaths = [self indexPathsForSelectedRows];
    for (NSIndexPath *indexPath in selectedIndexPaths) {
        [self deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
