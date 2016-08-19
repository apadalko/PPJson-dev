//
//  PPJSDObjectProtocol.h
//  PPJSmartDisplay
//
//  Created by Alex Padalko on 4/13/15.
//  Copyright (c) 2015 Alex Padalko. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "PPJSDObjectMappingProtocol.h"
#import "PPJSDMappingObject.h"
#import "PPJActionProt.h"
#import <UIKit/UIKit.h>

@protocol PPJSDObjectProtocol;
@protocol PPJSDObjectActionReciverProtocol <NSObject>


-(void)smartDisplayObject:(id<PPJSDObjectProtocol>)smartDisplayObject sendAction:(id<PPJActionProt>)action;
-(void)refresh:(id<PPJSDObjectProtocol>)smartDisplayObject;

//-(void)sendOuterAction:(id<PPJActionProt>)action thenInternalAction:(id<PPJActionProt>)iternalAction;
//-(void)sendInternalAction:(id<PPJActionProt>)iternalAction thenOuterAction:(id<PPJActionProt>)action;
//
//-(void)smartDisplayObject:(id<PPJSDObjectProtocol>)smartDisplayObject sendInternalAction:(id<PPJActionProt>)iternalAction;
//-(void)sendOuterAction:(id<PPJActionProt>)outerAction;

@end

@protocol PPJSDObjectProtocol <NSObject>
//+(void)calculateObjectsCollectionWithSuperViewSize:(CGSize)size complBlock:(void(^)())complitBlock;
-(void)calculateObjectInBackgroundWithSuperViewSize:(CGSize)size complBlock:(void(^)())complitBlock;
-(void)calculateObjectInWithSuperViewSize:(CGSize)size;
-(void)recalculate;
-(void)recalculateInBackgroundComplBlock:(void(^)())complitBlock;

-(id)responseForMappingRequest:(PPJSDMappingRequest)mappingRequest withAditionalData:(id)data andSpecifier:(id)specifier;


@property (nonatomic,weak)id<PPJSDObjectActionReciverProtocol> actionReciver;

@end
