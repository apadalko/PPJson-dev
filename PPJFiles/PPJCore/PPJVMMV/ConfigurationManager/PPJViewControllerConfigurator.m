//
//  PPJViewControllerDefaultConfigurator.m
//  Gabbermap
//
//  Created by Alex Padalko on 3/16/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPJViewControllerConfigurator.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "PPJSwitchPack.h"
@implementation PPJViewControllerConfigurator
@synthesize controllerRefirence;
#pragma mark - PPJViewControllerMainConfigurationProt

-(void)ppjvc_additionalViewControllerViewDidLoadSetup{
    
}
-(BOOL)ppjvc_shouldCreateWithNavigation{
    return YES;
}
-(UIColor*)ppjvc_defaultBackgroundColor{
    return [UIColor purpleColor];
}
-(BOOL)ppjvc_swipeBackEnabled{
    return YES;
}
-(NSArray*)ppjvc_allowingSwitchTypes{
    
    return @[@(PPJSwitchTypePush),@(PPJSwitchTypePresent)];
}
-(BOOL)ppjvc_nav_alwaysUsePreferedButtonType{
    return NO;
}

-(Class)ppjvc_navigationControllerClass{
    return [UINavigationController class];
}

#pragma mark - PPJViewControllerNavBarConfigurationProt
-(PPJNavigationBarShadowType)ppjvc_nav_preferedShadowType{
    return PPJNavigationBarShadowTypeNone;
}

///
- (CAShapeLayer *)__apvc_lineLayerforbar:(UINavigationBar*)bar {
    
    if (!bar) {
        return nil;
    }
    
    CAShapeLayer *result = objc_getAssociatedObject(bar, @"__apvc_lineLayer");
   
    return result;
}
-(void)ppjvc_nav_configurateBottomLineForBar:(UINavigationBar *)bar withLineColor:(UIColor*)lineColor{
    if (!bar) {
        return;
    }
    if (lineColor) {
        
        if (![self __apvc_lineLayerforbar:bar]) {
          CAShapeLayer *  result =   [CAShapeLayer layer];;
            objc_setAssociatedObject(bar, @"__apvc_lineLayer", result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            [bar.layer addSublayer:result];
        }
        CAShapeLayer * lineLayer = [self __apvc_lineLayerforbar:bar];
        CGMutablePathRef p = CGPathCreateMutable();
        
        CGPathMoveToPoint(p, nil, 0, bar.frame.size.height-.25);
        CGPathAddLineToPoint(p, nil, bar.frame.size.width, bar.frame.size.height-.25);
        [lineLayer setLineWidth:.5];
        [lineLayer setStrokeColor:lineColor.CGColor];
        
        
        
        [lineLayer setPath:p];
   
        
        CGPathRelease(p);
    }

    
}

-(void)ppjvc_nav_configurateShadowForBar:(UINavigationBar*)bar  withType:(PPJNavigationBarShadowType)shadowType{

    //    [bar setBarTintColor:[UIColor ppCyanColor]];
    //    [bar setTitleTextAttributes:@{
    //                                   NSFontAttributeName: [UIFont ppTitleFont],
    //                                   NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    //    [bar setShadowImage:[self onePixelImageWithColor:[UIColor redColor]]];
    if (shadowType==PPJNavigationBarShadowTypeHidden||shadowType==PPJNavigationBarShadowTypeNone) {
        bar.layer.masksToBounds = NO;
        bar.layer.shadowOffset = CGSizeMake(0, 0);
        bar.layer.shadowRadius = 0;
        bar.layer.shadowOpacity = 0.0;
        bar.layer.shadowColor=[UIColor blackColor].CGColor;
        bar.layer.shadowPath=nil;
        bar.translucent=NO;
        [bar setClipsToBounds:NO];
        [bar.layer setMasksToBounds:NO];
        bar.barStyle = UIBarStyleBlackOpaque;
    }else{
        bar.translucent=NO;
        [bar setClipsToBounds:NO];
        [bar.layer setMasksToBounds:NO];
        bar.barStyle = UIBarStyleBlackOpaque;
        
        if (shadowType==PPJNavigationBarShadowTypeVisible){
            bar.layer.masksToBounds = NO;
            bar.layer.shadowOffset = CGSizeMake(0, 0);
            bar.layer.shadowRadius = 2;
            bar.layer.shadowOpacity = 0.6;
            bar.layer.shadowColor=[UIColor blackColor].CGColor;
            
            
            CGMutablePathRef p =   CGPathCreateMutable();
            CGPathAddRect(p, nil, CGRectMake(0, 0, bar.frame.size.width, 1));
            CGPathAddRect(p, nil, CGRectMake(0, bar.frame.size.height, bar.frame.size.width, 2));
            bar.layer.shadowPath=p;
            CGPathRelease(p);
            
//            [bar.layer setShouldRasterize:YES];
            
        }else if (shadowType==PPJNavigationBarShadowTypeOnlyTop){
            
         
            bar.layer.shadowColor=[UIColor blackColor].CGColor;
            bar.layer.masksToBounds = NO;
//            bar.layer.shadowOffset = CGSizeMake(0,0);
//            bar.layer.shadowRadius = 2;
//            bar.layer.shadowOpacity = 0.6;
            
            bar.layer.shadowOffset = CGSizeMake(0, 1);
            bar.layer.shadowRadius = 2;
            bar.layer.shadowOpacity = 0.5;
            
            
            CGMutablePathRef p =   CGPathCreateMutable();
            CGPathAddRect(p, nil, CGRectMake(0, 0, bar.frame.size.width, 1));
            bar.layer.shadowPath=p;
            CGPathRelease(p);
            
//            [bar.layer setShouldRasterize:YES];
        }
        
    }
    
}

-(UIColor*)ppjvc_nav_barColor{
    return [UIColor yellowColor];
}
-(BOOL)ppjvc_nav_autoSetupNavBarItems{
    return YES;
}
-(UIColor*)ppjvc_nav_bottomLineColor{
    return [UIColor clearColor];
}
-(PPJBarDefaultButtonType)ppjvc_nav_preferedLeftButtonType{
    
    return PPJBarDefaultButtonTypeNone;
    
}
-(UIColor*)ppjvc_nav_navigationBarColor{
    return [UIColor redColor];
}

-(UIColor*)ppjvc_nav_backButtonColor{
    return [UIColor orangeColor];
}
-(NSString*)ppjvc_nav_backButtonImageName{
    return nil;
}

-(UIColor*)ppjvc_nav_closeButtonColor{
    return [UIColor purpleColor];
}
-(NSString*)ppjvc_nav_closeButtonImageName{
    return nil;
}

-(UIFont*)ppjvc_nav_titleFont{
    return [UIFont boldSystemFontOfSize:22];
}
-(UIColor*)ppjvc_nav_titleColor{
    return [UIColor greenColor];
}


-(float)ppjvc_nav_leftButtonOffset{
    return 0;
}
-(float)ppjvc_nav_rightButtonOffset{
    return 0;
}

@end
