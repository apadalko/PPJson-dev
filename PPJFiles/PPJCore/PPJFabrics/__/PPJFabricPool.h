//
// Created by Alex Padalko on 8/20/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import "PPJObject.h"
#import "PPJDefaultFabric.h"
#import "PPJFabricPoolProt.h"
@interface PPJFabricPool : PPJObject <PPJFabricPoolProt>

+(instancetype)sharedInstance;
- (void)addFabric:(PPJDefaultFabric *)fabric ForRequestType:(PPJFabricPoolRequestType)requestType;
@end