//
//  RACCommand+MethodRedirection.m
//  Blok
//
//  Created by Alex Padalko on 9/24/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "RACCommand+MethodRedirection.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@implementation RACCommand (MethodRedirection)
+(RACCommand *)commandWithTarget:(id)target andSelector:(SEL)selector{
    
    
    @weakify(target);
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
       
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           
            
            
            @strongify(target);
            
            IMP imp = [target methodForSelector:selector];
            void (*func)(id, SEL) = (void *)imp;
            func(target, selector);
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
        
    }];
    
}
@end
