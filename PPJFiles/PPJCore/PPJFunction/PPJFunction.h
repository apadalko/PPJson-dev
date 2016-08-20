//
// Created by Alex Padalko on 8/19/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import "PPJObject.h"


@interface PPJFunction : PPJObject
@property  (nonatomic, retain) NSArray * params;
@property  (nonatomic, retain) NSString * js;
@property  (nonatomic, retain) NSString * result;
-(id)callFunction:(PPJObject *)caller;
-(void)callFunctionInBackground:(PPJObject *)caller complitBlock:(void(^)(id value))complitBlock;
@end