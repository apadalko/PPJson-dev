//
//  PPJViewControllerMainConfigurationProt.h
//  Gabbermap
//
//  Created by Alex Padalko on 3/16/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPJNavigationAction.h"
@class UIColor;
@protocol PPJViewControllerMainConfigurationProt <NSObject>




-(UIColor*)ppjvc_defaultBackgroundColor;
-(BOOL)ppjvc_swipeBackEnabled;//YES
-(NSArray*)ppjvc_allowingSwitchTypes;
-(BOOL)ppjvc_shouldCreateWithNavigation;
-(Class)ppjvc_navigationControllerClass;


-(void)ppjvc_additionalViewControllerViewDidLoadSetup;

@end
