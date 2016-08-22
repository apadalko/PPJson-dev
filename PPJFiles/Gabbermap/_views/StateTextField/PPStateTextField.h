//
//  PPStateTextField.h
//  Blok
//
//  Created by Alex Padalko on 12/11/15.
//  Copyright © 2015 com.placepixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLinedTextField.h"
#import "PPStateTextFieldProt.h"
@interface PPStateTextField : PPLinedTextField<PPStateTextFieldProt>
-(void)registerText:(NSString*)text forFailedState:(PPStateTFType)failedState;
@property (nonatomic)CGSize errorLabelOffset;
-(void)registerIcon:(NSString*)iconName withColor:(UIColor*)color forState:(PPStateTFType)state;
@property (nonatomic,retain)UIColor * errorLabelColor;
@property (nonatomic,retain)UIFont * errorLabelFont;


@property (nonatomic,retain)UIColor * indicatorColor;
@end
