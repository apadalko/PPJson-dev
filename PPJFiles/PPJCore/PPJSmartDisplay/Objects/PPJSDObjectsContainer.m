//
//  MGPPJSDObjectContainer.m
//  Blok
//
//  Created by Alex Padalko on 6/12/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJSDObjectsContainer.h"
@interface PPJSDObjectsContainer()
@property (nonatomic,retain)NSMutableArray *subObjectsArray;
@end
@implementation PPJSDObjectsContainer


-(NSMutableArray *)subObjectsArray{
    
    if (! _subObjectsArray) {
        
        _subObjectsArray=[[NSMutableArray alloc] init];
        
        
    }
    return _subObjectsArray;
}

-(void)setActionReciver:(id<PPJSDObjectActionReciverProtocol>)actionReciver{
    [super setActionReciver:actionReciver];
    for (PPJSDObject * obj  in self.subObjectsArray) {
        [obj setActionReciver:actionReciver];
    }
    [self.headerObject setActionReciver:actionReciver];
    [self.footerObject setActionReciver:actionReciver];
}
-(void)setHeaderObject:(PPJSDObject *)headerObject{
    _headerObject=headerObject;
    [_headerObject setActionReciver:self.actionReciver];
 
}
-(void)setFooterObject:(PPJSDObject *)footerObject{
    _footerObject=footerObject;
    [_footerObject setActionReciver:self.actionReciver];
}
-(void)addSubObject:(PPJSDObject*)obj{
    
    [obj setActionReciver:self.actionReciver];
    
    [self.subObjectsArray addObject:obj];
    
}
-(void)addArrayOfSubObject:(NSArray*)objArr{
    for (PPJSDObject* obj in objArr) {
        [self addSubObject:obj];
    }
    
    
}


-(id)responseForMappingRequest:(PPJSDMappingRequest)mappingRequest withAditionalData:(id)data andSpecifier:(id)specifier{
    
    switch (mappingRequest.requestType) {
        case PPJSDMappingRequestDataTypeSize:
            if (mappingRequest.postionType!=PPJSDMRPostionTypeDefault) {
            
                if (mappingRequest.postionType==PPJSDMRPostionTypeFooter) {
                    return [self.footerObject responseForMappingRequest:mappingRequest withAditionalData:data andSpecifier:specifier];
                }else{
                    return [self.headerObject responseForMappingRequest:mappingRequest withAditionalData:data andSpecifier:specifier];
                }
                
                
            }else
            return [[self.subObjectsArray objectAtIndex:[data integerValue] ] responseForMappingRequest:mappingRequest withAditionalData:data andSpecifier:specifier];
            break;
        case PPJSDMappingRequestDataTypeSubItemsCount:
            return [NSNumber numberWithInteger:self.subObjectsArray.count];
        case PPJSDMappingRequestDataTypeMappingObject:{
            
            if (mappingRequest.postionType!=PPJSDMRPostionTypeDefault) {
                if (mappingRequest.postionType==PPJSDMRPostionTypeFooter) {
                    return [self.footerObject responseForMappingRequest:mappingRequest withAditionalData:data andSpecifier:specifier];
                }else{
                    return [self.headerObject responseForMappingRequest:mappingRequest withAditionalData:data andSpecifier:specifier];
                }
            }else
            
            return [[self.subObjectsArray objectAtIndex:[data integerValue] ] responseForMappingRequest:mappingRequest withAditionalData:data andSpecifier:specifier];
            
            
            
        }
        default:
            break;
    }
    return nil;
}
@end
