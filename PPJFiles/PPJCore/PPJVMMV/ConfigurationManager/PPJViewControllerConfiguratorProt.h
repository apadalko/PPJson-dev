//
//  PPJViewControllerConfigurator.h
//  Gabbermap
//
//  Created by Alex Padalko on 3/16/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPJViewControllerMainConfigurationProt.h"
#import "PPJViewControllerNavBarConfigurationProt.h"
@class UIViewController;
@protocol PPJViewControllerConfiguratorProt <PPJViewControllerMainConfigurationProt,PPJViewControllerNavBarConfigurationProt>
@property (weak,nonatomic)UIViewController<PPJViewControllerProt> * controllerRefirence;
@end
