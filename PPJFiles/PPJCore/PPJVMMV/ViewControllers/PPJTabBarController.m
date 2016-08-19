//
//  PPJTabBarController.m
//  Blok
//
//  Created by Alex Padalko on 9/27/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "PPJTabBarController.h"
#import "RACSignal+Object.h"

@implementation PPJTabBarController
@synthesize viewModel=_viewModel;
@synthesize ppjvc_configurator=_ppjvc_configurator;
@synthesize leftBarButton=_leftBarButton;
@synthesize controllerRefirence=_controllerRefirence;
-(instancetype)initWithViewModel:(id<PPJViewModelProt>)viewModel{
    
    
    if (self=[super init]) {
        self.viewModel=viewModel;
        [self viewModelDidBind];
    }
    return self;
    
}
-(void)viewModelDidBind{
    self.viewModel.viewDidLoadSignal=[RACSignal signalWithObject:@"viewDidLoad"];
}
-(PPJSwitchType)allowingSwitchTypes{
    return PPJSwitchTypePush|PPJSwitchTypePresent;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.viewModel.viewWillAppearSignal=[RACSignal signalWithObject:@"viewWillAppearSignal"];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.viewModel.viewWillDissapiarSignal=[RACSignal signalWithObject:@"viewWillDissaper"];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.viewModel.viewDidDissapiarSignal=[RACSignal signalWithObject:@"viewDidDissapiarSignal"];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.viewModel.viewDidAppearSignal=[RACSignal signalWithObject:@"viewDidAppearSignal"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    @weakify(self);
    [RACObserve(self.viewModel, switchViewControllerSignal) subscribeNext:^(RACSignal * sig) {
        
        if (sig) {
            [sig subscribeNext:^(PPJSwitchPack * switchPack) {
                @strongify(self);
                
                [self ppjvc_didReciveSwitchPack:switchPack];
                
            }];
        }
        
        
    }];
    
    // Do any additional setup after loading the view.
}

-(void)ppjvc_didReciveSwitchPack:(PPJSwitchPack *)switchPack{
    

#warning TODO TABBAR UPDATE
//    if(switchPack.switchType==PPJSwitchTypePresent){
//        
//        if ([switchPack.vc allowingSwitchTypes]>=PPJSwitchTypePresent) {
//            
//            if ([switchPack.vc shouldCreateWithNavigation]) {
//                [self presentViewController:[[[switchPack.vc ppjvc_navigationControllerClass] alloc] initWithRootViewController:(UIViewController*)switchPack.vc] animated:YES completion:nil];
//            }else{
//                [self presentViewController:(UIViewController*)switchPack.vc animated:YES completion:nil];
//            }
//            
//            
//            
//        }
//        
//        
//    }else
    
        
    if (switchPack.switchType==PPJSwitchTypePush&&self.navigationController) {
        [self.navigationController pushViewController:(UIViewController*)switchPack.vc animated:YES];
    }else if (switchPack.switchType==PPJSwitchTypePush&&!self.navigationController) {
        [self presentViewController:[[[[switchPack.vc ppjvc_configurator] ppjvc_navigationControllerClass] alloc] initWithRootViewController:(UIViewController*)switchPack.vc] animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    
    
    NSLog(@"DEALLOC: %@",self);
}

@end
