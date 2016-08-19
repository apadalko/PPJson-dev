//
//  PPJWaiter.m
//  Gabbermap
//
//  Created by Alex Padalko on 1/5/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPJWaiter.h"
@interface PPJWaiter ()
@property (nonatomic,weak)id target;
@property (nonatomic)SEL seletor;
@property (nonatomic)BOOL invalidated;

@property (nonatomic,retain)NSTimer *timer;
@end
@implementation PPJWaiter
-(instancetype)initWithTarget:(id)target andSelector:(SEL)selector{
    if (self=[super init]) {
        self.invalidated=NO;
        self.target=target;
        self.seletor=selector;
        self.waitTime=0.2;
    }
    return self;
}
-(void)invalidate{
    _invalidated=YES;
}
-(void)onWait{
    if (self.invalidated) {
        
        return;
    }
    NSLog(@"end wait");
         [self.target performSelector:self.seletor withObject:nil];
  
}
-(void)wait{

    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.timer=[NSTimer scheduledTimerWithTimeInterval:self.waitTime target:self selector:@selector(onWait) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer: self.timer
                                  forMode:NSRunLoopCommonModes];
        NSLog(@"start wait");
    });
//    return;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//     
//        sleep(self.waitTime);
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            if (!self.invalidated) {
//                
//                  [self.target performSelector:self.seletor withObject:nil]; 
//            }else{
//                    
//            }
//         
//            
//        });
//    });
    
}
@end
