//
//  PPJViewController.h
//  Blok
//
//  Created by Alex Padalko on 9/27/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPJViewControllerProt.h"
#import "PPJNavigationController.h"
#import "PPJViewControllerNavBarConfigurationProt.h"
#import "UIViewController+NavBarConfigurator.h"
#import "PPJTextHelper.h"
#import "UIColor+HEX.h"
@interface PPJViewController : UIViewController<PPJViewControllerProt,PPJViewControllerNavBarConfigurationProt>




@end
