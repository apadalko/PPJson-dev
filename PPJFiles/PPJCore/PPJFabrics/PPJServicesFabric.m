//
// Created by Alex Padalko on 8/20/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import "PPJServicesFabric.h"
#import "PPJService.h"
@interface PPJServicesFabric ()

@property  (nonatomic, retain) NSMutableDictionary * uniqueServices;
@end
@implementation PPJServicesFabric {

}


-(id)getObjectForClassName:(NSString *)className{

    PPJService * service = [self.uniqueServices valueForKey:className];
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

    if ([service unique]==YES){
        [self.uniqueServices setValue:service forKey:className];
    }

    return service;

}

- (Class)basicClass {

    return [PPJService class];
}
- (NSMutableDictionary *)uniqueServices {

    if (!_uniqueServices    ){
        _uniqueServices=[[NSMutableDictionary alloc] init];

    }
    return _uniqueServices;
}
@end