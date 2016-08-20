//
//  PPGMWelcomeScreenViewModel.m
//  Gabbermap
//
//  Created by Alex Padalko on 2/17/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGMWelcomeScreenViewModel.h"
//#import "PPDeepLinkMasterProt.h"

//@interface PPGMWelcomeScreenViewModel ()<PPDeepLinkObserverProt>
//
//@property (nonatomic,retain)id<PPDeepLinkMasterProt>deepLinkMaster;
//
//@end
@implementation PPGMWelcomeScreenViewModel
//-(instancetype)initWithAuthMaster:(id<PPAuthMasterProt>)authMaster currentUserMaster:(id<PPCurrentUserMasterProt>)currentUserMaster andDeepLinkMasterProt:(id<PPDeepLinkMasterProt>)deepLinkMaster animatedAppereance:(BOOL)animatedAppeareance{
//
//    if (self=[super initWithAuthMaster:authMaster]) {
//
//
//        self.currentUserMaster=currentUserMaster;
//        self.isAnanymos=[self.currentUserMaster isAnanymos];
//        self.deepLinkMaster=deepLinkMaster;
//        self.shouldShowGridAppereanceAimation=animatedAppeareance;
//    }
//    return self;
//}
-(void)dataDidLoad{
    [super dataDidLoad];
    @weakify(self);
    [RACObserve(self, viewDidAppearSignal) subscribeNext:^(id x) {
        if (x) {
            @strongify(self);
            
//            [self.deepLinkMaster addDeepLinkObserver:self];
     
            
            
        }
    }];
    
    [RACObserve(self, viewDidDissapiarSignal) subscribeNext:^(id x) {
        if (x) {
            @strongify(self);
            
//            [self.deepLinkMaster removeObserver:self];
            
            
            
        }
    }];
}
-(RACCommand *)skipCommand{
    if (!_skipCommand) {
        @weakify(self);
        _skipCommand=[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
           
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
               
                @strongify (self);
                
//
//                [self.authMaster continueAnanymos];
//                self.navigationSignal=[RACSignal signalWithAction:[APNavigationAction deadlock]];
                [subscriber sendCompleted];
                return [RACDisposable disposableWithBlock:^{
                    
                }];
                
            }];
            
        }];
        
    }
    return _skipCommand;
}

-(RACCommand *)signInCommand{
    if (!_signInCommand) {
        @weakify(self);
        _signInCommand=[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
           
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
               
                @strongify(self);
//                self.navigationSignal=[RACSignal signalWithAction:[APNavigationAction actionWithDirection:PPDirectionSignIn fromVM:self andVMData:@[] andSwitchBlock:^(id<APViewControllerProt> switchableVc) {
//                    self.switchViewControllerSignal=[RACSignal signalWithObject:[APSwitchPack packWithVC:switchableVc andSwitchType:APSwitchTypePush]];
//                }]];
                         [subscriber sendCompleted];
                return [RACDisposable disposableWithBlock:^{
                    
                }];
            }];
        }];
        
    }
    return _signInCommand;
}
-(RACCommand *)singUpCommad{
    if (!_singUpCommad) {
        @weakify(self);
        _singUpCommad=[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
//                self.navigationSignal=[RACSignal signalWithAction:[APNavigationAction actionWithDirection:PPDirectionSignUp fromVM:self andVMData:@[] andSwitchBlock:^(id<APViewControllerProt> switchableVc) {
//                    self.switchViewControllerSignal=[RACSignal signalWithObject:[APSwitchPack packWithVC:switchableVc andSwitchType:APSwitchTypePush]];
//
//                }]];
                
                    [subscriber sendCompleted];
                
                return [RACDisposable disposableWithBlock:^{
                    
                }];
            }];
        }];
        
    }
    return _singUpCommad;}


#pragma mark - <PPDeepLinkObserverProt>
//
//
//-(void)dl_didRecivePixelPostDeepLink:(id<PPPixelPostProt>)pixelPost fromCreator:(id<PPUserProt>)creator shouldCleanData:(BOOL*)shouldClean{
//
//
////   self.displayUserObj=[[PPGridCellUserObject alloc] initWithGridPoint:CGPointMake(4, 3) andUser:creator];
//
//
//    *shouldClean=YES;
//         [self.authMaster continueAnanymos];
//    self.navigationSignal=[RACSignal signalWithAction:[APNavigationAction actionWithDirection:PPDirectionRootViewController fromVM:nil andVMData:@[pixelPost] andSwitchBlock:^(id<APViewControllerProt> switchableVc) {
//    }]];
//
//
//
////          self.switchViewControllerSignal=[RACSignal signalWithObject:[APSwitchPack packWithVC:switchableVc andSwitchType:APSwitchTypePush]];
//
//
//}
//-(void)dl_didReciveSwitchAction:(PPGMAction *)action shouldCleanData:(BOOL*)shouldClean{
//    *shouldClean=NO;
//}
@end
