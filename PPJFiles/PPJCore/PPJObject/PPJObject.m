//
// Created by Alex Padalko on 8/18/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import "PPJObject.h"

#import "PPJQueue.h"
@implementation PPJObject {

}


-(instancetype)init{
    if (self=[super init]) {
        NSString * quineName =[NSString stringWithFormat:@"com.ppj.manager.%@",  NSStringFromClass([self class])];
        [self observersScopes];
        self.workQuene = dispatch_queue_create([quineName UTF8String],  0);

    }
    return self;
}
-(void)notifyObserversWithEvent:(PPJEvent *)event{

    [PPJQueue switch_to_queue:self.workQuene queueBlock:^{

        NSHashTable * scopeObservers = [self.observersScopes valueForKey:[event eventName]];
        if (scopeObservers) {

            for (id<PPJEventObserverProt> eventObserver in scopeObservers) {
                [eventObserver ppj_didReceiveEvent:event];
            }

        }

    }];

}
-(void)addEventObserver:(id<PPJEventObserverProt>)eventObserver withScope:(NSArray *)scope{
    [PPJQueue switch_to_queue:self.workQuene queueBlock:^{


        for (NSString * scope_name in scope) {

            NSHashTable * scopeObservers = [self.observersScopes valueForKey:scope_name];
            if (!scopeObservers) {
                scopeObservers=[NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
                [self.observersScopes setObject:scopeObservers forKey:scope_name];
            }
            else  if ([scopeObservers containsObject:eventObserver]) {
                continue;
            }
            [scopeObservers addObject:eventObserver];
        }
    }];
}
-(void)removeEventObserver:(id<PPJEventObserverProt>)eventObserver{

    [PPJQueue switch_to_queue:self.workQuene queueBlock:^{


        for (NSString * key  in self.observersScopes) {
            NSHashTable * scopeObservers = [self.observersScopes valueForKey:key];

            if (scopeObservers) {

                while (      [scopeObservers containsObject:eventObserver]) {
                    [scopeObservers removeObject:eventObserver];
                }
            }
        }


    }];

}

-(NSMutableDictionary *)observersScopes{
    if (!_observersScopes) {
        _observersScopes=[[NSMutableDictionary alloc] init];
    }
    return _observersScopes;
}

@end