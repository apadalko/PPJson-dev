//
// Created by Alex Padalko on 8/18/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//
#import "PPJObject.h"
#import "PPJNavigatior.h"


#import "PPJServicesFabric.h"
#import "PPJClientsFabric.h"
#import "PPJScreenFabric.h"
@interface PPJApp : PPJObject

+(instancetype)create;

@property  (nonatomic, retain) PPJNavigatior  * navigator;
@property  (nonatomic, retain) PPJClassesScope * classesScope;




@property  (nonatomic, retain) PPJScreenFabric * screenFabric;
@property  (nonatomic, retain) PPJServicesFabric * servicesFabric;
@property  (nonatomic, retain) PPJClientsFabric * clientsFabric;

@end