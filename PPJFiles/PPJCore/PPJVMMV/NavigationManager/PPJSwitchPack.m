//
//  PPJSwitchPack.m
//  Blok
//
//  Created by Alex Padalko on 9/24/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "PPJSwitchPack.h"

@implementation PPJSwitchPack
+(instancetype)packWithVC:(id<PPJViewControllerProt>)vc andSwitchType:(PPJSwitchType)switchType{
    return [[self alloc] initWithVC:vc andSwitchType:switchType];
}
-(instancetype)initWithVC:(id<PPJViewControllerProt>)vc andSwitchType:(PPJSwitchType)switchType{
    
    if (self=[super init]) {
        self.animated=YES;
        self.vc=vc;
        self.switchType=switchType;
    }
    return self;
}
-(instancetype)setSwitchAnimated:(BOOL)animated{
    
    self.animated=animated;
    return self;
}
@end
