//
//  MYCollectionDelegate.h
//  MYNote
//
//  Created by 明妍 on 2018/11/25.
//  Copyright © 2018 明妍. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MYDataSource;

@interface MYCollectionDelegate : NSObject

@property(nonatomic, weak) MYDataSource *dataSource;/**< 数据源  */

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

@end

NS_ASSUME_NONNULL_END
