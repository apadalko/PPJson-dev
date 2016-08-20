//
// Created by Alex Padalko on 8/20/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM (NSInteger,PPJFabricPoolRequestType){
    PPJFabricPoolRequestTypeService,
    PPJFabricPoolRequestTypeManager,
    PPJFabricPoolRequestTypeClient

};
@protocol PPJFabricPoolProt <NSObject>

-(id)getObjectForRequestType:(PPJFabricPoolRequestType)requestType className:(NSString *)className;

@end