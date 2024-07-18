//
//  MYViewModel.h
//  MYNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MYUIKit/MYUIKit.h>
#import <MYUtils/MYUtils.h>
#import "MYViewModel.h"
#import "MYViewModelProtocol.h"
//#import "MYSkinManager.h"
#import "MYItemView.h"

NS_ASSUME_NONNULL_BEGIN

@class MYItemView;

@interface MYViewModel : NSObject <MYViewModelProtocol>

@property (nonatomic, weak) MYItemView<MYItemViewProtocol> *itemView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSObject *model;

@property (nonatomic, strong) NSArray<UIView<MYViewModelProtocol> *> *leftViewModels;/**< 左侧按钮  */
@property (nonatomic, strong) NSArray<UIView<MYViewModelProtocol> *> *rightViewModels;/**< 右侧按钮  */

@end

NS_ASSUME_NONNULL_END
