//
//  PWBigTitleTableViewController.h
//  PWNote
//
//  Created by mingyan on 2019/1/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "MYViewController.h"

@class PWTableViewDelegate;
@class PWInteractor;

@interface PWBigTitleTableViewController : MYViewController

- (UITableView *)tableView;
- (PWTableViewDelegate *)tableViewDelegate;

- (PWInteractor *)defaultInteractor;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;


@end
