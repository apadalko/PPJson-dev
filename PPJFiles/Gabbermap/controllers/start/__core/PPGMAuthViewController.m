//
//  PPGMAuthViewController.m
//  Gabbermap
//
//  Created by Alex Padalko on 2/17/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGMAuthViewController.h"
@interface PPGMAuthViewController ()

@end
@implementation PPGMAuthViewController
@synthesize viewModel=_viewModel;

-(void)viewDidLoad{

#warning NEWNAVIMP
//    if (self.navigationController.viewControllers.count==1) {
//        self.leftBarButton =  [self setLeftCloseButtonItemWithSelector:@selector(dissmiss) andColor:[self defaultBackButtonColor]];
//    }
    [super viewDidLoad];
    
    self.orLabel=[[UILabel alloc] init];
    [self.orLabel setFont:[UIFont muesoRounded500WithSize:17]];
    [self.orLabel setTextColor:[UIColor whiteColor]];
    [self.orLabel setText:[@"loc.or" localized]];
    [self.orLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.orLabel];
    
    

    
}

-(void)dissmiss{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    float w = self.view.frame.size.width-self.screenInsets.left-self.screenInsets.right;
    float x = self.screenInsets.left;
    [self.faceBookButton setFrame:CGRectMake(x, CGRectGetMaxY(self.titleLable.frame)+self.titleItemSpace, w , 47)];

    float orSize;
    if ([UIScreen mainScreen].bounds.size.width==320) {
        orSize=36;
    }else{
        orSize=42;
    }
    
    [self.orLabel setFrame:CGRectMake(x, CGRectGetMaxY(self.faceBookButton.frame), self.faceBookButton.frame.size.width, orSize)];
    
    
    float dy = CGRectGetMaxY(self.orLabel.frame);
    for (NSInteger  a  = 0; a<self.textFieldsArray.count; a++) {
        
        PPStateTextField * tf = [self.textFieldsArray objectAtIndex:a];
        [tf setFrame:CGRectMake(x, dy, w, 44)];
        
        if ([tf isKindOfClass:[PPStateTextField class]]) {
            
            if (tf.errorLabelOffset.height>=44) {
                dy+= 30;
                
            }else{
                    dy+= 10;
            }
            
        }else{
             dy+= 10;
        }
        
        dy+=44;
    }
    
    
    if (dy+10 > self.contentView.frame.size.height) {
        
        [self.contentView setContentSize:CGSizeMake(0, dy+10)];
    }
}



#pragma mark - actions
-(void)onFacebook{
    [[self.viewModel facebookAuthCommand] execute:nil];
}
#pragma mark - creations
-(PP3dButton *)faceBookButton{
    if (!_faceBookButton) {
        _faceBookButton=[PP3dButton buttonWithColor:[UIColor colorFromHexString:@"29abe2"] andTitle:[@"loc.continueWithFacebook" localized] andFont:[UIFont muesoRounded300WithSize:17]]
           [_faceBookButton addTarget:self action:@selector(onFacebook) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_faceBookButton];
    }
    return _faceBookButton;
}

-(NSString*)rightButtonTitle{
    return [[@"loc.continue" localized] capitalizedString];
}

@end
