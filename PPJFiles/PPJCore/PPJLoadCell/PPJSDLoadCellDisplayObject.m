//
//  PPJSDLoadCellObject.m
//  Gabbermap
//
//  Created by Alex Padalko on 1/12/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPJSDLoadCellDisplayObject.h"
#import "PPJSDLoadCellDisplayView.h"
@interface PPJSDLoadCellDisplayObject ()

@property (nonatomic,weak)PPJSDLoadCellDisplayView *loadView;

@end


@implementation PPJSDLoadCellDisplayObject
@synthesize loadState=_loadState;
@synthesize shouldLoadAutomatic=_shouldLoadAutomatic;
-(instancetype)init{
    if (self=[super init]) {
        _loadState=PPJSDLoadStateTypeNone;
        self.shouldLoadAutomatic=YES;
        self.height=44;
    
    }
    return self;
}

-(void)setLoadState:(PPJSDLoadStateType)loadState{
    _loadState=loadState;
    [self.loadView setLoadState:_loadState];
}
-(id)responseForMappingRequest:(PPJSDMappingRequest)mappingRequest withAditionalData:(id)data andSpecifier:(id)specifier{
    
    
    switch (mappingRequest.requestType) {
            
            
            
            
        case PPJSDMappingRequestDataTypeSize:
            
            if (mappingRequest.postionType!=PPJSDMRPostionTypeDefault) {
                return 0;
            }
            
            
            return [NSValue valueWithCGSize:CGSizeMake(0,self.height)];
            break;
        case PPJSDMappingRequestDataTypeSubItemsCount:
            
            return [NSNumber numberWithInt:1];
        case PPJSDMappingRequestDataTypeMappingObject:{
            
            if (mappingRequest.postionType!=PPJSDMRPostionTypeDefault) {
                return nil;
            }
            
            
            
            @weakify(self);
            PPJSDMappingObject * mapObj=[PPJSDMappingObject mappingObjectWithClass:(self.customCellClass?self.customCellClass:[PPJSDLoadCellDisplayView class]) indif:@"d__PPP_l11" andConfigurateBlock:^(PPJSDLoadCellDisplayView  *viewToConfigurate) {
                @strongify(self);
                
                [viewToConfigurate setBaseViewDelegate:self];
                self.loadView=viewToConfigurate;
                [viewToConfigurate setLoadState:self.loadState];
                
                
            }];
            
            return mapObj;
            
            
            
        }
        default:
            break;
    }
    return nil;
}
@end
