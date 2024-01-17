//
//  MYTableViewAutoAlyoutDelegate.m
//  MYMVVMUISkin
//
//  Created by WenMingYan on 2020/10/23.
//

#import "MYTableViewAutoAlyoutDelegate.h"
#import "UITableViewCell+MYItemView.h"
#import "UITableViewHeaderFooterView+MYItemView.h"
#import <MYMVVM/MYMVVM.h>

@interface MYTableViewAutoAlyoutDelegate ()

@property(nonatomic, weak) UITableView *tableView;/**< tableView  */

@end

@implementation MYTableViewAutoAlyoutDelegate

#pragma mark - Lifecycle

- (instancetype)initWithtableView:(UITableView *)tableView {
    if (self = [super init]) {
        self.tableView = tableView;
    }
    return self;
}

- (void)setDataSource:(MYDataSource *)dataSource {
    _dataSource = dataSource;
    _dataSource.interactor = self.interactor;
    [self.tableView reloadData];
}

- (void)setInteractor:(MYInteractor *)interactor {
    _interactor = interactor;
    self.dataSource.interactor = interactor;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.sectionModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<MYSectionModelProtocol> sectionModel = [self.dataSource sectionModelWithSection:section];
    return sectionModel.viewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<MYViewModelProtocol> viewModel = [self.dataSource viewModelWithIndexPath:indexPath];
    NSString *identify = NSStringFromClass([viewModel itemViewClass]);
    if (!identify.length) {
        identify = @"Empty";
    }
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identify];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    cell.backgroundColor = [UIColor clearColor];
    UIView<MYItemViewProtocol> *itemView;
    if (!cell.itemView) {
        itemView = [[[viewModel itemViewClass] alloc] init];
        cell.itemView = itemView;
    } else {
        itemView = cell.itemView;
    }
    if ([itemView respondsToSelector:@selector(itemviewStyle)]) {
        cell.selectionStyle = (UITableViewCellSelectionStyle)itemView.itemviewStyle;
    }
    viewModel.indexPath = indexPath;
    itemView.viewModel = viewModel;
    if ([itemView respondsToSelector:@selector(setInteractor:)]) {
        itemView.interactor = self.interactor;
    }
    viewModel.itemView = itemView;
    return cell;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id<MYViewModelProtocol> viewModel = [self.dataSource headerViewModelWithSection:section];
    if (!viewModel) return nil;
    
    [tableView registerClass:UITableViewHeaderFooterView.class
forHeaderFooterViewReuseIdentifier:NSStringFromClass(viewModel.itemViewClass)];
    UITableViewHeaderFooterView *headerView =
    [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(viewModel.itemViewClass)];
    UIView<MYItemViewProtocol> *itemView;
    if (!headerView.itemView) {
        itemView = [[viewModel.itemViewClass alloc] init];
        itemView.interactor = self.interactor;
        headerView.itemView = itemView;
    } else {
        itemView = headerView.itemView;
    }
    
    viewModel.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    itemView.viewModel = viewModel;
    viewModel.itemView = itemView;
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    id<MYViewModelProtocol> viewModel = [self.dataSource footerViewModelWithSection:section];
    if (!viewModel) return nil;
    
    [tableView registerClass:UITableViewHeaderFooterView.class
forHeaderFooterViewReuseIdentifier:NSStringFromClass(viewModel.itemViewClass)];
    UITableViewHeaderFooterView *headerView =
    [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(viewModel.itemViewClass)];
    UIView<MYItemViewProtocol> *itemView;
    if (!headerView.itemView) {
        itemView = [[viewModel.itemViewClass alloc] init];
        itemView.interactor = self.interactor;
        headerView.itemView = itemView;
    } else {
        itemView = headerView.itemView;
    }
    
    viewModel.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    itemView.viewModel = viewModel;
    viewModel.itemView = itemView;
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    id<MYViewModelProtocol> viewModel = [self.dataSource headerViewModelWithSection:section];
    if (!viewModel) return CGFLOAT_MIN;
    
    UIView<MYItemViewProtocol> *itemView;
    if (!viewModel.itemView) {
        itemView = [[viewModel.itemViewClass alloc] init];
        itemView.interactor = self.interactor;
        viewModel.itemView = itemView;
    } else {
        itemView = (UIView<MYItemViewProtocol> *)viewModel.itemView;
    }
    itemView.viewModel = viewModel;
    return viewModel.itemView.itemSize.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    id<MYViewModelProtocol> viewModel = [self.dataSource footerViewModelWithSection:section];
    if (!viewModel) return CGFLOAT_MIN;
    
    UIView<MYItemViewProtocol> *itemView;
    if (!viewModel.itemView) {
        itemView = [[viewModel.itemViewClass alloc] init];
        itemView.interactor = self.interactor;
        viewModel.itemView = itemView;
    } else {
        itemView = (UIView<MYItemViewProtocol> *)viewModel.itemView;
    }
    itemView.viewModel = viewModel;
    return viewModel.itemView.itemSize.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView<MYItemViewProtocol> *itemView = cell.itemView;
    if ([itemView respondsToSelector:@selector(onSelected)]) {
        [itemView onSelected];
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
