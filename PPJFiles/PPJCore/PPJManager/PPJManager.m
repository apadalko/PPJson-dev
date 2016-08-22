//
//  PPJManager.m
//  PPJson
//
//  Created by Alex Padalko on 8/18/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPJManager.h"

@interface PPJManager ()



@end
@implementation PPJManager
static NSMutableDictionary * instances;
@synthesize workQuene=_workQuene;
- (dispatch_queue_t)workQuene {

    if (!_workQuene){
        NSString * quineName =[NSString stringWithFormat:@"com.ppj.manager.%@",  NSStringFromClass([self class])];
        _workQuene = dispatch_queue_create([quineName UTF8String],  0);
    }
    return _workQuene;
}
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
