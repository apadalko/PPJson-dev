//
// Created by Alex Padalko on 8/18/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//
#import "PPJObject.h"
#import "PPJNavigatior.h"

@interface PPJApp : PPJObject

+(instancetype)create;

@property  (nonatomic, retain) PPJNavigatior  * navigator;
@property  (nonatomic, retain) PPJClassesScope * classesScope;
@property  (nonatomic, retain) NSMutableDictionary * view_models;
@property  (nonatomic, retain) NSMutableDictionary * view_controllers;
@end