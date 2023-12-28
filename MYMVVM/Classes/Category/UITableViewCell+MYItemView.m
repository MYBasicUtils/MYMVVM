//
//  UITableViewCell+MYItemView.m
//  MYNote
//
//  Created by 明妍 on 2018/11/26.
//  Copyright © 2018 明妍. All rights reserved.
//

#import "UITableViewCell+MYItemView.h"
#import <Masonry/Masonry.h>
#import <MYUtils/MYUtils.h>
#import <MYUIKit/MYUIKit.h>
#import <objc/runtime.h>
#import "MYInteractor.h"
#import "MYItemViewProtocol.h"
#import "MYViewModelProtocol.h"

NSString *const kMVVMEventScroll = @"kEventScroll";
NSString *const kMVVMEventAppearEdit = @"kEventAppearEdit";
NSString *const kMVVMEventPackUp = @"kEventPackUp";
NSString *const kMVVMEventPackUpFinish = @"kEventPackUpFinish";


@interface MYTableViewCellGestureManager : NSObject <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UITableViewCell *cell;/**< cell  */
@property (nonatomic, assign) CGPoint containerOrigin;/**< 开始手势  */
@property (nonatomic, assign) CGFloat maxRightWidth;/**< 右侧最大宽度  */
@property (nonatomic, assign) BOOL isPackUp;/**< 是否收起  */
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@interface UITableViewCell ()

@property (nonatomic, strong) UIStackView *rightStackView;/**< 右侧stackView */
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;/**< 滑动  */
@property (nonatomic, strong) MYTableViewCellGestureManager *gestureManager;/**< 手势处理  */

@property (nonatomic, assign) BOOL canGestureRight;/**< 可以左滑  */
@property (nonatomic, assign) BOOL canGestureLeft;/**< 可以右滑  */
@property (nonatomic, strong) UIView *shadowView;
@end

@implementation MYTableViewCellGestureManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isPackUp = YES;
        
    }
    return self;
}

- (void)setCell:(UITableViewCell *)cell {
    _cell = cell;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                             action:@selector(onClick)];
    [self.cell addGestureRecognizer:tapGesture];
}

- (void)onClick {
    if (!self.isPackUp) {
        return;
    }
    [self.cell.interactor sendEventName:kMVVMEventPackUp withObjects:nil];
    [self.cell.itemView onSelected];
}

- (void)onPan:(UIPanGestureRecognizer *)panRecognizer {
    CGPoint point = [panRecognizer translationInView:self.cell];
    // 1. 开始手势
    if (panRecognizer.state == UIGestureRecognizerStateBegan) {
        self.containerOrigin = panRecognizer.view.frame.origin;
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"indexPath"] = self.cell.itemView.viewModel.indexPath;
        [self.cell.interactor sendEventName:kMVVMEventAppearEdit withObjects:param];
    }
    // 2.手势移动过程中: 在边界处做判断,其他位置
    if (panRecognizer.state == UIGestureRecognizerStateChanged) {
        CGRect frame = panRecognizer.view.frame;
        frame.origin.x = self.containerOrigin.x + point.x;
        if (!self.cell.rightItemViews.count) {
            frame.origin.x = frame.origin.x < 0 ? frame.origin.x : 0;
        }
        self.isPackUp = NO;
        //TODO: wmy 是否可以向右 是否可以向左
        [panRecognizer.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(frame.origin.x);
            make.right.mas_equalTo(frame.origin.x);
        }];
    }
    // 3.手势结束
    if (panRecognizer.state == UIGestureRecognizerStateEnded) {
        CGRect frame = panRecognizer.view.frame;
        CGFloat animationDuration = 0.5;
        if (fabs(frame.origin.x) < self.maxRightWidth * 0.5) {
            [self onPackUp];
        } else {
            [self.cell.itemView setNeedsUpdateConstraints];
            [UIView animateWithDuration:animationDuration animations:^{
                [self.cell.itemView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(-self.maxRightWidth);
                    make.right.mas_equalTo(-self.maxRightWidth);
                }];
                [self.cell.itemView.superview layoutIfNeeded];
            } completion:^(BOOL finished) {
                if (finished) {
                    NSMutableDictionary *param = [NSMutableDictionary dictionary];
                    param[@"viewModel"] = self.cell.itemView.viewModel;
                    [self.cell.interactor sendEventName:kMVVMEventPackUpFinish withObjects:param];
                }
            }];
        }
    }
}

- (void)onPackUp {
    // 不显示
    if (self.isPackUp) {
        return;
    }
    CGFloat animationDuration = 0.5;
    [self.cell.itemView setNeedsUpdateConstraints];
    [UIView animateWithDuration:animationDuration animations:^{
        [self.cell.itemView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        [self.cell.itemView.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.isPackUp = YES;
    }];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if (!self.isPackUp) {
        return YES;
    }
    CGPoint point = [gestureRecognizer translationInView:self.cell];
    if (fabs(point.x) > fabs(point.y)) {
        if (self.cell.rightItemViews.count && point.x < 0) {
            return YES;
        }
        if (self.cell.leftItemViews.count && point.x > 0) {
            return YES;
        }
        
    } else {
        return NO;
    }
    return NO;
}

@end

@implementation UITableViewCell (MYItemView)

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

- (void)onClickRightItemView:(UITapGestureRecognizer *)recognizer {
    NSInteger index = recognizer.view.tag;
    UIView<MYItemViewProtocol> *itemView = [self.rightItemViews my_objectAtIndex:index];
    [itemView onSelected];
    [self.gestureManager onPackUp];
    
}

#pragma mark - getter & setter

#pragma mark rightItemViews

- (void)setRightItemViews:(NSArray<UIView<MYItemViewProtocol> *> *)rightItemViews {
    for (UIView *subView in self.rightItemViews) {
        [subView removeFromSuperview];
    }
    
    objc_setAssociatedObject(self, @selector(rightItemViews), rightItemViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (!rightItemViews.count) {
        self.canGestureRight = NO;
        return;
    }
    

    // 监听
    self.gestureManager.isPackUp = YES;
    [self configInteractor];
    
    self.canGestureRight = YES;
    [self.contentView addSubview:self.rightStackView];
    __block CGFloat width = 0;
    [rightItemViews enumerateObjectsWithOptions:NSEnumerationReverse
                                     usingBlock:^(UIView<MYItemViewProtocol> * _Nonnull itemView,
                                                  NSUInteger idx,
                                                  BOOL * _Nonnull stop) {
        CGSize size = itemView.viewModel.itemSize;
        itemView.tag = idx;
        width += size.width;
        [self.rightStackView addArrangedSubview:itemView];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(itemView.viewModel.itemSize);
        }];
        
        UITapGestureRecognizer *itemViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                     action:@selector(onClickRightItemView:)];
        [itemView addGestureRecognizer:itemViewTap];
    }];
    
    self.gestureManager.maxRightWidth = width;
    self.rightStackView.my_left = self.itemView.my_right;
    [self.rightStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.itemView.mas_right);
    }];
    
    self.itemView.userInteractionEnabled = YES;
    if (![self.itemView.gestureRecognizers containsObject:self.panRecognizer]) {
        [self.itemView addGestureRecognizer:self.panRecognizer];
    }
}

- (void)configInteractor {
    [self.interactor registerTarget:self action:@selector(onReceiveEventScroll:) forEventName:kMVVMEventScroll];
    [self.interactor registerTarget:self action:@selector(onReceiveEventAppearEdit:) forEventName:kMVVMEventAppearEdit];
    [self.interactor registerTarget:self action:@selector(onReceivePackUp:) forEventName:kMVVMEventPackUp];
}

- (void)onReceivePackUp:(NSDictionary *)param {
    if (self.gestureManager.isPackUp) {
        return;
    }
    [self.gestureManager onPackUp];
}

- (void)onReceiveEventAppearEdit:(NSDictionary *)param {
    NSIndexPath *indexPath = param[@"indexPath"];
    if (indexPath.item == self.itemView.viewModel.indexPath.item) {
        return;
    }
    if (self.gestureManager.isPackUp) {
        return;
    }
    [self.gestureManager onPackUp];
}

- (void)onReceiveEventScroll:(NSDictionary *)param {
    [self.gestureManager onPackUp];
}

- (NSArray<UIView<MYItemViewProtocol> *> *)rightItemViews {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark gestureManager

- (MYTableViewCellGestureManager *)gestureManager {
    if (!objc_getAssociatedObject(self, _cmd)) {
        MYTableViewCellGestureManager *gestureManager = [[MYTableViewCellGestureManager alloc] init];
        gestureManager.cell = self;
        objc_setAssociatedObject(self, @selector(gestureManager), gestureManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setGestureManager:(MYTableViewCellGestureManager *)gestureManager {
    objc_setAssociatedObject(self, @selector(gestureManager), gestureManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark panRecognizer

- (UIPanGestureRecognizer *)panRecognizer {
    if (!objc_getAssociatedObject(self, _cmd)) {
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.gestureManager
                                                                                        action:@selector(onPan:)];
        panRecognizer.delegate = self.gestureManager;
        objc_setAssociatedObject(self, @selector(panRecognizer), panRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setPanRecognizer:(UIPanGestureRecognizer *)panRecognizer {
    objc_setAssociatedObject(self, @selector(panRecognizer), panRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setLeftItemViews:(NSArray<UIView<MYItemViewProtocol> *> *)leftItemViews {
    objc_setAssociatedObject(self, @selector(leftItemViews), leftItemViews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}


- (NSArray<UIView<MYItemViewProtocol> *> *)leftItemViews {
    return objc_getAssociatedObject(self, _cmd);
}

- (UIView <MYItemViewProtocol>*)itemView {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark rightStackView

- (UIStackView *)rightStackView {
    if (!objc_getAssociatedObject(self, _cmd)) {
        UIStackView *rightStackView = [[UIStackView alloc] init];
        objc_setAssociatedObject(self, @selector(rightStackView), rightStackView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        rightStackView.spacing = 0;
        rightStackView.distribution = UIStackViewDistributionEqualSpacing;
        rightStackView.axis = UILayoutConstraintAxisHorizontal;
        rightStackView.alignment = UIStackViewAlignmentLeading;
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setRightStackView:(UIStackView *)rightStackView {
    objc_setAssociatedObject(self, @selector(rightStackView), rightStackView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)canGestureRight {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setCanGestureRight:(BOOL)canGestureRight {
    objc_setAssociatedObject(self, @selector(canGestureRight), @(canGestureRight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)canGestureLeft {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setCanGestureLeft:(BOOL)canGestureLeft {
    objc_setAssociatedObject(self, @selector(canGestureLeft), @(canGestureLeft), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setInteractor:(MYInteractor *)interactor {
    objc_setAssociatedObject(self, @selector(interactor), interactor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MYInteractor *)interactor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setShadowView:(UIView *)shadowView {
    objc_setAssociatedObject(self, @selector(shadowView), shadowView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.contentView addSubview:shadowView];
    [self.contentView sendSubviewToBack:shadowView];
    if (self.itemView) {
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.itemView);
        }];
    }
}

- (UIView *)shadowView {
    if (!objc_getAssociatedObject(self, _cmd)) {
        UIView *shadowView = [[UIView alloc] init];
        shadowView.layer.shadowRadius = 12;
        shadowView.layer.shadowOpacity = 1;
        shadowView.layer.shadowOffset = CGSizeMake(0, 4);
        shadowView.layer.masksToBounds = NO;
        [self setShadowView:shadowView];
    }
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setItemViewInset:(UIEdgeInsets)itemViewInset {
    objc_setAssociatedObject(self, @selector(itemViewInset), NSStringFromUIEdgeInsets(itemViewInset), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, @selector(itemViewInset), @YES, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIEdgeInsets)itemViewInset {
    return UIEdgeInsetsFromString(objc_getAssociatedObject(self, _cmd));
}
@end
