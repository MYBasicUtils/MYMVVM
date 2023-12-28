//
//  MYViewModelProtocol.h
//  MYNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#ifndef MYViewModelProtocol_h
#define MYViewModelProtocol_h

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    MYMVVMTableViewCellEditingStyleNone,
    MYMVVMTableViewCellEditingStyleDelete,
    MYMVVMTableViewCellEditingStyleInsert,
    MYMVVMTableViewCellEditingStyleCustom,
} MYMVVMTableViewCellEditingStyle;

@protocol MYItemViewProtocol;

@protocol MYViewModelProtocol <NSObject>

@property (nonatomic, weak) UIView<MYItemViewProtocol> *itemView;
@property (nonatomic, strong) NSObject *model;
@property (nonatomic, strong) NSIndexPath *indexPath;

- (CGSize)itemSize;

- (Class)itemViewClass;

// --------
// @Editing
// --------
@optional;


- (MYMVVMTableViewCellEditingStyle)editStyle;

- (NSString *)editText;

/// 左滑按钮，配置滑动size时，height跟随itemView的size.height,在leftViewModel将只有size.width生效
@property (nonatomic, strong) NSArray<UIView<MYViewModelProtocol> *> *leftViewModels;/**< 左侧按钮  */
@property (nonatomic, strong) NSArray<UIView<MYViewModelProtocol> *> *rightViewModels;/**< 右侧按钮  */

@end

#endif /* MYViewModelProtocol_h */
