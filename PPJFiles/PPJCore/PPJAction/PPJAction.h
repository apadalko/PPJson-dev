//
//  PPJAction.h
//  Blok
//
//  Created by Alex Padalko on 9/27/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPJActionProt.h"
typedef NS_ENUM(NSInteger, PPJActionType) {
    
  PPJActionTypeNone=-1
    
};
@interface PPJAction : NSObject<PPJActionProt>
@property (nonatomic)NSInteger actionType;
@property (nonatomic,retain)id data;
+(instancetype)actionWithType:(NSInteger)type andData:(id)data;
@end
