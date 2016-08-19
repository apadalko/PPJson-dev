//
//  PPJSDMappingObject.h
//  Blok
//
//  Created by Alex Padalko on 4/13/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import <Foundation/Foundation.h>
#import "PPJDisplayViewProt.h"
typedef NS_ENUM(NSInteger, PPJSDMappingRequestType) {
    
    PPJSDMappingRequestDataTypeSubItemsCount,
    PPJSDMappingRequestDataTypeSize,
    PPJSDMappingRequestDataTypeMappingObject,
    PPJSDMappingRequestDataTypeViewWillAppear,
    PPJSDMappingRequestDataTypeViewWillDissapear,
    
};
typedef NS_ENUM(NSInteger, PPJSDMRPostionType) {
    PPJSDMRPostionTypeNone,
    PPJSDMRPostionTypeDefault,
    PPJSDMRPostionTypeHeader,
    PPJSDMRPostionTypeFooter
};
typedef NS_ENUM(NSInteger, PPJSDMRRequesterType) {
    
    PPJSDMRRequesterTypeTableView,
    PPJSDMRRequesterTypeTableViewCollectionView,
    PPJSDMRRequesterTypeTableViewCollectionViewOther
};
struct PPJSDMappingRequest {
    
    PPJSDMRRequesterType requsterType;
    PPJSDMRPostionType postionType;
    PPJSDMappingRequestType requestType;
};
typedef struct PPJSDMappingRequest PPJSDMappingRequest;
static inline PPJSDMappingRequest PPJSDMappingRequestMake(PPJSDMRRequesterType requsterType, PPJSDMRPostionType postionType, PPJSDMappingRequestType requestType)
{
    struct PPJSDMappingRequest mappingRequest;
    mappingRequest.requestType=requestType;
    mappingRequest.requsterType=requsterType;
    mappingRequest.postionType=postionType;
    return mappingRequest;
}
typedef void(^ViewConfigurateBlock)(id viewToConfigurate);
@interface PPJSDMappingObject : NSObject

+(instancetype)mappingObjectWithClass:(Class<PPJDisplayViewProt>)viewClass indif:(NSString*)indif andConfigurateBlock:(void(^)(id viewToConfigurate))configurateBlock;

@property (nonatomic,retain)Class viewClass;
@property (nonatomic,retain)NSString * indifiter;
@property (nonatomic,retain)id additionalData;

@property (copy,nonatomic)ViewConfigurateBlock viewConfigurateBlock ;


-(instancetype)addAtitonalData:(id)aditionalData;


@end
