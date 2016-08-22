//
//  RACSignal+SANavigationAction.m
//  Blok
//
//  Created by Alex Padalko on 9/24/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "RACSignal+SANavigationAction.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@implementation RACSignal (SANavigationAction)
+(instancetype)signalWithAction:(PPJNavigationAction*)action{
    @weakify(action)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(action)
        [subscriber sendNext:action];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}
@end
