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
    if (self.successBlock) {
        self.successBlock();
    }
}

- (MYViewModel *)headerViewModelWithSection:(NSInteger)section {
    id<MYSectionModelProtocol> sectionModel = [self.sectionModels my_objectAtSafeIndex:section];
    MYViewModel *headerViewModel = sectionModel.headerViewModel;
    return headerViewModel;
}

- (MYViewModel *)footerViewModelWithSection:(NSInteger)section {
    id<MYSectionModelProtocol> sectionModel = [self.sectionModels my_objectAtSafeIndex:section];
    MYViewModel *footerViewModel = sectionModel.footerViewModel;
    return footerViewModel;
}

- (MYViewModel *)viewModelWithIndexPath:(NSIndexPath *)indexPath {
    if (!self.sectionModels.count) {
        return nil;
    }
    if (indexPath.section < self.sectionModels.count) {
        id<MYSectionModelProtocol> sectionModel = [self.sectionModels my_objectAtSafeIndex:indexPath.section];
        if (!sectionModel.viewModels.count) {
            return nil;
        }
        if (indexPath.row < sectionModel.viewModels.count) {
            id<MYViewModelProtocol> viewModel = (id<MYViewModelProtocol>)[sectionModel.viewModels objectAtIndex:indexPath.row];
            return viewModel;
        }
    }
    return nil;
}

@end
