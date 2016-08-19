//
//  UIViewController+NavigationBarHelper.h
//  Blok
//
//  Created by Alex Padalko on 10/2/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPJViewControllerProt.h"




@interface UIViewController (NavigationBarHelper)



-(void)ppjvc_nav_setupBar;
-(void)ppjvc_nav_setupTitle;

-(UIButton*)ppjvc_nav_setButtonWithConfig:(PPJBarButtonConfig)buttonConfig;

-(UIButton*)ppjvc_nav_setButtonWithConfig:(PPJBarButtonConfig)buttonConfig andImageName:(NSString*)imageName;
-(UIButton*)ppjvc_nav_setButtonWithConfig:(PPJBarButtonConfig)buttonConfig imageName:(NSString*)imageName andColor:(UIColor*)color;
-(UIButton*)ppjvc_nav_setButtonWithConfig:(PPJBarButtonConfig)buttonConfig target:(id)target andSelector:(SEL)selector;

-(UIButton*)ppjvc_nav_setButtonWithConfig:(PPJBarButtonConfig)buttonConfig imageName:(NSString*)imageName target:(id)target andSelector:(SEL)selector;
-(UIButton*)ppjvc_nav_setButtonWithConfig:(PPJBarButtonConfig)buttonConfig color:(UIColor*)color target:(id)target andSelector:(SEL)selector;
-(UIButton*)ppjvc_nav_setButtonWithConfig:(PPJBarButtonConfig)buttonConfig imageName:(NSString*)imageName color:(UIColor*)color target:(id)target andSelector:(SEL)selector;



-(UIButton*)ppjvc_nav_setButton:(UIButton*)button onSide:(PPJBarButtonSide)side;
-(UIButton*)ppjvc_nav_setButton:(UIButton*)button onSide:(PPJBarButtonSide)side withOffset:(float)offset;




/////////////////////////
//-(void)hideBarLine;
//-(void)setBarColor:(UIColor*)color;
//-(void)setBarColor:(UIColor*)color withAlpha:(float)alpha;
//-(void)setShadowColor:(UIColor*)color;
//
//
//-(void)setLeftButtonItemWithOffset:(float)offset andButton:(UIButton *)button;
//-(void)setRightButtonItemWithOffset:(float)offset andButton:(UIButton *)button;
//
//
//-(void)setCloseLeftBarButtonItemWithButton:(UIButton *)button;
//-(void)setCloseRightBarButtonItemWithButton:(UIButton *)button;
//
//-(UIButton*)createRightTextButtonWithText:(NSString*)text color:(UIColor*)color andSelector:(SEL)selector andTarget:(id)targer;
//-(UIButton*)createLetfTextButtonWithText:(NSString*)text color:(UIColor*)color andSelector:(SEL)selector andTarget:(id)targer;
//
//-(UIButton*)setLeftBackButtonItemWithSelector:(SEL)selector andColor:(UIColor*)color;
//-(UIButton*)setLeftCloseButtonItemWithSelector:(SEL)selector andColor:(UIColor*)color;
//
//
//
//-(UILabel*)createDefaultRobotoTitleLabel:(NSString*)text;
//-(UILabel *)createRobotoStaticTitleLableWithText:(NSString*)text andColor:(UIColor*)color;
//-(UILabel *)createRobotoStaticTitleLableWithText:(NSString*)text andColor:(UIColor*)color andFont:(UIFont*)font;
//
//
//-(void)setRobotoTitle:(NSString*)title;







@end
