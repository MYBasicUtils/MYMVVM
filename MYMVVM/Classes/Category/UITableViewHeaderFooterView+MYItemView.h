//
//  UITableViewHeaderFooterView+MYItemView.h
//  MYMVVM
//
//  Created by APPLE on 2023/12/28.
//

#import <UIKit/UIKit.h>
#import "MYItemViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewHeaderFooterView (MYItemView)

@property (nonatomic, strong) UIView<MYItemViewProtocol> *itemView;

@end

NS_ASSUME_NONNULL_END
