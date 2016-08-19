//
//  PPJSDMappingObject.m
//  Blok
//
//  Created by Alex Padalko on 4/13/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJSDMappingObject.h"

@implementation PPJSDMappingObject
@synthesize viewConfigurateBlock=_viewConfigurateBlock;
+(instancetype)mappingObjectWithClass:(Class)viewClass indif:(NSString *)indif andConfigurateBlock:(void (^)(id))configurateBlock{
    
    PPJSDMappingObject * obj=[[self alloc] init];
    obj.indifiter=indif;
    obj.viewClass=viewClass;
    obj.viewConfigurateBlock=configurateBlock;
    return obj;
    
}

-(ViewConfigurateBlock)viewConfigurateBlock{
    
    
    if (!_viewConfigurateBlock) {
        _viewConfigurateBlock=^(id a){
            
        };
    }
    return _viewConfigurateBlock;
}
-(void)dealloc{
    

}

-(instancetype)addAtitonalData:(id)aditionalData{
    
    self.additionalData=aditionalData;
    
    return self;
}
@end
