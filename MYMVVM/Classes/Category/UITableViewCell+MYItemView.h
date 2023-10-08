//
//  UITableViewCell+MYItemView.h
//  MYNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYItemViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (MYItemView)

@property (nonatomic, strong) UIView<MYItemViewProtocol> *itemView;

@end

NS_ASSUME_NONNULL_END
