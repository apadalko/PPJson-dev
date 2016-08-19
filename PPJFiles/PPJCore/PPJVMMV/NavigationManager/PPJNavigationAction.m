//
//  SANavigationAction.m
//  Blok
//
//  Created by Alex Padalko on 9/24/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "PPJNavigationAction.h"

@implementation PPJNavigationAction

+(instancetype)deadlock{
    return [[self alloc] initWithDirection:PPJNavigationDeadLock fromVM:nil andViewModel:nil andSwitchBlock:nil];
}
+(instancetype)actionWithDirection:(NSInteger)direction  fromVM:(id<PPJViewModelProt>)fromVM andVMData:(NSArray*)vmData andSwitchBlock:(void(^)(id<PPJViewControllerProt> sitchableVc))switchBlock{
    
     return [[self alloc] initWithDirection:direction fromVM:(id<PPJViewModelProt>)fromVM  andVMData:vmData andSwitchBlock:switchBlock];
    
}

+(instancetype)actionWithDirection:(NSInteger)direction fromVM:(id<PPJViewModelProt>)fromVM  andViewModel:(id<PPJViewModelProt>)viewModel andSwitchBlock:(void(^)(id<PPJViewControllerProt> sitchableVc))switchBlock{
    
    return [[self alloc] initWithDirection:direction fromVM:(id<PPJViewModelProt>)fromVM andViewModel:viewModel andSwitchBlock:switchBlock];
}
+(instancetype)actionWithArrayOfDirections:(NSArray *)directions fromVM:(id<PPJViewModelProt>)fromVM andVMData:(NSArray *)vmData andSwitchBlock:(void (^)(NSArray<PPJViewControllerProt> *switchablesVc))switchBlock{
    
    
       return [[self alloc] initWithArrayOfDirections:directions fromVM:fromVM andVMData:vmData andSwitchBlock:switchBlock];
}

-(instancetype)initWithDirection:(NSInteger)direction fromVM:(id<PPJViewModelProt>)fromVM andVMData:(NSArray*)vmData andSwitchBlock:(void(^)(id<PPJViewControllerProt> sitchableVc))switchBlock{
    if (self=[super init]) {
        
        self.fromVM=fromVM;
        self.direction=direction;
        self.vmData=vmData;
        self.switchBlock=switchBlock;
        self.requestType=SANavigationRequestTypeDefault;
    }
    return self;
}


-(instancetype)initWithDirection:(NSInteger)direction fromVM:(id<PPJViewModelProt>)fromVM  andViewModel:(id<PPJViewModelProt>)viewModel andSwitchBlock:(void(^)(id<PPJViewControllerProt> sitchableVc))switchBlock{
    
    
    if (self=[super init]) {
     
        self.direction=direction;
        self.viewModel=viewModel;
        self.switchBlock=switchBlock;
        self.fromVM=fromVM;
           self.requestType=SANavigationRequestTypeDefault;
    }
    return self;
}

-(instancetype)initWithArrayOfDirections:(NSArray *)directions fromVM:(id<PPJViewModelProt>)fromVM andVMData:(NSArray *)vmData andSwitchBlock:(void (^)(NSArray<PPJViewControllerProt> *))switchBlock{
    
    if (self=[super init]) {
        
        self.directions=directions;
        self.switchArrayBlock=switchBlock;
        self.fromVM=fromVM;
        self.vmData=vmData;
        self.requestType=SANavigationRequestTypeCollection;
    }
    return self;
    
}
-(void)complitWithVCs:(NSArray<PPJViewControllerProt> *)vcs{
    
    if (self.switchArrayBlock) {
        self.switchArrayBlock(vcs);
        self.switchArrayBlock=nil;
    }
}
-(void)complitWithVc:(id<PPJViewControllerProt>)vc{
    
    
    
    if (self.switchBlock) {
        self.switchBlock(vc);
        self.switchBlock=nil;
    }
    
}
-(void)dealloc{
    NSLog(@"DEALLOC %@",self);
    
}
@end
