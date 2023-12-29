//
//  MYDataSource.m
//  MYNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "MYDataSource.h"
#import <MYUtils/MYUtils.h>

@implementation MYDataSource

- (void)request {
    NSAssert(nil, @"subclass should refact this method");
}

//- (void)requestWithSuccess:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
//    NSAssert(nil, @"subclass should refact this method");
//}

- (id<MYSectionModelProtocol>)sectionModelWithSection:(NSInteger)section {
    return [self.sectionModels my_safeObjectAtIndex:section];
}

- (id<MYViewModelProtocol>)headerViewModelWithSection:(NSInteger)section {
    return [self sectionModelWithSection:section].headerViewModel;
}

- (id<MYViewModelProtocol>)footerViewModelWithSection:(NSInteger)section {
    return [self sectionModelWithSection:section].footerViewModel;
}

- (id<MYViewModelProtocol>)viewModelWithIndexPath:(NSIndexPath *)indexPath {
    id<MYSectionModelProtocol> sectionModel = [self sectionModelWithSection:indexPath.section];
    return [sectionModel.viewModels my_safeObjectAtIndex:indexPath.row];
}

- (NSInteger)itemCount {
    NSInteger sum = 0;
    for (id<MYSectionModelProtocol> sectionModel in self.sectionModels) {
        sum += [sectionModel viewModels].count;
    }
    return sum;
}

@end
