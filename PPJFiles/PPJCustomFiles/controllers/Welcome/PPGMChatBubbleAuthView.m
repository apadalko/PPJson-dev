//
//  PPGMChatBubbleAuthView.m
//  Gabbermap
//
//  Created by Alex Padalko on 6/2/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGMChatBubbleAuthView.h"
//#import "UIFont+AppFonts.h"
#import "UIColor+HEX.h"
//#import "PP3dDefaultButton.h"
@interface PPGMChatBubbleAuthView ()
@property (nonatomic,retain)/*PP3dDefaultButton*/UIButton          * faceBookButton;
@property (nonatomic,retain)UIButton                   * signInButton;
@property (nonatomic,retain)UIButton                   * signUpButton;
@property (nonatomic,retain)UIButton                   * skipButton;
@end

@implementation PPGMChatBubbleAuthView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame: frame]) {
        
        [self.contentView setBackgroundColor:[UIColor colorFromHexString:@"10d6d2"]];
        

        self.signInButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.signInButton addTarget:self action:@selector(onSignIn) forControlEvents:UIControlEventTouchUpInside];
//        [self.signInButton setTitle:[@"loc.signIn" localized] forState:UIControlStateNormal];
        [self.signInButton setTitle:@"sign in" forState:UIControlStateNormal];
        [self.signInButton setBackgroundColor:[[UIColor colorFromHexString:@"ffffff"] colorWithAlphaComponent:0.6]];
//        [self.signInButton.titleLabel setFont:[UIFont muesoRounded700WithSize:17]];
        [self.signInButton setTitleColor:[UIColor colorFromHexString:@"2dbbb7"] forState:UIControlStateNormal];
        [self.signInButton.layer setCornerRadius:8.0];
        [self.contentView addSubview:self.signInButton];
        
        self.signUpButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.signUpButton addTarget:self action:@selector(onSignUp) forControlEvents:UIControlEventTouchUpInside];
//        [self.signUpButton setTitle:[@"loc.signUp" localized] forState:UIControlStateNormal];
        [self.signUpButton setTitle:@"sign un" forState:UIControlStateNormal];
        [self.signUpButton setBackgroundColor:[UIColor colorFromHexString:@"f4a401"]];
//        [self.signUpButton.titleLabel setFont:[UIFont muesoRounded700WithSize:17]];
        [self.signUpButton setTitleColor:[UIColor colorFromHexString:@"ffffff"] forState:UIControlStateNormal];
        [self.signUpButton.layer setCornerRadius:8.0];
        [self.contentView addSubview:self.signUpButton];
        
        self.skipButton=[UIButton buttonWithType:UIButtonTypeCustom];
//        [self.skipButton.titleLabel setFont:[UIFont muesoRounded500WithSize:17]];
        [self.skipButton setTitleColor:[UIColor colorFromHexString:@"269993"] forState:UIControlStateNormal];
//        [self.skipButton setTitle:[@"loc.auth.skip" localized] forState:UIControlStateNormal];
        [self.skipButton setTitle:@"skip" forState:UIControlStateNormal];
        [self.skipButton addTarget:self action:@selector(onSkip) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.skipButton];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    float totalTopH= 47+15+44;
    
    float y = ( self.contentView.frame.size.height-40)/2-totalTopH/2;
    
    [self.faceBookButton setFrame:CGRectMake(8, y, self.contentView.frame.size.width-16,  47)];
    
    float bw = (self.faceBookButton.frame.size.width-6)/2;
    
    [self.signInButton setFrame:CGRectMake(8, CGRectGetMaxY(self.faceBookButton.frame)+15, bw, 44)];
    [self.signUpButton setFrame:CGRectMake(CGRectGetMaxX(self.signInButton.frame)+6, CGRectGetMaxY(self.faceBookButton.frame)+15, bw, 44)];
    
    [self.skipButton setFrame:CGRectMake(self.contentView.frame.size.width/2-(bw*1.5)/2, self.contentView.frame.size.height-40, bw*1.5, 40)];
}
-(void)onSignIn{
    [self.delegate authBubble_didSelectSignIn];
}
-(void)onSignUp{
     [self.delegate authBubble_didSelectSignUp];
}
-(void)onSkip{
       [self.delegate authBubble_didSelectSkip];
}
-(void)onFacebook{
       [self.delegate authBubble_didSelectFacebook];
}


//-(PP3dDefaultButton *)faceBookButton{
//    if (!_faceBookButton) {
//        _faceBookButton=[PP3dDefaultButton facebookButtonWithTitle:[@"loc.continueWithFacebook" localized]];
//        [_faceBookButton addTarget:self action:@selector(onFacebook) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_faceBookButton];
//    }
//    return _faceBookButton;
//}
-(UIButton *)faceBookButton{
    if (!_faceBookButton) {
        _faceBookButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_faceBookButton setTitle:@"fb" forState:UIControlStateNormal];
//        _faceBookButton=[PP3dDefaultButton facebookButtonWithTitle:[@"loc.continueWithFacebook" localized]];
        [_faceBookButton addTarget:self action:@selector(onFacebook) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_faceBookButton];
    }
    return _faceBookButton;
}
@end
