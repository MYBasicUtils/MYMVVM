//
//  MYViewController.h
//  MYNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <MYUtils/MYUtils.h>
#import <MYSkin/MYSkin.h>

@interface MYViewController : UIViewController

@end

#define __MY_ROUTER_REGISTER_PRESENT__   \
+(void)load {\
MYRouterAction *action = [[MYRouterAction alloc] init];\
action.actionType = MYRouterActionTypePresentNewPage;\
action.address = [self urlName];\
action.actionBlock = ^(UINavigationController *navigationController) {\
    [navigationController presentViewController:[[self alloc] init] animated:YES completion:nil];\
};\
[[MYRouter sharedInstance] registerRouterWithURLAddress:[self urlName] action:action];\
}



