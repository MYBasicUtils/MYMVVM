//
//  MYDataSource.h
//  MYNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYSectionModel.h"
#import "MYViewModel.h"

typedef void(^SuccessBlock)(void);
typedef void(^FailBlock)(NSError *error);

NS_ASSUME_NONNULL_BEGIN

@interface MYDataSource : NSObject

@property (nonatomic, strong) NSString *method;

@property (nonatomic, strong) NSArray<MYSectionModel<MYSectionModelProtocol> *> *sectionModels;

- (void)requestWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

- (MYViewModel *)viewModelWithIndexPath:(NSIndexPath *)indexPath;

- (MYViewModel *)headerViewModelWithSection:(NSInteger)section;

- (MYViewModel *)footerViewModelWithSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
