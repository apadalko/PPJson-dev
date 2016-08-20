//
//  RACSignal+Object.m
//  Blok
//
//  Created by Alex Padalko on 3/1/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "RACSignal+Object.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@implementation RACSignal (Object)
+(instancetype)signalWithObject:(id)obj{
          @weakify(obj)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(obj)
        [subscriber sendNext:obj];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}
@end
