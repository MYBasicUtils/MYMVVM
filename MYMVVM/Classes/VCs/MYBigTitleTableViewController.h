//
//  MYBigTitleTableViewController.h
//  MYNote
//
//  Created by mingyan on 2019/1/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "MYViewController.h"

@class MYTableViewDelegate;
@class MYInteractor;

@interface MYBigTitleTableViewController : MYViewController

- (UITableView *)tableView;
- (MYTableViewDelegate *)tableViewDelegate;

- (MYInteractor *)defaultInteractor;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;


@end
