//
//  PPJSDObject.m
//  Blok
//
//  Created by Alex Padalko on 4/14/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJSDObject.h"

@implementation PPJSDObject

@synthesize actionReciver;
-(void)calculateObjectInBackgroundWithSuperViewSize:(CGSize)size complBlock:(void(^)())complitBlock{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self calculateObjectInWithSuperViewSize:size];
        dispatch_async(dispatch_get_main_queue(), ^{
            complitBlock();
        });
        
    });
}
-(void)calculateObjectInWithSuperViewSize:(CGSize)size{
    self.size=size;
     
}
-(void)recalculate{
    [self calculateObjectInWithSuperViewSize:self.size];
}
-(void)recalculateInBackgroundComplBlock:(void(^)())complitBlock{
 //   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self recalculate];
    //    dispatch_async(dispatch_get_main_queue(), ^{
            complitBlock();
   //     });
        
  //  });
}

-(id)responseForMappingRequest:(PPJSDMappingRequest)mappingRequest withAditionalData:(id)data andSpecifier:(id)specifier{
    
    return nil;
}

///

-(void)sendActionType:(NSInteger)actionType{
    
    [self.actionReciver smartDisplayObject:self sendAction:[PPJAction actionWithType:actionType andData:nil]];
    
}
-(void)sendAction:(PPJAction*)action{
    [self.actionReciver smartDisplayObject:self sendAction:action];
}

@end
