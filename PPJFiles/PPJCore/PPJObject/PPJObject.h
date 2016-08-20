//
// Created by Alex Padalko on 8/18/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPJEvent.h"
#import "PPJEventObserverProt.h"
#import <MJExtension/MJExtension.h>
#import "PPJQueue.h"

@interface PPJObject : NSObject<PPJEventObserverProt>
@property (nonatomic,retain)dispatch_queue_t workQuene;
-(void)switchToWorkQueue:(void(^)())queueBlock;
-(void)switchToMainQueue:(void(^)())queueBlock;
-(void)notifyObserversWithEvent:(PPJEvent*)event;
-(void)addEventObserver:(id<PPJEventObserverProt>)eventObserver withScope:(NSArray*)scope;
-(void)removeEventObserver:(id<PPJEventObserverProt>)eventObserver;
@end