//
//  PPJViewModel.m
//  Blok
//
//  Created by Alex Padalko on 9/27/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "PPJViewModel.h"

@implementation PPJViewModel
@synthesize actionSignal=_actionSignal;
@synthesize navigationSignal=_navigationSignal;
@synthesize switchViewControllerSignal=_switchViewControllerSignal;
@synthesize actions=_actions;

@synthesize viewDidAppearSignal=_viewDidAppearSignal;
@synthesize viewDidDissapiarSignal=_viewDidDissapiarSignal;
@synthesize viewWillAppearSignal=_viewWillAppearSignal;
@synthesize viewWillDissapiarSignal=_viewWillDissapiarSignal;

@synthesize viewDidLoadSignal=_viewDidLoadSignal;


@synthesize presentOptionsList=_presentOptionsList;






#pragma mark - new


-(void)activateActionWithName:(NSString *)name andData:(id)data{

    [self activateAction:[PPJAction actionWithName:name andValue:data]];

}
-(void)activateAction:(PPJAction*)action{

    [self switchToWorkQueue:^{


        NSLog(@"%@", [[self actions] valueForKey:[action name]]);




    }];


}

#pragma mark - old

















-(void)dataDidLoad{
    
}
-(void)sendActionType:(NSInteger)actionType{
    [self didReciveAction:[PPJAction actionWithType:actionType andData:nil]];
}
-(void)sendAction:(PPJAction*)action{
    [self didReciveAction:action];
}

-(void)didAddedSubVM:(id<PPJViewModelProt>)vm{
    if (![vm isEqual:self]) {
        
        @weakify(self);
        [RACObserve(vm, actionSignal) subscribeNext:^(RACSignal * sig) {
            if (sig)    {
                [sig subscribeNext:^(id x) {
                    if (x) {
                        @strongify(self);
                        [self didReciveAction:x];
                    }
                }];
            }
            
        }];

        
    }
}

#warning OVERRIDE THIS WITH CATEGORY TO GLOBAL ACTIONS!
-(PPJActionResponse)didReciveAction:(id<PPJActionProt>)action{
    self.actionSignal=[RACSignal signalWithObject:action];
    
    return PPJActionResponseNone;
}


-(void)dealloc{
    
    
    NSLog(@"DEALLOC: %@",self);
}
@end
