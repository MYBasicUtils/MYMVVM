//
//  MYSectionModel.h
//  MYNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYSectionModelProtocol.h"
#import "MYViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYSectionModel : NSObject <MYSectionModelProtocol>

@property (nonatomic, strong) id<MYViewModelProtocol> footerViewModel; /**< 头部  */
@property (nonatomic, strong) id<MYViewModelProtocol> headerViewModel; /**< 头部  */

@property (nonatomic, strong) NSArray<MYViewModel<MYViewModelProtocol> *> *viewModels;

@end

NS_ASSUME_NONNULL_END
