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

@class MYInteractor;

typedef enum : NSUInteger {
    MYItemViewStyleNone,
    MYItemViewStyleBlue,
    MYItemViewStyleGray,
    MYItemViewStyleDefault
} MYItemViewSelectStyle;

@protocol MYItemViewProtocol <NSObject>

@property(nonatomic, weak) id<MYViewModelProtocol> viewModel;/**< 数据源  */
@property(nonatomic, weak) MYInteractor *interactor;

@property (nonatomic, assign) MYItemViewSelectStyle itemviewStyle;

- (void)onSelected;

+ (instancetype)itemView;

- (void)onRefreshView;

@end

#endif /* MYItemViewProtocol_h */
