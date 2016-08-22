//
//  PPJViewModelProt.h
//  Blok
//
//  Created by Alex Padalko on 9/24/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PPJNavigationAction.h"
#import "PPJSwitchPack.h"
#import "PPJAction.h"
#import "PPJViewControllerProt.h"
#import "PPJSDObjectDelegate.h"
@protocol PPJViewModelProt <PPJSDObjectDelegate>

#pragma mark - new
-(void)activateActionWithName:(NSString *)name andData:(id)data;
-(void)activateAction:(PPJAction*)action;
@property (nonatomic, retain) NSDictionary * actions;

#pragma mark - old








-(void)dataDidLoad;
@property (nonatomic,retain)RACSignal * navigationSignal;
@property (nonatomic,retain)RACSignal * actionSignal;
@property (nonatomic,retain)RACSignal * switchViewControllerSignal;///ractuple with PPJViewControllerProt + switchType

-(void)didAddedSubVM:(id<PPJViewModelProt>)vm;
-(PPJActionResponse)didReciveAction:(id<PPJActionProt>)action;


@property (nonatomic,retain)RACSignal * viewDidLoadSignal;

@property (retain,nonatomic)RACSignal * viewWillAppearSignal;
@property (retain,nonatomic)RACSignal * viewDidAppearSignal;
@property (retain,nonatomic)RACSignal * viewDidDissapiarSignal;
@property (retain,nonatomic)RACSignal * viewWillDissapiarSignal;
@property (nonatomic,retain)RACSignal * presentOptionsList;





@end
