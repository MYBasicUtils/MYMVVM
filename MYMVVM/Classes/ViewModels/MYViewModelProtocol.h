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

@protocol MYItemViewProtocol;

@protocol MYViewModelProtocol <NSObject>

@property (nonatomic, weak) UIView<MYItemViewProtocol> *itemView;
@property (nonatomic, strong) NSObject *model;
@property (nonatomic, strong) NSIndexPath *indexPath;

- (CGSize)itemSize;

- (Class)itemViewClass;

@end

#endif /* MYViewModelProtocol_h */
