//
// Created by Alex Padalko on 8/19/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import "PPJObject.h"


@interface PPJRequestClient : PPJObject
@property  (nonatomic, retain)NSString * host;
@property  (nonatomic)BOOL bodyParametersInURL;
@end