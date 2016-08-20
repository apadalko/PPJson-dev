//
// Created by Alex Padalko on 8/20/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import "PPJDefaultFabric.h"
#import "PPJObject.h"

@interface  PPJDefaultFabric()

@end


@implementation PPJDefaultFabric {

}



+(instancetype)createWithScope:(NSDictionary *)scope{
    PPJDefaultFabric * fabric =[[self alloc] init];
    fabric.scope=scope;
    return fabric;
}
-(id)getObjectForClassName:(NSString *)className{
    return nil;
}

-(Class)findRequredClass:(NSString *)vcClassName{
    NSDictionary * vcData = [self.scope valueForKey:vcClassName];
    Class coreVCClass=NSClassFromString(vcClassName);
    if (coreVCClass){
        return coreVCClass;
    } else{
        NSString * superClassName = [vcData valueForKey:@"$super"];
        if (!superClassName){
#pragma mark TODO - make auto find depend on VM
            return [self basicClass];

        } else{
            return  [self findRequredClass:superClassName];
        }
    }
}
-(Class)basicClass{
    return [PPJObject class];
}

@end