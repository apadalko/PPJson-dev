//
// Created by Alex Padalko on 8/19/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import "PPJObject.h"


@interface PPJClassesScope : PPJObject
@property  (nonatomic, retain) NSDictionary * viewModels;
@property  (nonatomic, retain) NSDictionary * services;
@property  (nonatomic, retain) NSDictionary * clients;
@property  (nonatomic, retain) NSDictionary * viewControllers;
@end