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

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(void);
typedef void(^Updatelock)(NSDictionary * _Nullable param);
typedef void(^FailBlock)(NSError * _Nullable error);

@protocol MYViewModelProtocol;

@protocol MYSectionModelProtocol;

@class MYInteractor;

NS_ASSUME_NONNULL_BEGIN

@interface MYDataSource : NSObject

//TODO: wmy navigation头部控制

@property (nonatomic, strong) NSArray<id<MYSectionModelProtocol>> *sectionModels;

@property(nonatomic, weak) MYInteractor *interactor;/// < 交互

/// request成功回调
@property(nonatomic, copy) SuccessBlock successBlock;

/// view需要update时调用
@property(nonatomic, copy) Updatelock updateBlock;

/// request失败回调
@property(nonatomic, copy) FailBlock failBlock;

- (void)request;

- (NSInteger)itemCount;

//- (void)requestWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

- (id<MYSectionModelProtocol>)sectionModelWithSection:(NSInteger)section;

- (id<MYViewModelProtocol>)viewModelWithIndexPath:(NSIndexPath *)indexPath;

- (id<MYViewModelProtocol>)headerViewModelWithSection:(NSInteger)section;

- (id<MYViewModelProtocol>)footerViewModelWithSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
