//
// Created by Alex Padalko on 8/18/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPJEvent.h"
#import "PPJEventObserverProt.h"

@interface PPJObject : NSObject
-(void)notifyObserversWithEvent:(PPJEvent*)event;
-(void)addEventObserver:(id<PPJEventObserverProt>)eventObserver withScope:(NSArray*)scope;
-(void)removeEventObserver:(id<PPJEventObserverProt>)eventObserver;
@end