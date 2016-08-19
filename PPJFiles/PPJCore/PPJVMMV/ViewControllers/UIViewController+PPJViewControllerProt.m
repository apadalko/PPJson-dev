//
//  UIViewController+PPJViewControllerProt.m
//  Gabbermap
//
//  Created by Alex Padalko on 3/17/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "UIViewController+PPJViewControllerProt.h"
#import "PPJViewControllerConfiguratorProt.h"
#import "PPJViewControllerConfigurationsManager.h"
#import "RACSignal+Object.h"
#import "UIViewController+NavBarConfigurator.h"

#import <objc/runtime.h>
@implementation UIViewController (PPJViewControllerProt)
@dynamic ppjvc_configurator;
@dynamic viewModel;
@dynamic leftBarButton;
@dynamic controllerRefirence;

+(instancetype)createWithViewModel:(id<PPJViewModelProt>)viewModel{
    

    UIViewController <PPJViewControllerProt>* vc = [[[self class] alloc] init];
//    [vc setApvc_configurator:[]
    [vc setViewModel:viewModel];
    [vc viewModelDidBind];
    [vc __apvc_mainSetup];
    return vc;
    
}

-(void)__apvc_mainSetup{
    
    [self __signalsSetup];
    
}
-(void)__viewDidLoadSetup{
    @weakify(self);
    [RACObserve(self.viewModel, switchViewControllerSignal) subscribeNext:^(RACSignal * sig) {
        
        if (sig) {
            [sig subscribeNext:^(PPJSwitchPack * switchPack) {
                @strongify(self);
                
                [self ppjvc_didReciveSwitchPack:switchPack];
                
            }];
        }
        
        
    }];
    [RACObserve(self.viewModel, presentOptionsList) subscribeNext:^(RACSignal  *sig) {
        
        if (sig) {
            
            
            [sig subscribeNext:^(id x) {
                
                if (x) {
                    @strongify(self);
//                    self.optionList=x;
                   [self ppjvc_didReciveOptionList:x];
                }
                
            }];
            
        }
        
    }];
    [self.view setBackgroundColor:[self ppjvc_defaultBackgroundColor]];
    [self ppjvc_nav_setupBar];
    [self ppjvc_additionalViewControllerViewDidLoadSetup];
}
#pragma mark - realization help
-(void)ppjvc_backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ppjvc_closeAction{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}
-(void)viewModelDidBind{
 
    NSLog(@"ROOOOOT");
}
-(void)ppjvc_didReciveSwitchPack:(PPJSwitchPack *)switchPack{
    if (switchPack.switchType==PPJSwitchTypePush) {
        
        
        [self.navigationController pushViewController:(UIViewController*)switchPack.vc animated:switchPack.animated];
        
    }else if (switchPack.switchType==PPJSwitchTypePush&&!self.navigationController) {
        
        [self presentViewController:[[[[switchPack.vc ppjvc_configurator] ppjvc_navigationControllerClass] alloc] initWithRootViewController:(UIViewController*)switchPack.vc] animated:switchPack.animated completion:nil];
        
    }else if (switchPack.switchType==PPJSwitchTypePresent){
        
        if ([switchPack.vc ppjvc_shouldCreateWithNavigation]) {
            
            [self presentViewController:[[[switchPack.vc ppjvc_navigationControllerClass] alloc] initWithRootViewController:switchPack.vc] animated:switchPack.animated completion:^{
                
            }];
        }else{
            [self presentViewController:switchPack.vc animated:switchPack.animated completion:^{
                
            }];
        }
        
    
    }
    
}
#pragma mark  option list

-(void)ppjvc_didReciveOptionList:(PPJOptionsListObject *)optionList{
    
    [[[PPJViewControllerConfigurationsManager sharedInstance] optionListHanderForViewController:self] ppjvc_didReciveOptionList:optionList onViewController:self];
    
}

#pragma mark - prop
- (void)setApvc_configurator:(id<PPJViewControllerConfiguratorProt> )ppjvc_configurator{
    objc_setAssociatedObject(self, @selector(ppjvc_configurator), ppjvc_configurator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<PPJViewControllerConfiguratorProt> )ppjvc_configurator{
    id p= objc_getAssociatedObject(self, @selector(ppjvc_configurator));
    
    if (!p) {
        p=[[PPJViewControllerConfigurationsManager sharedInstance] configratorForViewController:self];
        [p setControllerRefirence:self];
        objc_setAssociatedObject(self, @selector(ppjvc_configurator), p, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    
    return p;
}
- (void)setViewModel:(id<PPJViewModelProt>)viewModel{
    objc_setAssociatedObject(self, @selector(viewModel), viewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<PPJViewModelProt> )viewModel{
    id p= objc_getAssociatedObject(self, @selector(viewModel));
    return p;
}
- (void)setLeftBarButton:(UIButton *)leftBarButton{
    objc_setAssociatedObject(self, @selector(leftBarButton), leftBarButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)leftBarButton{
    id p= objc_getAssociatedObject(self, @selector(leftBarButton));
    return p;
}
#pragma mark - overrides

#pragma mark -  <PPJViewControllerMainConfigurationProt>

-(void)ppjvc_additionalViewControllerViewDidLoadSetup{
    return [self.ppjvc_configurator ppjvc_additionalViewControllerViewDidLoadSetup];
}

-(UIColor *)ppjvc_defaultBackgroundColor{
    return [self.ppjvc_configurator ppjvc_defaultBackgroundColor];
}

-(BOOL)ppjvc_swipeBackEnabled{
    return [self.ppjvc_configurator ppjvc_swipeBackEnabled];
}

-(NSArray*)ppjvc_allowingSwitchTypes{
    return [self.ppjvc_configurator ppjvc_allowingSwitchTypes];
}
-(BOOL)ppjvc_shouldCreateWithNavigation{
        return [self.ppjvc_configurator ppjvc_shouldCreateWithNavigation];
}
-(Class)ppjvc_navigationControllerClass{
    return [self.ppjvc_configurator ppjvc_navigationControllerClass];
}


#pragma mark - <PPJViewControllerNavBarConfigurationProt>

-(void)ppjvc_nav_configurateBottomLineForBar:(UINavigationBar *)bar withLineColor:(UIColor*)lineColor{
    return [self.ppjvc_configurator ppjvc_nav_configurateBottomLineForBar:bar withLineColor:lineColor];
}
-(void)ppjvc_nav_configurateShadowForBar:(UINavigationBar *)bar withType:(PPJNavigationBarShadowType)shadowType{
    return [self.ppjvc_configurator ppjvc_nav_configurateShadowForBar:bar withType:shadowType];
}
-(UIColor*)ppjvc_nav_bottomLineColor{
        return [self.ppjvc_configurator ppjvc_nav_bottomLineColor];
}
-(PPJNavigationBarShadowType)ppjvc_nav_preferedShadowType{
    return [self.ppjvc_configurator ppjvc_nav_preferedShadowType];
}
-(UIColor*)ppjvc_nav_barColor{
    return [self.ppjvc_configurator ppjvc_nav_barColor];
}
-(BOOL)ppjvc_nav_autoSetupNavBarItems{
    return [self.ppjvc_configurator ppjvc_nav_autoSetupNavBarItems];
}
-(BOOL)ppjvc_nav_alwaysUsePreferedButtonType{
    return [self.ppjvc_configurator ppjvc_nav_alwaysUsePreferedButtonType];
}
-(PPJBarDefaultButtonType)ppjvc_nav_preferedLeftButtonType{
    
    return [self.ppjvc_configurator ppjvc_nav_preferedLeftButtonType];
}
-(UIColor*)ppjvc_nav_navigationBarColor{
    return   [self.ppjvc_configurator ppjvc_nav_navigationBarColor];
}

-(UIColor*)ppjvc_nav_backButtonColor{
    return  [self.ppjvc_configurator ppjvc_nav_backButtonColor];
}
-(NSString*)ppjvc_nav_backButtonImageName{
    return   [self.ppjvc_configurator ppjvc_nav_backButtonImageName];
}

-(UIColor*)ppjvc_nav_closeButtonColor{
    return   [self.ppjvc_configurator ppjvc_nav_closeButtonColor];
}
-(NSString*)ppjvc_nav_closeButtonImageName{
    return  [self.ppjvc_configurator ppjvc_nav_closeButtonImageName];
}


-(UIFont*)ppjvc_nav_titleFont{
    return   [self.ppjvc_configurator ppjvc_nav_titleFont];
}
-(UIColor*)ppjvc_nav_titleColor{
    return    [self.ppjvc_configurator ppjvc_nav_titleColor];
}


-(float)ppjvc_nav_leftButtonOffset{
    return   [self.ppjvc_configurator ppjvc_nav_leftButtonOffset];
}
-(float)ppjvc_nav_rightButtonOffset{
    return   [self.ppjvc_configurator ppjvc_nav_rightButtonOffset];
}
#pragma mark - signals setup

-(void)__signalsSetup{
    @weakify(self);
    [[[self rac_signalForSelector:@selector(viewDidLoad) ]
      takeUntilBlock:^BOOL(id x) {
          @strongify(self);
          if (self) {
              return NO;
          }else{
              return YES;
          }
      } ]
     
     subscribeNext:^(   id x) {
         @strongify(self);
         
         if (x) {
             self.viewModel.viewDidLoadSignal=[RACSignal signalWithObject:@"viewDidLoad"];
             [self __viewDidLoadSetup];
         }
         
     }];
    [[[self rac_signalForSelector:@selector(viewWillAppear:) ]
      takeUntilBlock:^BOOL(id x) {
          @strongify(self);
          if (self) {
              return NO;
          }else{
              return YES;
          }
      } ]
     
     subscribeNext:^(   id x) {
         @strongify(self);
         
         if (x) {
             
                 [self.navigationController.navigationBar setBarTintColor:[self ppjvc_nav_barColor]];
             [self ppjvc_nav_configurateShadowForBar:self.navigationController.navigationBar withType:[self ppjvc_nav_preferedShadowType]];
             [self ppjvc_nav_configurateBottomLineForBar:self.navigationController.navigationBar withLineColor:[self ppjvc_nav_bottomLineColor]];
             self.viewModel.viewWillAppearSignal=[RACSignal signalWithObject:@"viewWillAppear"];
         }
         
     }];
    [[[self rac_signalForSelector:@selector(viewDidAppear:) ]
      takeUntilBlock:^BOOL(id x) {
          @strongify(self);
          if (self) {
              return NO;
          }else{
              return YES;
          }
      } ]
     
     subscribeNext:^(   id x) {
         @strongify(self);
         
         if (x) {
             
             self.viewModel.viewDidAppearSignal=[RACSignal signalWithObject:@"viewDidAppear"];
             
             if ([self ppjvc_swipeBackEnabled]) {
                 self.navigationController.interactivePopGestureRecognizer.enabled = YES;
                 id <UIGestureRecognizerDelegate> d = (id <UIGestureRecognizerDelegate>)self;
                 self.navigationController.interactivePopGestureRecognizer.delegate = d;
             }else{
                 self.navigationController.interactivePopGestureRecognizer.enabled = NO;
                 self.navigationController.interactivePopGestureRecognizer.delegate = nil;
             }
         }
         
     }];
    [[[self rac_signalForSelector:@selector(viewWillDisappear:) ]
      takeUntilBlock:^BOOL(id x) {
          @strongify(self);
          if (self) {
              return NO;
          }else{
              return YES;
          }
      } ]
     
     subscribeNext:^(   id x) {
         @strongify(self);
         
         if (x) {
             self.viewModel.viewWillDissapiarSignal=[RACSignal signalWithObject:@"viewWillDisappear"];
         }
         
     }];
    [[[self rac_signalForSelector:@selector(viewDidDisappear:) ]
      takeUntilBlock:^BOOL(id x) {
          @strongify(self);
          if (self) {
              return NO;
          }else{
              return YES;
          }
      } ]
     
     subscribeNext:^(   id x) {
         @strongify(self);
         
         if (x) {
             self.viewModel.viewDidDissapiarSignal=[RACSignal signalWithObject:@"viewDidDisappear"];
         }
         
     }];
}
@end
