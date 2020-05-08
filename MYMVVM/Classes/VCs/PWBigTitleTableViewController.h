//
//  PWBigTitleTableViewController.h
//  PWNote
//
//  Created by mingyan on 2019/1/7.
//  Copyright © 2019 明妍. All rights reserved.
//

<<<<<<< HEAD
#import "PWViewController.h"
=======
#import "MYViewController.h"
>>>>>>> develop

@class PWTableViewDelegate;
@class PWInteractor;

<<<<<<< HEAD
@interface PWBigTitleTableViewController : PWViewController
=======
@interface PWBigTitleTableViewController : MYViewController
>>>>>>> develop

- (UITableView *)tableView;
- (PWTableViewDelegate *)tableViewDelegate;

- (PWInteractor *)defaultInteractor;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;


@end
