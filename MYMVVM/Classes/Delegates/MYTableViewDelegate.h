//
//  MYTableViewDelegate.h
//  MYNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYDataSource;
@class MYInteractor;
NS_ASSUME_NONNULL_BEGIN

@interface MYTableViewDelegate : NSObject <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak) MYDataSource *dataSource;/**< 数据源  */
@property (nonatomic, strong) MYInteractor *interactor; /**< 交互层  */


- (instancetype)initWithtableView:(UITableView *)tableView;

@property(nonatomic, weak) UIViewController *viewController;

@end

NS_ASSUME_NONNULL_END
