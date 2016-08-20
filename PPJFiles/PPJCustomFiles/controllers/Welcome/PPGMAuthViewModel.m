//
//  PPGMAuthViewModel.m
//  Gabbermap
//
//  Created by Alex Padalko on 2/17/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGMAuthViewModel.h"
//#import "PPTutorialManager.h"
@implementation PPGMAuthViewModel
//-(instancetype)initWithAuthMaster:(id<PPAuthMasterProt>)authMaster{
//    if (self=[super init]) {
//
//        self.authMaster=authMaster;
//    }
//    return self;
//}
-(void)dataDidLoad{
    [super dataDidLoad];
}
-(RACCommand *)facebookAuthCommand{
    
    if (!_facebookAuthCommand) {
        @weakify(self);
        _facebookAuthCommand=[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                [self startLoad];
//                [self.authMaster authWithFacebookIfPossible:^(id<PPUserProt> user, PPPresetedUserData *presetedData, NSError *error) {
//                    [self stopLoad:error];
//
//
//                    if (user) {
//                               [[PPTutorialManager sharedInstance] trackShowedOnBoarding];
//                        self.navigationSignal=[RACSignal signalWithAction:[APNavigationAction deadlock]];
//                        [subscriber sendCompleted];
//                    }else if (presetedData){
////                        @weakify(self);
//                        self.navigationSignal=[RACSignal signalWithAction:[APNavigationAction actionWithDirection:PPDirectionCreateProfileWithRegistration fromVM:self andVMData:@[presetedData] andSwitchBlock:^(id<APViewControllerProt> switchableVc) {
//
//                            @strongify(self);
//                            self.switchViewControllerSignal=[RACSignal signalWithObject:[APSwitchPack packWithVC:switchableVc andSwitchType:APSwitchTypePush]];
//
//
//                        }]];
//                        [subscriber sendCompleted];
//
//                    }else{
//                        [subscriber sendError:error];
//                    }
//
//
//
//                }];
                return [RACDisposable disposableWithBlock:^{
                    
                }];
            }];
        }];
        
        
    }
    return _facebookAuthCommand;
}
@end
