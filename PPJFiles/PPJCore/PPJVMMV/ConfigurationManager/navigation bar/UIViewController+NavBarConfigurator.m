//
//  UIViewController+NavigationBarHelper.m
//  Blok
//
//  Created by Alex Padalko on 10/2/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "UIViewController+NavBarConfigurator.h"
#import "PPJViewControllerNavBarConfigurationProt.h"
@interface UIViewController (NavigationHelper)<PPJViewControllerNavBarConfigurationProt,PPJViewControllerProt>

@end

@implementation UIViewController  (NavigationBarHelper)


-(void)ppjvc_nav_setupBar{
    if ([self ppjvc_nav_autoSetupNavBarItems]) {
        
        
       
            if (self.navigationController.viewControllers.count>1) {
                self.leftBarButton=   [self ppjvc_nav_setButtonWithConfig:PPJBarButtonConfigDefault(PPJBarDefaultButtonTypeBack)];
            }else if (self.navigationController.presentingViewController){
                self.leftBarButton=    [self ppjvc_nav_setButtonWithConfig:PPJBarButtonConfigDefault(PPJBarDefaultButtonTypeClose)];
            }
        
        
        if (!self.leftBarButton) {
            if (self.ppjvc_nav_preferedLeftButtonType!=PPJBarDefaultButtonTypeNone) {
                self.leftBarButton=   [self ppjvc_nav_setButtonWithConfig:PPJBarButtonConfigDefault([self ppjvc_nav_preferedLeftButtonType])];
            }
        }
       
  
        
        
        [self ppjvc_nav_setupTitle];
    }
    
    

    
}

-(void)ppjvc_nav_setupTitle{
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [self ppjvc_nav_getNavTitleDefaultColor],NSFontAttributeName:[self ppjvc_nav_getNavTitleDefaultFont]}];
}



-(UIButton*)ppjvc_nav_setButtonWithConfig:(PPJBarButtonConfig)buttonConfig{
    
    return [self ppjvc_nav_setButtonWithConfig:buttonConfig andImageName:nil];
}


-(UIButton*)ppjvc_nav_setButtonWithConfig:(PPJBarButtonConfig)buttonConfig andImageName:(NSString*)imageName{
           return [self ppjvc_nav_setButtonWithConfig:buttonConfig imageName:imageName andColor:nil];
}
-(UIButton*)ppjvc_nav_setButtonWithConfig:(PPJBarButtonConfig)buttonConfig imageName:(NSString*)imageName andColor:(UIColor*)color{
        return [self ppjvc_nav_setButtonWithConfig:buttonConfig imageName:imageName color:color target:nil andSelector:nil];
}
-(UIButton*)ppjvc_nav_setButtonWithConfig:(PPJBarButtonConfig)buttonConfig target:(id)target andSelector:(SEL)selector{
        return [self ppjvc_nav_setButtonWithConfig:buttonConfig imageName:nil color:nil target:target andSelector:selector];
}

-(UIButton*)ppjvc_nav_setButtonWithConfig:(PPJBarButtonConfig)buttonConfig imageName:(NSString*)imageName target:(id)target andSelector:(SEL)selector{
              return [self ppjvc_nav_setButtonWithConfig:buttonConfig imageName:imageName color:nil target:target andSelector:selector];
}
-(UIButton*)ppjvc_nav_setButtonWithConfig:(PPJBarButtonConfig)buttonConfig color:(UIColor*)color target:(id)target andSelector:(SEL)selector{
          return [self ppjvc_nav_setButtonWithConfig:buttonConfig imageName:nil color:color target:target andSelector:selector];
}
-(UIButton*)ppjvc_nav_setButtonWithConfig:(PPJBarButtonConfig)buttonConfig imageName:(NSString*)imageName color:(UIColor*)color target:(id)target andSelector:(SEL)selector{
    
    UIButton * but = [self ppjvc_nav_createButton:buttonConfig imageName:imageName color:color target:target andSelector:selector];
    
    
    return [self ppjvc_nav_setButton:but onSide:PPJBarButtonSideFromConfig(buttonConfig) withOffset:buttonConfig.offset];
    
}



-(UIButton*)ppjvc_nav_setButton:(UIButton*)button onSide:(PPJBarButtonSide)side{
        return [self ppjvc_nav_setButton:button onSide:side withOffset:ppjvc_useDefaultOffset];
}
-(UIButton*)ppjvc_nav_setButton:(UIButton*)button onSide:(PPJBarButtonSide)side withOffset:(float)offset{
    
  
    float realOffset;
    
    if ([UIScreen mainScreen].bounds.size.width==320) {
      realOffset=   offset+(-16);
    }else if ([UIScreen mainScreen].bounds.size.width==375){
         realOffset=   offset+(-16);
    }else{
         realOffset=   offset+(-20);
    }
//    if (realOffset==ppjvc_useDefaultOffset) {
//        realOffset = [self ppjvc_nav_getButtonOffsetOnViewControllerOnSide:side];
//    }
    
    if (button.titleLabel.text.length==0) {
        if (CGSizeEqualToSize(button.frame.size, CGSizeZero)) {
                  [button setFrame:CGRectMake(0, 0, 44, 44)];
        }
  
        if (!button.imageView.image) {
           
        }
    }else{
             if (CGSizeEqualToSize(button.frame.size, CGSizeZero)) {
        [button setFrame:CGRectMake(0, 0, 200, 44)];
        [button sizeToFit];
        [button setFrame:CGRectMake(0, 0, button.frame.size.width+12, 44)];
             }
    }
    
    
    
    UIBarButtonItem * butItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    negativeSpacer.width = realOffset;
    
//    [button setBackgroundColor:[UIColor redColor]];
    // it was -6 in iOS 6
    if (side==PPJBarButtonSideLeft) {
        [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, butItem/*this will be the button which u actually need*/, nil] animated:NO];
        
    }else{
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, butItem/*this will be the button which u actually need*/, nil] animated:NO];
        
    }
    
    return button;
}








#pragma mark - getters

-(UIButton*)ppjvc_nav_createButton:(PPJBarButtonConfig)buttonConfig imageName:(NSString*)imageName color:(UIColor*)color target:(id)target andSelector:(SEL)selector {
    PPJBarDefaultButtonType buttonType= buttonConfig.buttonType;
    float offset = buttonConfig.offset;
    if (offset==ppjvc_useDefaultOffset) {
        offset=[self ppjvc_nav_getButtonOffsetOnViewControllerOnSide:PPJBarButtonSideFromConfig(buttonConfig)];
    }
    NSString * rImageName=imageName;
    if (!rImageName) {
        rImageName=[self ppjvc_nav_getButtonDefaultImageName:buttonType];
    }
    UIColor * rColor=color;
    if (!rColor) {
        rColor=[self ppjvc_nav_getButtonDefaultColor:buttonType];
    }
    
    id rTarget=target;
    SEL rSelector;
    if (!target||!selector) {
        
        if (buttonType==PPJBarDefaultButtonTypeBack) {
            rTarget=self;
            rSelector=@selector(ppjvc_backAction);
        }else if (buttonType==PPJBarDefaultButtonTypeClose) {
            rTarget=self;
            rSelector=@selector(ppjvc_closeAction);
        }else{
            rTarget=nil;
            rSelector=nil;
        }
    }
    
    UIButton * but =[UIButton buttonWithType:UIButtonTypeCustom];
    [but setTitleColor:rColor forState:UIControlStateNormal];
    [but setTintColor:rColor];
    [but setImage:[[UIImage imageNamed:rImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    if (rSelector&&rTarget) {
        [but addTarget:rTarget action:rSelector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return but;
    
}
-(NSString*)ppjvc_nav_getButtonDefaultImageName:(PPJBarDefaultButtonType)buttonType{
    if (buttonType==PPJBarDefaultButtonTypeBack) {
        return [self ppjvc_nav_backButtonImageName];
    }else if (buttonType==PPJBarDefaultButtonTypeClose){
        return  [self ppjvc_nav_closeButtonImageName];
    }else return nil;
}
-(UIColor*)ppjvc_nav_getButtonDefaultColor:(PPJBarDefaultButtonType)buttonType{
    if (buttonType==PPJBarDefaultButtonTypeBack) {
        
        return [self ppjvc_nav_backButtonColor];
        
        
    }else if (buttonType==PPJBarDefaultButtonTypeClose){
        return [self ppjvc_nav_closeButtonColor];
    }else return [UIColor blackColor];
}
-(float)ppjvc_nav_getButtonOffsetOnViewControllerOnSide:(PPJBarButtonSide)side{
    if (side==PPJBarButtonSideLeft) {
        
       return [self ppjvc_nav_leftButtonOffset];
        
    }else{
        return [self ppjvc_nav_rightButtonOffset];
    }
    
}


-(UIFont*)ppjvc_nav_getNavTitleDefaultFont{
    
    return [self ppjvc_nav_titleFont];
    
}
-(UIColor*)ppjvc_nav_getNavTitleDefaultColor{
    
     return [self ppjvc_nav_titleColor];
}




@end
