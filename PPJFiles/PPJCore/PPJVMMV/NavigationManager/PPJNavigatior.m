//
//  PPJNavigatior.m
//  Blok
//
//  Created by Alex Padalko on 9/27/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "PPJNavigatior.h"
#import "PPJViewModel.h"
#import "PPJScreenFabric.h"

#import "PPJApp.h"
@implementation PPJNavigatior

-(instancetype)initWithWindow:(UIWindow *)window{
    
    if (self=[super init]) {
        
        self.window=window;
    }
    return self;
}

-(void)loadNavigation{

    NSString * route = nil;
    if (self.pathFunction){
       route = [self.pathFunction callFunction:self];
    }
    if(!route){
        route = [[self.routes allKeys] firstObject];
    }
    if (!route){
        route = kPPJRoutePlayground;
    }

    [self didReciveNavigationAction: [PPJNavigationAction actionWithRoute:route fromVM:nil andVMData:nil andSwitchBlock:^(id <PPJViewControllerProt> switchableVc) {
        self.window.rootViewController=switchableVc;
    } ]];

    
}
-(void)didReciveNavigationAction:(PPJNavigationAction *)navigationAction{
    if (navigationAction.requestType==PPJNavigationRequestTypeDefault) {
        if (navigationAction.route == kPPJRouteDeadlock) {
            [self loadNavigation];
            return;
        }

            NSString *vcClassName = [self.routes valueForKey:navigationAction.route];
        PPJViewModel *newViewModel =
                [[self.ppjApp screenFabric] viewModelFromVCClassName:vcClassName data:navigationAction.vmData];
        NSLog(@"%@", newViewModel);


        @weakify(self);
        [RACObserve(newViewModel, navigationSignal) subscribeNext:^(RACSignal *sig) {

            if (sig) {
                [sig subscribeNext:^(id x) {

                    if (x) {
                        @strongify(self);
                        [self didReciveNavigationAction:x];
                    }

                }];
            }

        }];

        PPJViewController *vc =
                [[self.ppjApp screenFabric] viewControllerFromVCClassName:vcClassName andVM:newViewModel];

        [navigationAction.fromVM didAddedSubVM:newViewModel];

        [navigationAction complitWithVc:vc];
    } else if (navigationAction.requestType==PPJNavigationRequestTypeCollection) {
        NSMutableArray<PPJViewControllerProt> * vcsToSwithc=[[NSMutableArray<PPJViewControllerProt> alloc] init];
        for (NSString * route in navigationAction.routes) {
            NSString *vcClassName = [self.routes valueForKey:navigationAction.route];
            PPJViewModel *newViewModel =
                    [[self.ppjApp screenFabric] viewModelFromVCClassName:vcClassName data:navigationAction.vmData];

            @weakify(self);
            [RACObserve(newViewModel, navigationSignal) subscribeNext:^(RACSignal * sig) {

                if (sig) {
                    [sig subscribeNext:^(id x) {

                        if (x) {
                            @strongify(self);
                            [self didReciveNavigationAction:x];
                        }

                    }];
                }

            }];
            PPJViewController *vc =
                    [[self.ppjApp screenFabric] viewControllerFromVCClassName:vcClassName andVM:newViewModel];
            [vcsToSwithc addObject:vc];
            [navigationAction.fromVM didAddedSubVM:newViewModel];
        }
        [navigationAction complitWithVCs:vcsToSwithc];
    }

//
//
//
//
//        id <PPJViewModelProt> vm;
//
//
//        if (navigationAction.viewModel) {
//            vm=navigationAction.viewModel;
//        }else{
//            vm = [self viewModelByDirection: navigationAction.direction
//                                    andData:navigationAction.vmData];
//            @weakify(self);
//            [RACObserve(vm, navigationSignal) subscribeNext:^(RACSignal * sig) {
//
//                if (sig) {
//                    [sig subscribeNext:^(id x) {
//
//                        if (x) {
//                            @strongify(self);
//                            [self didReciveNavigationAction:x];
//                        }
//
//                    }];
//                }
//
//            }];
//
//        }
//        id <PPJViewControllerProt> vc = [self viewControllerByDirection:navigationAction.direction andViewModel:vm];
//        [navigationAction.fromVM didAddedSubVM:vm];
//
//        [navigationAction complitWithVc:vc];
//    }else if (navigationAction.requestType==SANavigationRequestTypeCollection) {
//
//        NSMutableArray<PPJViewControllerProt> * vcsToSwithc=[[NSMutableArray<PPJViewControllerProt> alloc] init];
//        for (NSNumber * direction in navigationAction.directions) {
//            id <PPJViewModelProt> vm;
//                 vm = [self viewModelByDirection:[direction integerValue] andData:navigationAction.vmData];
//            @weakify(self);
//            [RACObserve(vm, navigationSignal) subscribeNext:^(RACSignal * sig) {
//
//                if (sig) {
//                    [sig subscribeNext:^(id x) {
//
//                        if (x) {
//                            @strongify(self);
//                            [self didReciveNavigationAction:x];
//                        }
//
//                    }];
//                }
//
//            }];
//
//            [vcsToSwithc addObject:[self viewControllerByDirection:[direction integerValue] andViewModel:vm]];
//            [navigationAction.fromVM didAddedSubVM:vm];
//        }
//        [navigationAction complitWithVCs:vcsToSwithc];
//
//
//    }
    

}

-(id<PPJViewModelProt>)viewModelByDirection:(NSInteger)direction andData:(NSArray*)vmData{
    
    return nil;
}
-(id<PPJViewControllerProt>)viewControllerByDirection:(NSInteger)direction andViewModel:(id<PPJViewModelProt>)viewModel{
    
    return nil;
}


@end
