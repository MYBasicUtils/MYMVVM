//
//  MYTableViewController.m
//  MYNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "MYTableViewController.h"
#import "MYInteractor.h"

@interface MYTableViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MYTableViewDelegate *tableViewDelegate;
@property (nonatomic, strong) MYTableViewAutoAlyoutDelegate *autolayoutDelegate;

@property (nonatomic, strong) MYInteractor *defaultInteractor; /**< 交互层  */

@end

@implementation MYTableViewController

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView.delegate = self.tableViewDelegate;
    self.tableView.dataSource = self.tableViewDelegate;
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------
#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColor.clearColor;
    }
    return _tableView;
}

- (MYTableViewDelegate *)tableViewDelegate {
    if (!_tableViewDelegate) {
        _tableViewDelegate = [[MYTableViewDelegate alloc] initWithtableView:self.tableView];
    }
    return _tableViewDelegate;
}

- (MYTableViewAutoAlyoutDelegate *)autolayoutDelegate {
    if (!_autolayoutDelegate) {
        _autolayoutDelegate = [[MYTableViewAutoAlyoutDelegate alloc] initWithtableView:self.tableView];
    }
    return _autolayoutDelegate;
}

- (MYInteractor *)defaultInteractor {
    if (!_defaultInteractor) {
        _defaultInteractor = [[MYInteractor alloc] init];
    }
    return _defaultInteractor;
}

@end
