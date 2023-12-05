//
//  MYNavigationViewController.m
//  MYNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "MYNavigationViewController.h"
#import <MYSkin/MYSkin.h>

@interface MYNavigationViewController ()

@end

@implementation MYNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBarAppearance * bar = [[UINavigationBarAppearance alloc] init];
    bar.backgroundColor = TheSkin.whiteColor;
    bar.shadowColor = TheSkin.whiteColor;
    bar.backgroundEffect = nil;
    self.navigationBar.scrollEdgeAppearance = bar;
    self.navigationBar.standardAppearance = bar;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
    viewController.hidesBottomBarWhenPushed = NO;
}

- (void)setBackColor:(UIColor *)backColor {
    _backColor = backColor;
    UINavigationBarAppearance * bar = [[UINavigationBarAppearance alloc] init];
    bar.backgroundColor = backColor;
    bar.shadowColor = backColor;
    bar.backgroundEffect = nil;
    self.navigationBar.scrollEdgeAppearance = bar;
    self.navigationBar.standardAppearance = bar;
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

@end
