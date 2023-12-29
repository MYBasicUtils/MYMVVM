//
//  UITableViewHeaderFooterView+MYItemView.m
//  MYMVVM
//
//  Created by APPLE on 2023/12/28.
//

#import "UITableViewHeaderFooterView+MYItemView.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

@implementation UITableViewHeaderFooterView (MYItemView)

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
