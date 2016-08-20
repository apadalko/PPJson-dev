//
//  SANavigationAction.h
//  Blok
//
//  Created by Alex Padalko on 9/24/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol PPJViewControllerProt;
@protocol PPJViewModelProt;
typedef void(^PPJNavSwitchBlock)(id<PPJViewControllerProt> switchableVc);
typedef void(^PPJNavSwitchArrayBlock)(NSArray<PPJViewControllerProt> *switchablesVcs);




extern NSString *kPPJRouteDeadlock;
extern NSString *kPPJRoutePlayground;
typedef NS_ENUM(NSInteger, PPJNavigationRequestType) {

    PPJNavigationRequestTypeDefault,
    PPJNavigationRequestTypeCollection
    
};
@interface PPJNavigationAction : NSObject


+(instancetype)deadlock;

-(instancetype)initWithArrayOfRoutes:(NSArray*)routes fromVM:(id<PPJViewModelProt>)fromVM andVMData:(NSArray*)vmData andSwitchBlock:(void(^)(NSArray<PPJViewControllerProt> *switchablesVcs))switchBlock;;


-(instancetype)initWithRoute:(NSString *)route fromVM:(id<PPJViewModelProt>)fromVM andVMData:(NSArray*)vmData andSwitchBlock:(void(^)(id<PPJViewControllerProt> switchableVc))switchBlock;;


-(instancetype)initWithRoute:(NSString *)route fromVM:(id<PPJViewModelProt>)fromVM andViewModel:(id<PPJViewModelProt>)viewModel andSwitchBlock:(void(^)(id<PPJViewControllerProt> switchableVc))switchBlock;


+(instancetype)actionWithRoute:(NSString *)route fromVM:(id<PPJViewModelProt>)fromVM andViewModel:(id<PPJViewModelProt>)viewModel andSwitchBlock:(void(^)(id<PPJViewControllerProt> switchableVc))switchBlock;
+(instancetype)actionWithRoute:(NSString *)route fromVM:(id<PPJViewModelProt>)fromVM andVMData:(NSArray*)vmData andSwitchBlock:(void(^)(id<PPJViewControllerProt> switchableVc))switchBlock;


+(instancetype)actionWithArrayOfRoute:(NSArray*)routes fromVM:(id<PPJViewModelProt>)fromVM andVMData:(NSArray*)vmData andSwitchBlock:(void(^)(NSArray<PPJViewControllerProt> *switchablesVcs))switchBlock;;

@property (nonatomic,retain)id<PPJViewModelProt> viewModel;
@property (nonatomic,retain)NSArray * vmData;
@property (nonatomic)NSString * route;
@property (nonatomic)NSArray *  routes;
@property (weak,nonatomic)id<PPJViewModelProt>fromVM;

@property (nonatomic)PPJNavigationRequestType requestType;

@property (nonatomic,copy)PPJNavSwitchBlock switchBlock;
@property (nonatomic,copy)PPJNavSwitchBlock switchArrayBlock;

-(void)complitWithVc:(id<PPJViewControllerProt>)vc;

-(void)complitWithVCs:(NSArray<PPJViewControllerProt>*)vcs;

@end
