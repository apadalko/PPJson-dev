//
//  PPJNavigationManager.m
//  Blok
//
//  Created by Alex Padalko on 9/27/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "PPJNavigationManager.h"

@implementation PPJNavigationManager

-(instancetype)initWithWindow:(UIWindow *)window{
    
    if (self=[super init]) {
        
        self.window=window;
    }
    return self;
}

-(void)loadNavigation{
    
    
}
-(void)didReciveNavigationAction:(PPJNavigationAction *)navigationAction{
    if (navigationAction.requestType==SANavigationRequestTypeDefault) {
        if (navigationAction.direction==PPJNavigationDeadLock) {
            [self loadNavigation];
            return;
        }
        
        
        
        
        id <PPJViewModelProt> vm;
        
        
        if (navigationAction.viewModel) {
            vm=navigationAction.viewModel;
        }else{
            vm = [self viewModelByDirection: navigationAction.direction
                                    andData:navigationAction.vmData];
            @weakify(self);
            [RACObserve(vm, navigationSignal) subscribeNext:^(RACSignal * sig) {
                
                if (sig) {
                    [sig subscribeNext:^(id x) {
                        
                        if (x) {
                            @strongify(self);
                            [self didReciveNavigationAction:x];
                        }
                        
                    }];
                }
                
            }];
            
        }
        id <PPJViewControllerProt> vc = [self viewControllerByDirection:navigationAction.direction andViewModel:vm];
        [navigationAction.fromVM didAddedSubVM:vm];
        
        [navigationAction complitWithVc:vc];
    }else if (navigationAction.requestType==SANavigationRequestTypeCollection) {
        
        NSMutableArray<PPJViewControllerProt> * vcsToSwithc=[[NSMutableArray<PPJViewControllerProt> alloc] init];
        for (NSNumber * direction in navigationAction.directions) {
            id <PPJViewModelProt> vm;
                 vm = [self viewModelByDirection:[direction integerValue] andData:navigationAction.vmData];
            @weakify(self);
            [RACObserve(vm, navigationSignal) subscribeNext:^(RACSignal * sig) {
                
                if (sig) {
                    [sig subscribeNext:^(id x) {
                        
                        if (x) {
                            @strongify(self);
                            [self didReciveNavigationAction:x];
                        }
                        
                    }];
                }
                
            }];
            
            [vcsToSwithc addObject:[self viewControllerByDirection:[direction integerValue] andViewModel:vm]];
            [navigationAction.fromVM didAddedSubVM:vm];
        }
        [navigationAction complitWithVCs:vcsToSwithc];
        
        
    }
    

}

-(id<PPJViewModelProt>)viewModelByDirection:(NSInteger)direction andData:(NSArray*)vmData{
    
    return nil;
}
-(id<PPJViewControllerProt>)viewControllerByDirection:(NSInteger)direction andViewModel:(id<PPJViewModelProt>)viewModel{
    
    return nil;
}


@end
