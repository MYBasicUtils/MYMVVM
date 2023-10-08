//
//  MYBigTitleViewModel.m
//  MYNote
//
//  Created by mingyan on 2019/1/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "MYBigTitleViewModel.h"
#import "MYBigTitleView.h"

CGFloat const kBigTitleViewHeight = 200;
NSString * const kClickBigTitleLabelEvent = @"kClickBigTitleLabelEvent";
NSString * const kTitleLabelEndEditingEvent = @"kTitleLabelEndEditingEvent";

@implementation MYBigTitleViewModel


- (CGSize)itemSize {
    return CGSizeMake(kScreenWidth, kBigTitleViewHeight);
}

- (Class)itemViewClass {
    return [MYBigTitleView class];
}

@end
