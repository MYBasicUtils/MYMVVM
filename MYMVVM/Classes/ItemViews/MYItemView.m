//
//  MYItemView.m
//  MYNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "MYItemView.h"

@implementation MYItemView

#pragma mark - --------------------dealloc ------------------
#pragma mark - --------------------life cycle--------------------
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = kWhiteColor;
    }
    return self;
}

#pragma mark - --------------------UITableViewDelegate--------------
#pragma mark - --------------------CustomDelegate--------------
#pragma mark - --------------------Event Response--------------

- (void)setViewModel:(id<MYViewModelProtocol>)viewModel {
    _viewModel = viewModel;
}

#pragma mark - --------------------private methods--------------
#pragma mark - --------------------getters & setters & init members ------------------
+ (instancetype)itemViewWithBundleName:(NSString *)bundleName {
    MYItemView *itemView;
    NSBundle *cbundle = [NSBundle bundleForClass:self.class];
    NSString *path = [cbundle pathForResource:bundleName ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    itemView = [bundle loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
    return itemView;
}

- (void)onSelected {
    
}

- (void)onRefreshView {
    
}

@end
