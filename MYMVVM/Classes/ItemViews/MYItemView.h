//
//  MYItemView.h
//  MYNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <MYSkin/MYSkin.h>

//#import "UIImageView+MYWebCatch.h"
//#import "MYIconfont.h"
#import <MYUtils/MYUtils.h>
#import "MYItemViewProtocol.h"
#import "MYViewModelProtocol.h"
//#import "MYSkinManager.h"

#import "MYInteractor.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYItemView : UIView <MYItemViewProtocol>

@property(nonatomic, weak) id<MYViewModelProtocol> viewModel;/**< 数据源  */
@property(nonatomic, weak) MYInteractor *interactor;
@property (nonatomic, assign) MYItemViewSelectStyle itemviewStyle;

+ (instancetype)itemView;
+ (instancetype)itemViewWithBundleName:(NSString *)bundleName;

- (void)onRefreshView;

@end

NS_ASSUME_NONNULL_END
