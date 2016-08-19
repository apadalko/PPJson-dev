//
//  PPJAction.m
//  Blok
//
//  Created by Alex Padalko on 9/27/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "PPJAction.h"

@implementation PPJAction
+(instancetype)actionWithType:(NSInteger)type andData:(id)data{

    PPJAction * act=[[self alloc] init];
    act.actionType=type;
    act.data=data;
    return act;
    
    
    
}
@end
