//
//  MYTableViewController.h
//  MYNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "MYViewController.h"
#import <MYUtils/MYUtils.h>
#import "MYTableViewDelegate.h"
#import "MYTableViewAutoAlyoutDelegate.h"
#import "MYInteractor.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYTableViewController : MYViewController

- (UITableView *)tableView;

- (MYTableViewDelegate *)tableViewDelegate;
- (MYTableViewAutoAlyoutDelegate *)autolayoutDelegate;

- (MYInteractor *)defaultInteractor;

@end

NS_ASSUME_NONNULL_END
