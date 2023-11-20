//
//  MYNavigationViewController.m
//  MYNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "MYNavigationViewController.h"

@interface MYNavigationViewController ()

@end

@implementation MYNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBarAppearance * bar = [[UINavigationBarAppearance alloc] init];
    bar.backgroundColor = [UIColor whiteColor];
    bar.shadowColor = UIColor.whiteColor;
//    bar.shadowImage = UIImage.new;
    bar.backgroundEffect = nil;
    self.navigationBar.scrollEdgeAppearance = bar;
    self.navigationBar.standardAppearance = bar;
    
}

@end
