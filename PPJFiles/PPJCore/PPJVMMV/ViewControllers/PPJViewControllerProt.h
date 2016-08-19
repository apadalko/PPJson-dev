//
//  PPJViewControllerProt.h
//  Blok
//
//  Created by Alex Padalko on 9/23/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//


#import "PPJViewModelProt.h"
#import "PPJNavigationAction.h"
#import "PPJOptionsListObject.h"
#import "PPJViewControllerConfiguratorProt.h"
@protocol PPJViewControllerProt <PPJViewControllerConfiguratorProt>

+(instancetype)createWithViewModel:(id<PPJViewModelProt>)viewModel;
@property (nonatomic,retain)id<PPJViewModelProt>viewModel;
@property (nonatomic,retain) UIButton * leftBarButton;
@property (nonatomic,retain)id<PPJViewControllerConfiguratorProt> ppjvc_configurator;


-(void)viewModelDidBind;


-(void)ppjvc_backAction;
-(void)ppjvc_closeAction;


-(void)ppjvc_didReciveSwitchPack:(PPJSwitchPack*)switchPack;
-(void)ppjvc_didReciveOptionList:(PPJOptionsListObject*)optionList;


@end
#import "UIViewController+PPJViewControllerProt.h"
#import "UIViewController+NavBarConfigurator.h"