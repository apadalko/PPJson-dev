//
//  PPJActionProt.h
//  Blok
//
//  Created by Alex Padalko on 4/14/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, PPJActionResponse) {
    PPJActionResponseNone,
    PPJActionResponseReloadParticularSection,
    PPJActionResponseReloadAllData,
    
};
@protocol PPJActionProt <NSObject>
@property (nonatomic)NSInteger actionType;
@property (nonatomic,retain)id data;
@end
