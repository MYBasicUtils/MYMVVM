//
//  MYItemViewProtocol.h
//  MYNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#ifndef MYItemViewProtocol_h
#define MYItemViewProtocol_h

@protocol MYViewModelProtocol;

@protocol MYViewModelProtocol;

@class MYInteractor;

typedef enum : NSUInteger {
    MYItemViewStyleDefaultNone,
    MYItemViewStyleDefaultBlue,
    MYItemViewStyleDefaultGray,
    MYItemViewStyleDefaultDefault
} MYItemViewSelectStyle;

@protocol MYItemViewProtocol <NSObject>

@property(nonatomic, weak) id<MYViewModelProtocol> viewModel;/**< 数据源  */

- (CGSize)itemSize;

- (void)onRefreshView;

- (void)onSelected;

- (void)didDisplay;

@optional;

@property(nonatomic, weak) MYInteractor *interactor;
@property (nonatomic, assign) MYItemViewSelectStyle itemviewStyle;

// --------
// @Editing
// --------
@optional;
- (UITableViewCellEditingStyle)editStyle;

- (void)onEditDelete;

- (void)onEditInsert;

//// 自定义左滑、右滑按钮
//@property (nonatomic, strong) NSArray<UIView<MYViewModelProtocol> *> *rightActionViewModels;/**< 右侧按钮  */
//@property (nonatomic, strong) NSArray<UIView<MYViewModelProtocol> *> *leftActionViewModels;/**< 左侧按钮  */

@end


#endif /* MYItemViewProtocol_h */
