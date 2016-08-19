//
//  PPJViewControllerConfigurationsManager.h
//  Gabbermap
//
//  Created by Alex Padalko on 3/16/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPJViewControllerConfiguratorProt.h"
#import "PPJViewControllerProt.h"
#import "PPJOptionListHandler.h"
@interface PPJViewControllerConfigurationsManager : NSObject
+(instancetype)sharedInstance;

-(void)registerDefaultConfiguratorClass:(Class<PPJViewControllerConfiguratorProt>)configuratorClass;
-(void)registerConfiguratorClass:(Class<PPJViewControllerConfiguratorProt>)configuratorClass forViewControllerClass:(Class<PPJViewControllerProt>)viewControllerClass;
-(void)registerDefaultOptionListHandler:(Class<PPJOptionListHandler>)handlerClass;
-(void)registerOptionListHandler:(Class<PPJOptionListHandler>)handlerClass forViewControllerClass:(Class<PPJViewControllerProt>)viewControllerClass;



-(id<PPJOptionListHandler>)optionListHanderForViewController:(UIViewController<PPJViewControllerProt>*)viewController;

-(id<PPJViewControllerConfiguratorProt>)configratorForViewController:(UIViewController<PPJViewControllerProt>*)viewController;
-(id<PPJViewControllerNavBarConfigurationProt>)barConfigratorForViewController:(UIViewController<PPJViewControllerProt>*)viewController;
-(id<PPJViewControllerMainConfigurationProt>)mainConfigratorForViewController:(UIViewController<PPJViewControllerProt>*)viewController;


@end
