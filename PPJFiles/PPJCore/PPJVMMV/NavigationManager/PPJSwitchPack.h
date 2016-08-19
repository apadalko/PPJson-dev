//
//  PPJSwitchPack.h
//  Blok
//
//  Created by Alex Padalko on 9/24/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//
//UIInterfaceOrientationMaskPortrait = (1 << UIInterfaceOrientationPortrait),
//UIInterfaceOrientationMaskLandscapeLeft = (1 << UIInterfaceOrientationLandscapeLeft),
//UIInterfaceOrientationMaskLandscapeRight = (1 << UIInterfaceOrientationLandscapeRight),
//UIInterfaceOrientationMaskPortraitUpsideDown = (1 << UIInterfaceOrientationPortraitUpsideDown),
//UIInterfaceOrientationMaskLandscape = (UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
//UIInterfaceOrientationMaskAll = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortraitUpsideDown),
//UIInterfaceOrientationMaskAllButUpsideDown = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
#import <Foundation/Foundation.h>
@protocol PPJViewControllerProt;
@class UIViewController;
typedef NS_ENUM(NSInteger,  PPJSwitchType) {
    PPJSwitchTypeNone,
   PPJSwitchTypePush,
    PPJSwitchTypePushFromTopper,
    
    PPJSwitchTypePresent,
   PPJSwitchTypeSetAsRoot,
    PPJSwitchTypeAddOnWindowRoot
};
@interface PPJSwitchPack : NSObject
+(instancetype)packWithVC:(id<PPJViewControllerProt>)vc andSwitchType:(PPJSwitchType)switchType;
-(instancetype)initWithVC:(id<PPJViewControllerProt>)vc andSwitchType:(PPJSwitchType)switchType;

@property (nonatomic,retain)UIViewController <PPJViewControllerProt> *vc;
@property (nonatomic)PPJSwitchType switchType;

@property (nonatomic)BOOL animated;

-(instancetype)setSwitchAnimated:(BOOL)animated;

@end
