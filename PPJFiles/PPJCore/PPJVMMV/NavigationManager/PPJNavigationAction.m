//
//  SANavigationAction.m
//  Blok
//
//  Created by Alex Padalko on 9/24/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "PPJNavigationAction.h"

NSString *kPPJRouteDeadlock = @"$deadlock";
NSString *kPPJRoutePlayground = @"$playground";

@implementation PPJNavigationAction

+(instancetype)deadlock{
    return [[self alloc] initWithRoute:kPPJRouteDeadlock fromVM:nil andViewModel:nil andSwitchBlock:nil];
}
+(instancetype)actionWithRoute:(NSString *)route  fromVM:(id<PPJViewModelProt>)fromVM andVMData:(NSArray*)vmData andSwitchBlock:(void(^)(id<PPJViewControllerProt> sitchableVc))switchBlock{
    
     return [[self alloc] initWithRoute:route fromVM:(id<PPJViewModelProt>)fromVM  andVMData:vmData andSwitchBlock:switchBlock];
    
}

+(instancetype)actionWithRoute:(NSString * )route fromVM:(id<PPJViewModelProt>)fromVM  andViewModel:(id<PPJViewModelProt>)viewModel andSwitchBlock:(void(^)(id<PPJViewControllerProt> sitchableVc))switchBlock{
    
    return [[self alloc] initWithRoute:route fromVM:(id<PPJViewModelProt>)fromVM andViewModel:viewModel andSwitchBlock:switchBlock];
}
+(instancetype)initWithArrayOfRoutes:(NSArray *)routes fromVM:(id<PPJViewModelProt>)fromVM andVMData:(NSArray *)vmData andSwitchBlock:(void (^)(NSArray<PPJViewControllerProt> *switchablesVc))switchBlock{
    
    
       return [[self alloc] initWithArrayOfRoutes:routes fromVM:fromVM andVMData:vmData andSwitchBlock:switchBlock];
}

-(instancetype)initWithRoute:(NSString *)route fromVM:(id<PPJViewModelProt>)fromVM andVMData:(NSArray*)vmData andSwitchBlock:(void(^)(id<PPJViewControllerProt> sitchableVc))switchBlock{
    if (self=[super init]) {
        
        self.fromVM=fromVM;
        self.route=route;
        self.vmData=vmData;
        self.switchBlock=switchBlock;
        self.requestType=PPJNavigationRequestTypeDefault;
    }
    return self;
}


-(instancetype)initWithRoute:(NSString *)route fromVM:(id<PPJViewModelProt>)fromVM  andViewModel:(id<PPJViewModelProt>)viewModel andSwitchBlock:(void(^)(id<PPJViewControllerProt> sitchableVc))switchBlock{
    
    
    if (self=[super init]) {
        self.route=route;
        self.viewModel=viewModel;
        self.switchBlock=switchBlock;
        self.fromVM=fromVM;
        self.requestType=PPJNavigationRequestTypeDefault;
    }
    return self;
}

-(instancetype)initWithArrayOfRoutes:(NSArray *)routes fromVM:(id<PPJViewModelProt>)fromVM andVMData:(NSArray *)vmData andSwitchBlock:(void (^)(NSArray<PPJViewControllerProt> *))switchBlock{
    
    if (self=[super init]) {
        
        self.routes=routes;
        self.switchArrayBlock=switchBlock;
        self.fromVM=fromVM;
        self.vmData=vmData;
        self.requestType=PPJNavigationRequestTypeCollection;
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
