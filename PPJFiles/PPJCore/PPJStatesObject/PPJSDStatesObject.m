//
//  PPJSDStatesObject.m
//  Gabbermap
//
//  Created by Alex Padalko on 2/25/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPJSDStatesObject.h"
#import "PPJSDErrorView.h"
#import "PPJSDEmptyView.h"
#import "PPJSDLoadingView.h"

@interface PPJSDStatesObject ()

@end
@implementation PPJSDStatesObject
@synthesize availableSize=_availableSize;
@synthesize stateType=_stateType;
-(instancetype)initWithStateType:(PPJSDLoadStateType)stateType{
    
    if (self=[super init]) {
        self.stateType=stateType;
    }
    return self;
}

-(void)setStateType:(PPJSDLoadStateType)stateType{
    _stateType=stateType;
    
    
    if (stateType==PPJSDLoadStateTypeEmpty) {
        self.displayViewClass=[PPJSDEmptyView class];
    }else if (stateType == PPJSDLoadStateTypeLoading){
                self.displayViewClass=[PPJSDLoadingView class];
    }else if (stateType == PPJSDLoadStateTypeFail){
                self.displayViewClass=[PPJSDErrorView class];
    }
}

-(id)responseForMappingRequest:(PPJSDMappingRequest)mappingRequest withAditionalData:(id)data andSpecifier:(id)specifier{
    
    
    switch (mappingRequest.requestType) {
            
            
            
            
        case PPJSDMappingRequestDataTypeSize:
            
            if (mappingRequest.postionType!=PPJSDMRPostionTypeDefault) {
                return 0;
            }
            
            
            return [NSValue valueWithCGSize:CGSizeMake(0,self.availableSize.height)];
            break;
        case PPJSDMappingRequestDataTypeSubItemsCount:
            
            return [NSNumber numberWithInt:1];
        case PPJSDMappingRequestDataTypeMappingObject:{
            
            if (mappingRequest.postionType!=PPJSDMRPostionTypeDefault) {
                return nil;
            }
            
            
            
            @weakify(self);
            Class  cl=self.displayViewClass?self.displayViewClass:[PPJSDView class];
            PPJSDMappingObject * mapObj=[PPJSDMappingObject mappingObjectWithClass:cl indif:[NSString stringWithFormat:@"%@_%ld_S",NSStringFromClass(cl),self.stateType] andConfigurateBlock:^(PPJSDView  *viewToConfigurate) {
                @strongify(self);
                [viewToConfigurate setBackgroundColor:[UIColor clearColor]];
                [viewToConfigurate setBaseViewDelegate:self];
                self.displayView=viewToConfigurate;
                
                
            }];
            
            return mapObj;
            
            
            
        }
        default:
            break;
    }
    return nil;
}
@end
