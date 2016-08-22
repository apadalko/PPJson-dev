//
//  PP3dButton.h
//  Blok
//
//  Created by Alex Padalko on 12/11/15.
//  Copyright © 2015 com.placepixel. All rights reserved.
//

#import "PPJButton.h"

@interface PP3dButton : PPJButton
+(instancetype)buttonWithColor:(UIColor*)buttonColor;
+(instancetype)buttonWithColor:(UIColor*)buttonColor andTitle:(NSString*)title;
+(instancetype)buttonWithColor:(UIColor*)buttonColor andTitle:(NSString*)title andFont:(UIFont*)font;

@property (nonatomic,retain)UIView * customOverlayView;

@end
