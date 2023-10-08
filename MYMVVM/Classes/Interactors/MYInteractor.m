//
//  MYInteractor.m
//  MYNote
//
//  Created by mingyan on 2019/1/7.
//  Copyright © 2019 明妍. All rights reserved.
//

#import "MYInteractor.h"
#import <MYUtils/MYUtils.h>
#import "MYUtils.h"

@interface MYInteractorModel : NSObject
@property (nonatomic, strong) NSString *eventName; /**< 响应名称  */
@property (nonatomic, weak) id target; /**< 响应体  */
@property (nonatomic, assign) SEL selector;/** < 响应的方法*/

@end

@implementation MYInteractorModel


@end

@interface MYInteractor ()

@property (nonatomic, strong) NSMutableDictionary<NSString */* eventName */,MYInteractorModel *> *actionDict;

@end

@implementation MYInteractor

- (void)registerTarget:(id)target action:(SEL)select forEventName:(NSString *)eventName {
    if (!eventName.isEmpty && ![self.actionDict.allKeys containsObject:eventName]) {
        MYInteractorModel *model = [[MYInteractorModel alloc] init];
        model.target = target;
        model.selector = select;
        self.actionDict[eventName] = model;
    }
}

- (void)sendEventName:(NSString *)eventName withObjects:(id)object {
    // do something
    if (eventName.isEmpty || ![self.actionDict.allKeys containsObject:eventName]) {
        return;
    }
    MYInteractorModel *model = self.actionDict[eventName];
    if (model && model.target && model.selector &&
        [model.target respondsToSelector:model.selector]) {
        SuppressPerformSelectorLeakWarning(
            [model.target performSelector:model.selector withObject:object];
                                           );
        
    }
}

- (NSMutableDictionary *)actionDict {
    if (!_actionDict) {
        _actionDict = [NSMutableDictionary dictionary];
    }
    return _actionDict;
}

@end
