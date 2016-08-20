//
// Created by Alex Padalko on 8/20/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import "PPJFabricPool.h"


@interface  PPJFabricPool ()
@property  (nonatomic, retain)NSMutableDictionary * fabrics;
@end

@implementation PPJFabricPool {



}
static PPJFabricPool  * pool;
+(instancetype)sharedInstance {
    if (!pool){

        pool =[[PPJFabricPool alloc] init];
    }
    return pool;
}
- (void)addFabric:(PPJDefaultFabric *)fabric ForRequestType:(PPJFabricPoolRequestType)requestType {


    [fabric setFabricPool:self];
    [self.fabrics setValue:fabric forKey:[NSString stringWithFormat:@"%ld",requestType]];
}

- (id)getObjectForRequestType:(PPJFabricPoolRequestType)requestType className:(NSString *)className {



    PPJDefaultFabric * f =[self.fabrics valueForKey:[NSString stringWithFormat:@"%ld",requestType]];

    return [f getObjectForClassName:className];

}
- (NSMutableDictionary *)fabrics {
    if (!_fabrics){
_fabrics=[[NSMutableDictionary alloc] init];
    }
    return _fabrics;
}
@end