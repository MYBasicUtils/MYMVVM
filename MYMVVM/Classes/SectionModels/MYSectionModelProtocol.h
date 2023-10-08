//
//  MYSectionModelProtocol.h
//  MYNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#ifndef MYSectionModelProtocol_h
#define MYSectionModelProtocol_h

@protocol MYViewModelProtocol;

@protocol MYSectionModelProtocol <NSObject>

@property (nonatomic, strong) id<MYViewModelProtocol> headerViewModel; /**< 头部  */
@property (nonatomic, strong) id<MYViewModelProtocol> footerViewModel; /**< 头部  */

@property (nonatomic, strong) NSArray<id<MYViewModelProtocol>> *viewModels;

@end

#endif /* MYSectionModelProtocol_h */
