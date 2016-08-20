//
// Created by Alex Padalko on 8/20/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PPJFabricPoolProt.h"
@interface PPJDefaultFabric : NSObject

+(instancetype)createWithScope:(NSDictionary *)scope;
@property  (nonatomic, weak)id<PPJFabricPoolProt> fabricPool;


-(id)getObjectForClassName:(NSString *)className;
@property (nonatomic, retain) NSDictionary * scope;


-(Class)findRequredClass:(NSString *)vcClassName;
-(Class)basicClass;
@end