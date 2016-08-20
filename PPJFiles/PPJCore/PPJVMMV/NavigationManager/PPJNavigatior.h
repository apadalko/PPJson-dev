//
//  PPJNavigatior.h
//  Blok
//
//  Created by Alex Padalko on 9/27/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPJViewModelProt.h"
#import "PPJNavigationAction.h"
#import "PPJFunction.h"
#import "PPJClassesScope.h"
@class PPJApp;
@class UIWindow;

@interface PPJNavigatior : PPJObject
-(instancetype)initWithWindow:(UIWindow*)window;


@property  (nonatomic, retain)NSDictionary  * routes;
@property  (nonatomic,weak)UIWindow * window;
@property  (nonatomic, weak) PPJApp * ppjApp;

@property  (nonatomic, retain)PPJFunction * pathFunction;


-(void)loadNavigation;
-(void)didReciveNavigationAction:(PPJNavigationAction*)navigationAction;




-(id<PPJViewModelProt>)viewModelByDirection:(NSInteger)direction andData:(NSArray*)vmData;
-(id<PPJViewControllerProt>)viewControllerByDirection:(NSInteger)direction andViewModel:(id<PPJViewModelProt>)viewModel;


@end
