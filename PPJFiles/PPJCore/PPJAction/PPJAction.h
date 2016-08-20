//
//  PPJAction.h
//  Blok
//
//  Created by Alex Padalko on 9/27/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPJActionProt.h"
#import "PPJObject.h"
typedef NS_ENUM(NSInteger, PPJActionType) {
    
  PPJActionTypeNone=-1
    
};
@interface PPJAction : PPJObject <PPJActionProt>
+(instancetype)actionWithName:(NSString *)name andValue:(id)value;
@property  (nonatomic, retain)NSString * name;
@property  (nonatomic, retain) id value;








@property (nonatomic)NSInteger actionType;
@property (nonatomic,retain)id data;
+(instancetype)actionWithType:(NSInteger)type andData:(id)data;
@end
