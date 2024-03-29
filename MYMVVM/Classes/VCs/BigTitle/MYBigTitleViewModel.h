//
//  MYBigTitleViewModel.h
//  MYNote
//
//  Created by mingyan on 2019/1/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "MYViewModel.h"

extern CGFloat const kBigTitleViewHeight;
extern NSString * const kClickBigTitleLabelEvent;
extern NSString * const kTitleLabelEndEditingEvent;

@interface MYBigTitleViewModel : MYViewModel

@property (nonatomic, copy) NSString *bigTitle; /**< 大标题  */
@property (nonatomic, copy) NSString *subTitle; /**< 副标题  */

@property (nonatomic, assign) BOOL isEditing;/** < 是否在编辑中*/

@end
