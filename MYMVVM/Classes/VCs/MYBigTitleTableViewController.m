//
//  MYBigTitleTableViewController.m
//  MYNote
//
//  Created by mingyan on 2019/1/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "MYBigTitleTableViewController.h"
#import <Masonry/Masonry.h>
#import "MYTableViewDelegate.h"
#import "MYBigTitleViewModel.h"
#import "MYInteractor.h"

CGFloat kTableViewDiff = 60;

@interface MYBigTitleTableViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *backView; /**< 白底的View  */
@property (nonatomic, strong) MYTableViewDelegate *tableViewDelegate;
@property (nonatomic, strong) UIView *titleView; /**< titleView  */
@property (nonatomic, strong) UILabel *titleLabel; /**< titleLabel  */
@property (nonatomic, strong) MYInteractor *defaultInteractor; /**< 交互层  */

@end

@implementation MYBigTitleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = kThemeColor;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self.tableViewDelegate;
    self.tableView.dataSource = self.tableViewDelegate;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kSafeAreaNavBarHeight);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    [self.view addSubview:self.backView];
    [self.view sendSubviewToBack:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.mas_equalTo(300);
        make.left.right.bottom.equalTo(self.view);
    }];
    self.navigationItem.titleView = self.titleView;
    self.navigationController.navigationItem.titleView = self.titleView;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat diff = kTableViewDiff;
    NSLog(@"offsetY = %f,end",offsetY);
    if (offsetY > kBigTitleViewHeight - diff && offsetY < kBigTitleViewHeight + diff) {
        [self.tableView setContentOffset:CGPointMake(0, kBigTitleViewHeight) animated:YES];
    }
    
    if (offsetY < diff) {
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self.titleLabel updateConstraints];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat diff = kTableViewDiff;
    NSLog(@"offsetY = %f,end",offsetY);
    if (offsetY > kBigTitleViewHeight - diff && offsetY < kBigTitleViewHeight + diff) {
        [self.tableView setContentOffset:CGPointMake(0, kBigTitleViewHeight) animated:YES];
        NSLog(@"in");
    }
    if (offsetY < diff) {
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < kBigTitleViewHeight - 15) {
        self.titleView.alpha = 0;
    } else {
        self.titleView.alpha = 1;
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
        _titleLabel.textColor = kWhiteColor;
    }
    return _titleLabel;
}

- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        [_titleView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.titleView);
        }];
    }
    return _titleView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
    }
    return _tableView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = kWhiteColor;
    }
    return _backView;
}

- (MYTableViewDelegate *)tableViewDelegate {
    if (!_tableViewDelegate) {
        _tableViewDelegate = [[MYTableViewDelegate alloc] initWithtableView:self.tableView];
        _tableViewDelegate.viewController = self;
        _tableViewDelegate.interactor = self.defaultInteractor;
    }
    return _tableViewDelegate;
}

- (MYInteractor *)defaultInteractor {
    if (!_defaultInteractor) {
        _defaultInteractor = [[MYInteractor alloc] init];
    }
    return _defaultInteractor;
}

@end
