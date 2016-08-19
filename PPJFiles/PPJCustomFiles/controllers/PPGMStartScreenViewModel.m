//
//  PPGMStartScreenViewModel.m
//  Gabbermap
//
//  Created by Alex Padalko on 2/17/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGMStartScreenViewModel.h"

@implementation PPGMStartScreenViewModel
@synthesize continueCommand=_continueCommand;

-(void)dataDidLoad{
    [super dataDidLoad];
    self.internetConnectionAvailable=YES;
//    @weakify(self);
//    [RACObserve(self, viewDidAppearSignal) subscribeNext:^(id x) {
//       
//        if (x) {
//            @strongify(self);
//            [[PPReachabilityManager sharedInstance] addReachabilityObserver:self];
//        }
//    }];
//    
//    [RACObserve(self, viewDidDissapiarSignal) subscribeNext:^(id x) {
//       
//        if (x) {
//              @strongify(self);
//            [[PPReachabilityManager sharedInstance] removeReachabilityObserver:self];
//        }
//        
//    }];
}

//-(void)pprm_statusDidUpdated:(PPReachabilityManager *)manager status:(NetworkStatus)status{
//    
//    if (status==NotReachable){
//        self.internetConnectionAvailable=NO;
//
//       
//    }else{
//        self.internetConnectionAvailable=YES;
//    
//    }
//    
//    
//}

-(void)startLoad{
   
    self.loadingSignal=[RACSignal signalWithObject:@""];
}
-(void)stopLoad:(NSError *)error{
   
    self.stopLoadingSignal=[RACSignal signalWithObject:error];
}
@end
