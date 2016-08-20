//
//  PPJEvent.m
//  PPJson
//
//  Created by Alex Padalko on 8/18/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPJEvent.h"

@implementation PPJEvent
- (instancetype)init {

    if (self=[super init]){

        self.alive=YES;

    }
    return self;
}
- (void)kill {
    self.alive=NO;
}
@end
