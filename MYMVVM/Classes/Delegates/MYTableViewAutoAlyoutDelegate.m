//
//  MYTableViewAutoAlyoutDelegate.m
//  MYNote
//
//  Created by 明妍 on 2018/12/2.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "MYTableViewAutoAlyoutDelegate.h"
#import "MYDataSource.h"
#import "UITableViewCell+MYItemView.h"

@interface MYTableViewAutoAlyoutDelegate ()

@property(nonatomic, weak) UITableView *tableView;/**< tableView  */

@end

@implementation MYTableViewAutoAlyoutDelegate

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<MYViewModelProtocol> viewModel = [self.dataSource viewModelWithIndexPath:indexPath];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([viewModel itemViewClass])];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([viewModel itemViewClass])];
    UIView<MYItemViewProtocol> *itemView;
    if (!cell.itemView) {
        itemView = [[[viewModel itemViewClass] alloc] init];
        cell.itemView = itemView;
    } else {
        itemView = cell.itemView;
    }
    itemView.viewModel = viewModel;
    viewModel.itemView = itemView;
    return cell;
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

@end
