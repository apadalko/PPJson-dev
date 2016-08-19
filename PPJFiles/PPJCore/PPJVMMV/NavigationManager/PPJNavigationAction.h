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
typedef void(^SANavSwitchBlock)(id<PPJViewControllerProt> switchableVc);
typedef void(^SANavSwitchArrayBlock)(NSArray<PPJViewControllerProt> *switchablesVcs);
typedef NS_ENUM(NSInteger, PPJNavigationDirection) {

    //initial
   PPJNavigationDeadLock,
      
    
};

typedef NS_ENUM(NSInteger, SANavigationRequestType) {
    
    SANavigationRequestTypeDefault,
    SANavigationRequestTypeCollection
    
};
@interface PPJNavigationAction : NSObject


+(instancetype)deadlock;

-(instancetype)initWithArrayOfDirections:(NSArray*)directions fromVM:(id<PPJViewModelProt>)fromVM andVMData:(NSArray*)vmData andSwitchBlock:(void(^)(NSArray<PPJViewControllerProt> *switchablesVcs))switchBlock;;


-(instancetype)initWithDirection:(NSInteger)direction fromVM:(id<PPJViewModelProt>)fromVM andVMData:(NSArray*)vmData andSwitchBlock:(void(^)(id<PPJViewControllerProt> switchableVc))switchBlock;;


-(instancetype)initWithDirection:(NSInteger)direction fromVM:(id<PPJViewModelProt>)fromVM andViewModel:(id<PPJViewModelProt>)viewModel andSwitchBlock:(void(^)(id<PPJViewControllerProt> switchableVc))switchBlock;


+(instancetype)actionWithDirection:(NSInteger)direction fromVM:(id<PPJViewModelProt>)fromVM andViewModel:(id<PPJViewModelProt>)viewModel andSwitchBlock:(void(^)(id<PPJViewControllerProt> switchableVc))switchBlock;
+(instancetype)actionWithDirection:(NSInteger)direction fromVM:(id<PPJViewModelProt>)fromVM andVMData:(NSArray*)vmData andSwitchBlock:(void(^)(id<PPJViewControllerProt> switchableVc))switchBlock;


+(instancetype)actionWithArrayOfDirections:(NSArray*)directions fromVM:(id<PPJViewModelProt>)fromVM andVMData:(NSArray*)vmData andSwitchBlock:(void(^)(NSArray<PPJViewControllerProt> *switchablesVcs))switchBlock;;

@property (nonatomic,retain)id<PPJViewModelProt> viewModel;
@property (nonatomic,retain)NSArray * vmData;
@property (nonatomic)NSInteger direction;
@property (nonatomic)NSArray *  directions;
@property (weak,nonatomic)id<PPJViewModelProt>fromVM;

@property (nonatomic)SANavigationRequestType requestType;

@property (nonatomic,copy)SANavSwitchBlock switchBlock;
@property (nonatomic,copy)SANavSwitchBlock switchArrayBlock;

-(void)complitWithVc:(id<PPJViewControllerProt>)vc;

-(void)complitWithVCs:(NSArray<PPJViewControllerProt>*)vcs;

@end
