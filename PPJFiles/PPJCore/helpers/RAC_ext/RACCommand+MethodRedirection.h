//
//  RACCommand+MethodRedirection.h
//  Blok
//
//  Created by Alex Padalko on 9/24/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "RACCommand.h"

@interface RACCommand (MethodRedirection)
+(RACCommand*)commandWithTarget:(id)target andSelector:(SEL)selector;
@end
