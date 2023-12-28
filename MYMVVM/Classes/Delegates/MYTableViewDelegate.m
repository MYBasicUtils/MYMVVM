//
//  MYTableViewDelegate.m
//  MYNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "MYTableViewDelegate.h"
#import "MYDataSource.h"
#import "UITableViewCell+MYItemView.h"

@interface MYTableViewDelegate ()

@property(nonatomic, weak) UITableView *tableView;/**< tableView  */

@end

@implementation MYTableViewDelegate

- (instancetype)initWithtableView:(UITableView *)tableView {
    if (self = [super init]) {
        self.tableView = tableView;
    }
    return self;
}

- (void)setDataSource:(MYDataSource *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    id<MYViewModelProtocol> viewModel = [self.dataSource footerViewModelWithSection:section];
    viewModel.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    return viewModel.itemSize.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    id<MYViewModelProtocol> viewModel = [self.dataSource footerViewModelWithSection:section];
    UIView<MYItemViewProtocol> *itemView = [self itemViewWithViewModel:viewModel];
    itemView.viewModel = viewModel;
    return itemView;
}

- (UIView<MYItemViewProtocol> *)itemViewWithViewModel:(id<MYViewModelProtocol>)viewModel {
    Class itemViewClass = [viewModel itemViewClass];
    if ([itemViewClass respondsToSelector:@selector(itemView)]) {
        return [itemViewClass itemView];
    }
    return [[[viewModel itemViewClass] alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    id<MYViewModelProtocol> viewModel = [self.dataSource headerViewModelWithSection:section];
    viewModel.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    return viewModel.itemSize.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id<MYViewModelProtocol> viewModel = [self.dataSource headerViewModelWithSection:section];
    UIView<MYItemViewProtocol> *itemView = [self itemViewWithViewModel:viewModel];
    itemView.viewModel = viewModel;
    return itemView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<MYViewModelProtocol> viewModel = [self.dataSource viewModelWithIndexPath:indexPath];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([viewModel itemViewClass])];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([viewModel itemViewClass])];
    cell.backgroundColor = [UIColor clearColor];
    UIView<MYItemViewProtocol> *itemView;
    if (!cell.itemView) {
        itemView = [self itemViewWithViewModel:viewModel];
        itemView.interactor = self.interactor;
        cell.itemView = itemView;
        [self configRightItemViewsWithCell:cell viewModel:viewModel];
    } else {
        itemView = cell.itemView;
    }
    [self configRightItemViewsWithCell:cell viewModel:viewModel];
    cell.selectionStyle = (UITableViewCellSelectionStyle)itemView.itemviewStyle;
    viewModel.indexPath = indexPath;
    itemView.viewModel = viewModel;
    viewModel.itemView = itemView;
    return cell;
}

- (void)configRightItemViewsWithCell:(UITableViewCell *)cell viewModel:(id<MYViewModelProtocol>)viewModel {
    if ([viewModel respondsToSelector:@selector(rightViewModels)] &&
        viewModel.rightViewModels.count) {
        NSMutableArray<UIView<MYItemViewProtocol> *> *rightItemViews =
        [NSMutableArray<UIView<MYItemViewProtocol> *> arrayWithCapacity:viewModel.rightViewModels.count];
        for (int i = 0; i < viewModel.rightViewModels.count; i++) {
            id<MYViewModelProtocol> rightViewModel = [viewModel.rightViewModels my_objectAtIndex:i];
            UIView<MYItemViewProtocol> *rightItemView = rightViewModel.itemView;
            if (!rightItemView) {
                rightItemView = [self configRightItemViewWithViewModel:[viewModel.rightViewModels my_objectAtIndex:i]];
            }
            rightItemView.viewModel = [viewModel.rightViewModels my_objectAtIndex:i];
            [rightItemViews addObject:rightItemView];
        }
        cell.rightItemViews = rightItemViews;
    } else {
        cell.rightItemViews = @[];
    }
}

- (UIView<MYItemViewProtocol> *)configRightItemViewWithViewModel:(id<MYViewModelProtocol>)viewModel {
    UIView<MYItemViewProtocol> *rightItemView = [[[viewModel itemViewClass] alloc] init];
    rightItemView.viewModel = viewModel;
    rightItemView.viewModel.itemView = rightItemView;
    [rightItemView.viewModel.itemView onRefreshView];
    rightItemView.interactor = self.interactor;
    
    return rightItemView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<MYViewModelProtocol> viewModel = [self.dataSource viewModelWithIndexPath:indexPath];
    return viewModel.itemSize.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<MYSectionModelProtocol> sectionModel = [self.dataSource.sectionModels objectAtIndex:section];
    return sectionModel.viewModels.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.sectionModels.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView<MYItemViewProtocol> *itemView = cell.itemView;
    if ([itemView respondsToSelector:@selector(onSelected)]) {
        [itemView onSelected];
    }
}


//TODO: wmy 需要优化
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.viewController respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        @weakify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self.viewController performSelector:@selector(scrollViewDidEndDecelerating:) withObject:scrollView];
        });
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.viewController respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        @weakify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self.viewController performSelector:@selector(scrollViewDidEndDragging:willDecelerate:)
                                      withObject:scrollView
                                      withObject:@(decelerate)];
        });
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.viewController respondsToSelector:@selector(scrollViewDidScroll:)]) {
        @weakify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self.viewController performSelector:@selector(scrollViewDidScroll:) withObject:scrollView];
        });
    }
}



@end
