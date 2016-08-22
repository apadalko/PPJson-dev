//
//  PPGMSignUpViewController.m
//  Gabbermap
//
//  Created by Alex Padalko on 2/17/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGMSignUpViewController.h"
@interface PPGMSignUpViewController(){

}

@property (nonatomic,retain)PPStateTextField * emailTextField;
@property (nonatomic,retain)PPStateTextField * passwordTextField;


@end;
@implementation PPGMSignUpViewController
@synthesize viewModel=_viewModel;
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.currentTextField becomeFirstResponder];
        [PPAnswer trackScreenWithName:@"Sign Up"];
}


-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    self.title=[@"loc.signUp" localized];

  
   self.emailTextField =[PPStateTextField createWithPlaceHolder:[@"loc.placeholder.signUp.email" localized] andImageName:@"email_icon_small" andImageColor:[[UIColor whiteColor] colorWithAlphaComponent:0.8]];
    self.emailTextField.indicatorColor=[UIColor whiteColor];
    [ self.emailTextField registerText:[@"loc.error.wrongEmailFormat" localized] forFailedState:PPStateTFTypeFailedFormat];
    [ self.emailTextField registerText:[@"loc.error.emailTaken" localized] forFailedState:PPStateTFTypeFailed];
    [self.emailTextField registerIcon:@"gm_onboarding_x" withColor:[UIColor whiteColor] forState:PPStateTFTypeFailedFormat];
        [self.emailTextField registerIcon:@"gm_onboarding_x" withColor:[UIColor whiteColor] forState:PPStateTFTypeFailed];
           [self.emailTextField registerIcon:@"gm_onboarding_check" withColor:[UIColor whiteColor] forState:PPStateTFTypeOk];
    [self.emailTextField setClipsToBounds:NO];
    [self.emailTextField setBackgroundColor:[UIColor colorFromHexString:@"2ec3bf"]];
    [self.emailTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [self.emailTextField setReturnKeyType:UIReturnKeyNext];
    self.emailTextField.shouldDrawBotLine=NO;
    self.emailTextField.shouldDrawTopLine=NO;
    [self.emailTextField setFont:[UIFont muesoRounded500WithSize:17]];
    [self.emailTextField setTextColor:[UIColor whiteColor]];
    [self.emailTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.emailTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
   self. emailTextField.layer.cornerRadius=8;
    self.emailTextField.placeHolderColor=[UIColor colorFromHexString:@"28998b"];
    self.emailTextField.errorLabelOffset=CGSizeMake(-8, 44+6);
    self.emailTextField.errorLabelColor=[UIColor whiteColor];
    self.emailTextField.errorLabelFont=[UIFont muesoRounded500WithSize:13];
    
      [self.emailTextField setStateType:PPStateTFTypeNone];
  
    [self.textFieldsArray addObject:self.emailTextField];
    [self.view addSubview:self.emailTextField];
    
    
    [self.viewModel  registerEmailInputForCheck:self.emailTextField];
    
    self.passwordTextField =[PPStateTextField createWithPlaceHolder:[@"loc.placeholder.signUp.password" localized] andImageName:@"lock_icon_small" andImageColor:[[UIColor whiteColor] colorWithAlphaComponent:0.8]];
    [self.passwordTextField registerIcon:@"gm_onboarding_x" withColor:[UIColor whiteColor] forState:PPStateTFTypeFailedFormat];
    [self.passwordTextField registerIcon:@"gm_onboarding_x" withColor:[UIColor whiteColor] forState:PPStateTFTypeFailed];
    [self.passwordTextField registerIcon:@"gm_onboarding_check" withColor:[UIColor whiteColor] forState:PPStateTFTypeOk];
    [ self.passwordTextField registerText:[@"loc.error.shortPassword" localized] forFailedState:PPStateTFTypeFailedFormat];
    [self.passwordTextField setClipsToBounds:NO];
    [self.passwordTextField setBackgroundColor:[UIColor colorFromHexString:@"2ec3bf"]];
    [self.passwordTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    [self.passwordTextField setReturnKeyType:UIReturnKeyNext];
   self. passwordTextField.shouldDrawBotLine=NO;
    self.passwordTextField.shouldDrawTopLine=NO;
    [self.passwordTextField setFont:[UIFont muesoRounded500WithSize:17]];
    [self.passwordTextField setTextColor:[UIColor whiteColor]];
    [self.passwordTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.passwordTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    self.passwordTextField.layer.cornerRadius=8;
    self.passwordTextField.placeHolderColor=[UIColor colorFromHexString:@"28998b"];
    self.passwordTextField.errorLabelOffset=CGSizeMake(-8, 44+6);
    self.passwordTextField.errorLabelColor=[UIColor whiteColor];
   self. passwordTextField.errorLabelFont=[UIFont muesoRounded500WithSize:13];
    
   self. passwordTextField.secureTextEntry=YES;
        [self.passwordTextField setStateType:PPStateTFTypeNone];
    [self.textFieldsArray addObject:self.passwordTextField];
    [self.view addSubview:self.passwordTextField];
    
    self.currentTextField=self.emailTextField;
    
    
    @weakify(self)
    RAC(self,continueEnabled) =   [RACSignal combineLatest:@[RACObserve(self.emailTextField,stateType),RACObserve(self.passwordTextField, stateType)]   reduce:^id(NSNumber * s1,NSNumber  * s2){
        
        if ([s1 integerValue]==PPStateTFTypeFailed||[s1 integerValue]==PPStateTFTypeFailedFormat) {
            //            [[PPGrabber oneAndOnly] upset:1.0 complitBlock:^{
            //
            //            }];
        }
        
        if ([s1 integerValue]==PPStateTFTypeOk&&[s2 integerValue]==PPStateTFTypeOk) {
            return @YES;
        }else{
            return @NO;
        }
    }];
    
    [self.passwordTextField.rac_textSignal subscribeNext:^(NSString* x) {
        @strongify(self);
        
        if(x.length>0){
            NSString * text = x;
            
            

            if (text.length>=6) {
                [self.passwordTextField setStateType:PPStateTFTypeOk];
            }else if (text.length==0){
                [self.passwordTextField setStateType:PPStateTFTypeNone];
            }else if ([self.passwordTextField isFirstResponder]){
                    [self.passwordTextField setStateType:PPStateTFTypeNone];
            }else{
                   [self.passwordTextField setStateType:PPStateTFTypeFailedFormat];
            }
        }
        
        
    }];
    
    
    [[self.passwordTextField stopEditionSignal] subscribeNext:^(id x) {
        
        
        if (x) {
            @strongify(self);
            if (self.passwordTextField.text.length<6) {
                [self.passwordTextField setStateType:PPStateTFTypeFailedFormat];
            }else{
                [self.passwordTextField setStateType:PPStateTFTypeOk];
            }
        }
        
    }];

    
}
-(void)continueButtonDidntPass{
    
    if (self.passwordTextField.text.length>0&&self.passwordTextField.text.length<6) {
        [self.passwordTextField setStateType:PPStateTFTypeFailedFormat];
    }
    
    if (self.emailTextField.text.length>0) {
        
        if (self.emailTextField.stateType!=PPStateTFTypeOk&&self.emailTextField.stateType!=PPStateTFTypeFailed) {
            [self.emailTextField setStateType:PPStateTFTypeFailedFormat];
        }
        
    }
    
}
-(void)onRightButton:(UIButton *)button{
    [self.viewModel.continueCommand execute:RACTuplePack(self.emailTextField.text,self.passwordTextField.text)];
}
-(NSMutableAttributedString *)titleAttrString{
    
    
    return [[NSMutableAttributedString alloc] initWithString:[@"loc.auth.signUp.title" localized] attributes:@{
                                                                                                               
                                                                                                               NSFontAttributeName:[UIFont muesoRounded700WithSize:19],
                                                                                                               NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                                                               
                                                                                                               }];
}
@end
