//
//  RACSignal+SANavigationAction.h
//  Blok
//
//  Created by Alex Padalko on 9/24/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "RACSignal.h"
@class PPJNavigationAction;
@interface RACSignal (SANavigationAction)
+(instancetype)signalWithAction:(PPJNavigationAction*)action;
@end
