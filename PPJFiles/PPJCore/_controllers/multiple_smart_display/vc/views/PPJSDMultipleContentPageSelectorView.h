//
//  MGNotifcationPageSelectorView.h
//  Blok
//
//  Created by Alex Padalko on 4/19/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import <UIKit/UIKit.h>
#import "PPJSDMultipleContentPageSelectorProt.h"
@interface PPJSDMultipleContentPageSelectorView : UIView<PPJSDMultipleContentPageSelectorProt>


-(void)selectIndex:(NSInteger)idx;

-(void)setButtonsSelectedColorTitleColor:(UIColor*)selectedColor;
-(void)setButtonsDefaultTitleColor:(UIColor*)color;
-(void)setButtonsFont:(UIFont*)font;
@property (nonatomic)float selectorOfsset;
-(void)setSelectorColor:(UIColor*)color;



@end
