//
//  MYViewController.h
//  MYNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "MYRouter.h"
#import "MYRouterAction.h"
#import <MYUtils/MYUtils.h>
#import <MYSkin/MYSkin.h>

@interface MYViewController : UIViewController

+ (NSString *)urlName;

/**
 路由至某个URL

 @param routerURL url
 @param param param
 */
- (void)routerURL:(NSString *)routerURL withParam:(NSDictionary *)param;

@end

#define __MY_ROUTER_REGISTER__   \
+(void)load {\
MYRouterAction *action = [[MYRouterAction alloc] init];\
action.actionType = MYRouterActionTypePushNewPage;\
action.address = [self urlName];\
action.actionBlock = ^(UINavigationController *navigationController) {\
[navigationController pushViewController:[[self alloc] init] animated:YES];\
};\
[[MYRouter sharedInstance] registerRouterWithURLAddress:[self urlName] action:action];\
}

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



