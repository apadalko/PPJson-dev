//
//  PPJViewController.m
//  Blok
//
//  Created by Alex Padalko on 9/27/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "PPJViewController.h"
#import "RACSignal+Object.h"
#import "PPJViewControllerConfigurationsManager.h"

@interface PPJViewController ()<UIGestureRecognizerDelegate>

@end
@implementation PPJViewController
@synthesize viewModel=_viewModel;
@synthesize ppjvc_configurator=_apvc_configurator;
@synthesize controllerRefirence=_controllerRefirence;
@synthesize leftBarButton=_leftBarButton;

-(instancetype)initWithViewModel:(id<PPJViewModelProt>)viewModel{
    
    if (self=[super init]) {
        self.viewModel=viewModel;
        [self viewModelDidBind];
    }
    return self;
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
}
-(void)viewModelDidBind{
    [super viewModelDidBind];
 
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    // Do any additional setup after loading the view.
}
-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    
    if (self.navigationController) {
        [self.navigationController presentViewController:viewControllerToPresent animated:flag completion:completion];
    }else if (self.tabBarController){
        [self.tabBarController presentViewController:viewControllerToPresent animated:flag completion:completion];
    }else{
               [super presentViewController:viewControllerToPresent animated:flag completion:completion];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(void)dealloc{
    
    
    NSLog(@"DEALLOC: %@",self);
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based ppjplication, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */




@end
