//
//  PPStateTextField.m
//  Blok
//
//  Created by Alex Padalko on 12/11/15.
//  Copyright © 2015 com.placepixel. All rights reserved.
//

#import "PPStateTextField.h"

#import "UIFont+AppFonts.h"
#import "UIColor+HEX.h"


#import <ReactiveCocoa/ReactiveCocoa.h>

#import "RACSignal+Object.h"
@interface PPStateTextField ()
@property (nonatomic,retain)UILabel * errorLabel;
@property (nonatomic,retain)UIImageView * stateIcon;
@property (nonatomic,retain)NSMutableDictionary * stateTextsDict;
@property (nonatomic,retain)NSMutableDictionary * statesIcons;

@end
@implementation PPStateTextField

@synthesize stateType=_stateType;
@synthesize stopEditionSignal=_stopEditionSignal;
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        _indicatorColor=[UIColor blackColor];
        self.rightViewMode=UITextFieldViewModeAlways;
        self.errorLabelOffset=CGSizeMake(-46, -2);
        self.errorLabelFont =[UIFont muesoRounded500WithSize:9];
        self.errorLabelColor=[UIColor colorFromHexString:@"f2385a"];
        _stateType=-11;
    }
    
    return self;
}
-(void)setIndicatorColor:(UIColor *)indicatorColor{
    _indicatorColor=indicatorColor;
}
#pragma mark - state prot
-(void)setStateType:(PPStateTFType)stateType{
    if (stateType==_stateType) {
        return;
    }
    
    _stateType=stateType;
    [_errorLabel removeFromSuperview];
    _errorLabel=nil;
    
    NSString * key =[NSString stringWithFormat:@"%ld",stateType];
    if ([self.stateTextsDict valueForKey:key]) {
        [self.errorLabel setText:[self.stateTextsDict valueForKey:key]];
    }
    
    if (stateType==PPStateTFTypeCheking) {
        UIActivityIndicatorView * av=[[UIActivityIndicatorView alloc] init];
     
        [av setFrame:CGRectMake(0, 0, 44, 48)];
        [av setColor:self.indicatorColor];
        self.rightView=av;
        [av startAnimating];
    }else{
   

        if(stateType==PPStateTFTypeNone){
            
            self.rightView=nil;
            
        }else if (stateType==PPStateTFTypeFailed||stateType==PPStateTFTypeFailedFormat){
            
            
            
            
            [self setupStateIconForState:stateType];
            
        }else if (stateType==PPStateTFTypeOk){
            
            [self setupStateIconForState:stateType];
        }
        


    }
    
            [self setNeedsLayout];
}
-(void)setupStateIconForState:(PPStateTFType)state{
            NSString * key =[NSString stringWithFormat:@"%ld",state];
    NSDictionary * iconDict = [self.statesIcons valueForKey:key];
    
    if (iconDict) {
       
        if ([iconDict valueForKey:@"color"]) {
            [self.stateIcon setImage:[[UIImage imageNamed:[iconDict valueForKey:@"iconName"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            [self.stateIcon setTintColor:[iconDict valueForKey:@"color"]];
        }else{
            [self.stateIcon setImage:[UIImage imageNamed:[iconDict valueForKey:@"iconName"]]];
        }
               self.rightView=self.stateIcon;
    }else{
    
        if (state==PPStateTFTypeFailed||state==PPStateTFTypeFailedFormat) {
            [self.stateIcon setImage:[[UIImage imageNamed:@"tf_ico_fail"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            [self.stateIcon setTintColor:[UIColor colorFromHexString:@"f2385a"]];
            
            self.rightView=self.stateIcon;
            

        }else if (state==PPStateTFTypeOk){
            [self.stateIcon setImage:[[UIImage imageNamed:@"tf_ico_ok"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
            [self.stateIcon setTintColor:[UIColor colorFromHexString:@"30c4c0"]];
            self.rightView=self.stateIcon;
        }else{
            self.rightView=nil;
        }
        
        
    }

    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_errorLabel setFrame:CGRectMake(0, 0, 100, 48)];
    [_errorLabel sizeToFit];
    [_errorLabel setFrame:CGRectMake(self.frame.size.width+self.errorLabelOffset.width-_errorLabel.frame.size.width,self.errorLabelOffset.height, _errorLabel.frame.size.width, _errorLabel.frame.size.height)];
    
}
-(void)registerText:(NSString*)text forFailedState:(PPStateTFType)failedState{
    
    [self.stateTextsDict setValue:text forKey:[NSString stringWithFormat:@"%ld",(long)failedState]];
    
}
-(void)registerIcon:(NSString*)iconName withColor:(UIColor*)color forState:(PPStateTFType)state{
    
    
    NSMutableDictionary * dict = [@{@"iconName":iconName} mutableCopy];
    
    if (color) {
        [dict setValue:color forKey:@"color"];
    }
    
    [self.statesIcons setValue:dict forKey:[NSString stringWithFormat:@"%ld",(long)state]];
    
}
-(CGRect)rightViewRectForBounds:(CGRect)bounds{
    
     CGRect r1 =  [super rightViewRectForBounds:bounds];
    
    return r1;
    CGRect r= CGRectMake(self.frame.size.width-44-10, 0, 44, 45);;
    r.origin.y+=6;
    r.origin.x+=12;
    return r;
}
-(BOOL)becomeFirstResponder{
    
    
    // [self setStateType:MGAwesomeStateTFTypeNone];
    return [super becomeFirstResponder];
}

-(CGRect)textRectForBounds:(CGRect)bounds{
    
    CGRect r= [super textRectForBounds:bounds];
    
    //   r.size.width-=_errorLabel?(_errorLabel.frame.size.width+39):0;
    
    return r;
    
    
}
-(CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect r= [super editingRectForBounds:bounds];
    
    //  r.size.width-=_errorLabel?(_errorLabel.frame.size.width+39):0;
    
    return r;
}
-(RACSignal *)inputSignal{
    return self.rac_textSignal;
}
-(void)updateText:(NSString *)text{
    self.text=text;
}
-(NSString *)currentText{
    return self.text;
}
-(BOOL)isNowEditig{
    return [self isFirstResponder];
}
-(UIImageView *)stateIcon{
    
    if (!_stateIcon) {
        _stateIcon=[[UIImageView alloc] init];
        [_stateIcon setContentMode:UIViewContentModeCenter];
        [_stateIcon setBackgroundColor:[UIColor clearColor]];
        [_stateIcon setFrame:CGRectMake(0, 0, 44, 48)];
    }
    return _stateIcon;
}

-(NSMutableDictionary *)stateTextsDict{
    if (!_stateTextsDict) {
        _stateTextsDict=[[NSMutableDictionary alloc] init];
    }
    return _stateTextsDict;
}
-(NSMutableDictionary *)statesIcons{
    if (!_statesIcons) {
        _statesIcons=[[NSMutableDictionary alloc] init];
    }
    return _statesIcons;
}
-(UILabel *)errorLabel{
    
    if(!_errorLabel ){
        _errorLabel=[[UILabel alloc] init];
        
        [self addSubview:_errorLabel];
        [_errorLabel setFrame:CGRectMake(0, 0, 100, 48)];
        [_errorLabel setUserInteractionEnabled:NO];
        [_errorLabel setFont:self.errorLabelFont];
        [_errorLabel setTextColor:self.errorLabelColor];
        
    }
    return _errorLabel;
}
-(BOOL)resignFirstResponder{
    
    
    BOOL a=   [super resignFirstResponder];
    
    self.stopEditionSignal=[RACSignal signalWithObject:@"end"];
    
    return a;
}
@end
