//
//  PPJViewControllerBarHelperProt.h
//  Blok
//
//  Created by Alex Padalko on 12/8/15.
//  Copyright © 2015 com.placepixel. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIColor;
@class UINavigationBar;
@class UIFont;
typedef NS_ENUM(NSInteger,PPJNavigationBarShadowType){
    PPJNavigationBarShadowTypeNone,
   PPJNavigationBarShadowTypeHidden,
    PPJNavigationBarShadowTypeVisible,
    PPJNavigationBarShadowTypeOnlyTop,
    
};

typedef NS_ENUM(NSInteger, SABarItemColor) {
    
    SABarItemColorWhite,
    SABarItemColorBlue
};

typedef NS_ENUM(NSInteger, PPJBarButtonSide) {
    
    PPJBarButtonSideLeft,
    PPJBarButtonSideRight
};
typedef NS_ENUM(NSInteger, PPJBarDefaultButtonType) {
    PPJBarDefaultButtonTypeNone,
    PPJBarDefaultButtonTypeBack,
    PPJBarDefaultButtonTypeClose,
};
static float ppjvc_useDefaultOffset = 0;
struct PPJBarButtonConfig {
    PPJBarDefaultButtonType buttonType;
    float offset;
    
};
typedef struct PPJBarButtonConfig PPJBarButtonConfig;
static inline PPJBarButtonConfig
PPJBarButtonConfigMake (PPJBarDefaultButtonType type , float offset)
{
    PPJBarButtonConfig config;
    config.buttonType = type;
    config.offset=offset;
    return config;
    
}
static inline  PPJBarButtonSide
PPJBarButtonSideFromConfig (PPJBarButtonConfig config)
{
    
    if (config.buttonType==PPJBarDefaultButtonTypeBack) {
        return PPJBarButtonSideLeft;
    }else if (config.buttonType==PPJBarDefaultButtonTypeClose){
        return PPJBarButtonSideLeft;
    }else return PPJBarButtonSideRight;
    
    
}
static inline  PPJBarButtonConfig
PPJBarButtonConfigDefault (PPJBarDefaultButtonType type)
{
    PPJBarButtonConfig config;
    config.buttonType = type;
    config.offset=0;
    return config;
    
}
@protocol PPJViewControllerNavBarConfigurationProt <NSObject>

-(UIColor*)ppjvc_nav_barColor;
-(UIColor*)ppjvc_nav_bottomLineColor;
-(PPJNavigationBarShadowType)ppjvc_nav_preferedShadowType;
-(void)ppjvc_nav_configurateShadowForBar:(UINavigationBar*)bar  withType:(PPJNavigationBarShadowType)shadowType;
-(void)ppjvc_nav_configurateBottomLineForBar:(UINavigationBar *)bar withLineColor:(UIColor*)lineColor;
-(BOOL)ppjvc_nav_autoSetupNavBarItems;


-(BOOL)ppjvc_nav_alwaysUsePreferedButtonType;// NO is defaults
-(PPJBarDefaultButtonType)ppjvc_nav_preferedLeftButtonType;


-(UIColor*)ppjvc_nav_navigationBarColor;

-(UIColor*)ppjvc_nav_backButtonColor;
-(NSString*)ppjvc_nav_backButtonImageName;

-(UIColor*)ppjvc_nav_closeButtonColor;
-(NSString*)ppjvc_nav_closeButtonImageName;


-(UIFont*)ppjvc_nav_titleFont;
-(UIColor*)ppjvc_nav_titleColor;


-(float)ppjvc_nav_leftButtonOffset;
-(float)ppjvc_nav_rightButtonOffset;


@end
