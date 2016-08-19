//
//  PPJWaiter.h
//  Gabbermap
//
//  Created by Alex Padalko on 1/5/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPJWaiter : NSObject
-(instancetype)initWithTarget:(id)target andSelector:(SEL)selector;
-(void)invalidate;
-(void)wait;
@property (nonatomic)float waitTime;
@end
