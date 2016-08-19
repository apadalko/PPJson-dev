//
//  PPJManager.m
//  PPJson
//
//  Created by Alex Padalko on 8/18/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPJManager.h"

@interface PPJManager ()

@property (nonatomic,retain)NSMutableDictionary * observersScopes;
@property (nonatomic,retain)dispatch_queue_t workQuene;

@end
@implementation PPJManager
static NSMutableDictionary * instances;
+(instancetype)sharedInstance{
    if (!instances) {
        instances=[[NSMutableDictionary alloc] init];
    }
    NSString * str =  NSStringFromClass([self class]);
    id inst = [instances valueForKey:str];
    if (!inst) {
        inst=[[self alloc] init];
        [instances setValue:inst forKey:str];
    }
    return inst;

}

@end
