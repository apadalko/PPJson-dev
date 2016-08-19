//
//  RACSignal+Object.h
//  Blok
//
//  Created by Alex Padalko on 3/1/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "RACSignal.h"

@class PPJNavigationAction;
@interface RACSignal (Object)
+(instancetype)signalWithObject:(id)obj;
@end
