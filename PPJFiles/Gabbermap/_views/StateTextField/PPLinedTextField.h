//
//  PPLinedTextField.h
//  Blok
//
//  Created by Alex Padalko on 12/11/15.
//  Copyright © 2015 com.placepixel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPLinedTextField : UITextField
+(instancetype)createWithPlaceHolder:(NSString*)placeHolder andImageName:(NSString*)imageName;
+(instancetype)createWithPlaceHolder:(NSString *)placeHolder andImageName:(NSString *)imageName andImageColor:(UIColor*)imageColor;
@property (nonatomic,retain)UIColor * placeHolderColor;
@property (nonatomic)BOOL shouldDrawTopLine;
@property (nonatomic)BOOL shouldDrawBotLine;

@property (nonatomic)UIEdgeInsets  textInsets;

@property (nonatomic)float botLineOffset;

@property (nonatomic,retain)CAShapeLayer * bottomLineLayer;
@property (nonatomic,retain)CAShapeLayer * topLineLayer;
@end
