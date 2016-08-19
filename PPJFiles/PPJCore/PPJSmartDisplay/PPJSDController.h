//
//  PPJSDController.h
//  PPJSmartDisplay
//
//  Created by Alex Padalko on 4/11/15.
//  Copyright (c) 2015 Alex Padalko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPJSDDirectorProtocol.h"
#import "PPJSDMutableArray.h"

#import "PPJSDControllerViewProtocol.h"

@interface PPJSDController : NSObject
@property (nonatomic,retain)id specifier;
+(instancetype)displayControllerWithView:(id)view;
+(instancetype)displayControllerWithView:(id<PPJSDControllerViewProtocol>)view andDirector:(id<PPJSDirectorProtocol>)director;
+(instancetype)displayControllerWithView:(id<PPJSDControllerViewProtocol>)view andDirector:(id<PPJSDirectorProtocol>)director andSpecifier:(id)spec;

@property (nonatomic,strong)dispatch_queue_t workQuene;

@property (weak,nonatomic)id <PPJSDControllerViewProtocol>    bindedView;
@property (weak,nonatomic)id <PPJSDirectorProtocol>          director;

-(void)update;




@end
