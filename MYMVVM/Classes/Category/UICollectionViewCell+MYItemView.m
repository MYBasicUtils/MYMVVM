//
//  UICollectionViewCell+MYItemView.m
//  MYNote
//
//  Created by 明妍 on 2018/12/6.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "UICollectionViewCell+MYItemView.h"
#import <Masonry/Masonry.h>
#import <objc/runtime.h>

@implementation UICollectionViewCell (MYItemView)

- (void)setItemView:(UIView<MYItemViewProtocol> *)itemView {
    if (self.itemView.superview) {
        [self.itemView removeFromSuperview];
    }
    objc_setAssociatedObject(self, @selector(itemView), itemView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.contentView addSubview:itemView];
    [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(itemView.superview);
    }];
}

- (UIView <MYItemViewProtocol>*)itemView {
    return objc_getAssociatedObject(self, _cmd);
}

@end
