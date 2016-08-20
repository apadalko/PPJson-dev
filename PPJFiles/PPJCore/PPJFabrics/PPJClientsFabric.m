//
// Created by Alex Padalko on 8/20/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import "PPJClientsFabric.h"
#import "PPJRequestClient.h"
@interface PPJClientsFabric ()

@property  (nonatomic, retain)NSMutableDictionary * exsitedClients;

@end
@implementation PPJClientsFabric {

}

-(id)getObjectForClassName:(NSString *)className{

    PPJRequestClient * service = [self.exsitedClients valueForKey:className];
    if (service){
        return service;
    }

    NSDictionary * data  =[[self scope] valueForKey:className];
    Class  serviceClass = NSClassFromString(className);
    if (serviceClass){
        service=[serviceClass mj_objectWithKeyValues:data];
    } else{
        serviceClass = [self findRequredClass:className];
        service =[serviceClass mj_objectWithKeyValues:data];
    }


    return service;

}

- (Class)basicClass {

    return [PPJRequestClient class];
}
- (NSMutableDictionary *)uniqueServices {

    if (!_exsitedClients    ){
        _exsitedClients=[[NSMutableDictionary alloc] init];

    }
    return self;
}
@end