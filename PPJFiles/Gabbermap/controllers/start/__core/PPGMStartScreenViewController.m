//
//  PPGMStartScreenViewController.m
//  Gabbermap
//
//  Created by Alex Padalko on 2/17/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGMStartScreenViewController.h"
#import "PPKeyBoardedNavigationController.h"


@interface PPGMSSBottomBarOverlay : UIView

@property (nonatomic,retain)UIButton * backButton;
@property (nonatomic,retain)UILabel * titleLabel;



@end

@implementation PPGMSSBottomBarOverlay
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor colorFromHexString:@"f4a401"]];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.backButton setFrame:CGRectMake(0, 0, 44, 44)];
    [self.titleLabel setFrame:CGRectMake(44, 0, self.frame.size.width-88, 44)];
}

-(UIButton *)backButton{
    if (!_backButton) {
        
        _backButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_backButton];
        [_backButton setImage:[[UIImage imageNamed:@"gm_altarrow_offset_right"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        
        [_backButton setTintColor:[UIColor whiteColor]];
    }
    return _backButton;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc] init];
        [_titleLabel setTextColor:[UIColor whiteColor]];
//        [_titleLabel setFont:[UIFont muesoRounded500WithSize:15]];
        [_titleLabel setNumberOfLines:2];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end

@interface PPGMSSRiderectView: UIView
@property (nonatomic,retain)UIView * rView;

@end
@implementation PPGMSSRiderectView

-(void)setRView:(UIView *)rView{
    _rView=rView;
    
    [super addSubview:rView];
}

-(void)addSubview:(UIView *)view{
    
    if ([view isKindOfClass:[UINavigationBar class]]||view.tag==-111) {
        [super addSubview:view];
    }else{
        [self.rView addSubview:view];
    }
}

@end

@interface PPGMStartScreenViewController ()


@end

@interface PPGMStartScreenViewController ()

@property (nonatomic,retain)UINavigationBar * bottomBar;
@property (nonatomic,retain)PPGMSSBottomBarOverlay * barOverlay;
@property (nonatomic,retain)UIView * bottomBarHolder;
@property (nonatomic)BOOL initialAppear;

@end
@implementation PPGMStartScreenViewController
@synthesize viewModel=_viewModel;



@synthesize textFieldsArray=_textFieldsArray;
@synthesize displayItemsArray=_displayItemsArray;
@dynamic  navigationController;
@synthesize currentTextField;
-(NSString *)apvc_nav_closeButtonImageName{
    return @"gm_cancel";
}
-(UIColor *)apvc_nav_closeButtonColor{
    return [UIColor whiteColor];
}

-(UINavigationBar *)bottomBar{
    
    if (!_bottomBar) {
        if (!self.shouldShowBottomBar) {
            return nil;
        }
        
        
        _bottomBarHolder=[[UIView alloc] init];
        _bottomBarHolder.tag=-111;
        [self.view addSubview:_bottomBarHolder];
        
        _bottomBar=[[UINavigationBar alloc] init];
        _bottomBar.translucent=NO;
        _bottomBar.barStyle = UIBarStyleBlackOpaque;
        [_bottomBar setBarTintColor:[UIColor colorFromHexString:@"2ec3bf"]];
        [_bottomBar setTitleTextAttributes:@{
                                              NSFontAttributeName: [UIFont muesoRounded500WithSize:17],
                                              NSForegroundColorAttributeName: [UIColor whiteColor]}];
        
        [self.bottomBarHolder addSubview:_bottomBar];
        
       _bottomBar.layer.masksToBounds = NO;
        _bottomBar.layer.shadowOffset = CGSizeMake(0, -1);
       _bottomBar.layer.shadowRadius = 2;
       _bottomBar.layer.shadowOpacity = 0.5;
        
        PPGMSSBottomBarOverlay * ov=[[PPGMSSBottomBarOverlay alloc] init];
        
        if (self.navigationController.viewControllers.count==1) {
            
            UIImage * img =[UIImage imageNamed:@"gm_cancel"];
                [ov.backButton addTarget:self action:@selector(apvc_closeAction) forControlEvents:UIControlEventTouchUpInside];
            [ov.backButton setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
            
        }
        else{
                    [ov.backButton addTarget:self action:@selector(ppjvc_backAction) forControlEvents:UIControlEventTouchUpInside];
        }

        [ov setHidden:YES];
        ov.titleLabel.text=[@"loc.auth.bar.notReachable" localized];
        self.barOverlay=ov;
        [_bottomBarHolder addSubview:ov];
        
        
        
    }
    return _bottomBar;
    
}
-(void)apvc_closeAction{
    [super ppjvc_closeAction];
    [self.currentTextField resignFirstResponder];
    
}
-(void)dissmiss{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(Class)apvc_navigationControllerClass{
    return [PPKeyBoardedNavigationController class];
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.initialAppear=YES;

}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.initialAppear=NO;
}
-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    
    [super dismissViewControllerAnimated:flag completion:^(){
        
        if (completion) {
            completion();
                   }
        
        [self.currentTextField resignFirstResponder];

    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        if (self.shouldShowBottomBar) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
           
    [self.currentTextField becomeFirstResponder];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        }

    
    if (self.shouldShowBottomBar) {
        if (self.keyBoardHeight==0) {
            
            if (self.navigationController.viewControllers.count>1) {
              PPGMStartScreenViewController * vc = (PPGMStartScreenViewController*)   [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
                
                
                if ([vc isKindOfClass:[PPGMStartScreenViewController class]]) {
                    
                    
                    self.keyBoardHeight=vc.keyBoardHeight;
                }
                
            }
            
        }
        
            [self.bottomBar setItems:@[self.navigationItem]];
//        [self.bottomBar setFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
    }
//    [self itemsLayout];

    
    
    

}

-(void)setContinueEnabled:(BOOL)continueEnabled{
    
    _continueEnabled=continueEnabled;
    
    
    if (!_continueEnabled) {
        [self.rightButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];;
   
    }else{
        [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];;
   
        
        
    }
    
    
    
    
}

-(void)didStartLoadingSoemthign{
    for (UITextField * v in self.contentView.subviews) {
        if ([v isFirstResponder]) {
            self.currentTextField=v;
            [v resignFirstResponder];
        }
    }
    
//    [PPLoaderHud show];
}
-(void)didFinishLoadingSoemthingWithError:(NSError*)error{
//    [PPLoaderHud dismiss];
    if (error) {
           [self.currentTextField becomeFirstResponder];
    }
   
}
-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    
    @weakify(self);
    [RACObserve(self.viewModel, loadingSignal) subscribeNext:^(id x) {
        
        
        if (x) {
            @strongify(self);
            [self didStartLoadingSoemthign];
        }

        
        
    }];
    
    [RACObserve(self.viewModel, stopLoadingSignal) subscribeNext:^(RACSignal  * sig) {
       
        if (sig) {
            
            
            [sig subscribeNext:^(id x) {
               
                @strongify(self);
                [self didFinishLoadingSoemthingWithError:x];
                
            }];
         
          
        }
        
    }];

    
    if (self.shouldShowBottomBar) {
        [self setView:[[PPGMSSRiderectView alloc] init]];
        
        [(PPGMSSRiderectView*)self.view setRView:self.contentView];
    }

    
    if ([UIScreen mainScreen].bounds.size.width==320) {
        self.topOffset=18;
           self.titleItemSpace=26;
    }else{
        self.topOffset=38;
        self.titleItemSpace=76;
    }
       [self.view setBackgroundColor:[UIColor colorFromHexString:@"10d6d2"]];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    
    NSMutableAttributedString * titleAttrStr=[self titleAttrString];

    if (titleAttrStr) {
        self.titleLable=[[UILabel alloc] init];
        [self.titleLable setNumberOfLines:0];
        [self.titleLable setAttributedText:titleAttrStr];
        CGSize s = [titleAttrStr
                ppj_sizeOfStringWithAvailableSize:
                        CGSizeMake([UIScreen mainScreen].bounds.size.width-self.screenInsets.left-self.screenInsets.right,
                                CGFLOAT_MAX)];
        [self.titleLable setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-s.width/2, self.screenInsets.top, s.width, s.height)];
        [self.view addSubview:self.titleLable];
    }
    
    
    if (self.rightButtonTitle.length>0) {
        UIButton *  nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextButton setTitle:[self rightButtonTitle] forState:UIControlStateNormal];
        [nextButton setBackgroundColor:[UIColor colorFromHexString:@"f4a401"]];
        nextButton.titleLabel.font = [UIFont muesoRounded700WithSize:15];
        [nextButton.layer setCornerRadius:4.0f];
        [nextButton.layer setMasksToBounds:YES];
        CGSize buttonSize = [nextButton sizeThatFits:CGSizeMake(1000, 44)];
        nextButton.frame = CGRectMake(0, 0, buttonSize.width + 20, buttonSize.height);
        [nextButton addTarget:self action:@selector(_onRightButton:) forControlEvents:UIControlEventTouchUpInside];
        [self ppjvc_nav_setButton:nextButton onSide:PPJBarButtonSideRight withOffset:5];
        
        self.rightButton=nextButton;
    }
    
    
    
    if (self.shouldShowBottomBar) {
        
        [self.bottomBar setFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];

}

            [self itemsLayout];
    
    
    [RACObserve(self.viewModel, internetConnectionAvailable) subscribeNext:^(id x) {
        
        if (x) {
            @strongify(self);
            [self.barOverlay setHidden:[x boolValue]];
            if ([x boolValue]) {
                [self.bottomBar bringSubviewToFront:self.barOverlay];
            }
        }
    }];
}
-(void)continueButtonDidntPass{
    
}
-(void)_onRightButton:(UIButton*)button{
    if (!self.continueEnabled) {
        [self continueButtonDidntPass];
        return;
    }
    [self onRightButton:button];
    
    
}
-(void)onRightButton:(UIButton*)button{

    [[self.viewModel continueCommand] execute:nil];
}
-(NSString*)rightButtonTitle{
    return nil;
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.barOverlay setFrame:self.bottomBarHolder.bounds];
    [self.bottomBar setFrame:self.bottomBarHolder.bounds];
    if (self.view.frame.size.width==320) {
            [self.littleDudeImageView setFrame:CGRectMake(-11, 10, 44,44)];
    }else{
            [self.littleDudeImageView setFrame:CGRectMake(-4, 12+10, 44,44)];
    }

    if (self.blockLayout) {
        return;
    }
    [self itemsLayout];
}
-(void)itemsLayout{
    if ([self shouldShowBottomBar]) {
        [self.bottomBarHolder setFrame:CGRectMake(0, self.view.frame.size.height-self.keyBoardHeight-44, self.view.frame.size.width, 44)];
        [self.contentView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.keyBoardHeight-44)];
    }
  
}

//#pragma -nav pack
//-(void)apvc_didReciveSwitchPack:(PPJSwitchPack *)switchPack{
//
//    if (switchPack.switchType==PPJSwitchTypePush) {
//        [self.navigationController pushViewController:(UIViewController*)switchPack.vc animated:YES];
//    }else{
//     [self.navigationController presentViewController:(UIViewController*)switchPack.vc animated:YES completion:^{
//
//     }];
//    }
//
//}
#pragma mark - lazy init
-(UIScrollView *)contentView{
    if (!_contentView) {
        _contentView=[[UIScrollView alloc] init];
        [_contentView setBackgroundColor:[UIColor clearColor]];
    }
    return _contentView;
}
-(NSMutableArray *)displayItemsArray{
    if (!_displayItemsArray) {
        _displayItemsArray=[[NSMutableArray alloc] init];
    }
    return _displayItemsArray;
}
-(NSMutableArray *)textFieldsArray{
    if (!_textFieldsArray) {
        _textFieldsArray=[[NSMutableArray alloc] init];
    }
    return _textFieldsArray;
}

#pragma mark - setup

-(UIColor *)defaultBackButtonColor{
    
    return [UIColor colorFromHexString:@"269993"];
}
-(BOOL)defalutNavControll{
    return NO;
}
-(NSMutableAttributedString *)titleAttrString{
    return nil;
}



-(UIEdgeInsets)screenInsets{
    return UIEdgeInsetsMake(self.topOffset, 27, 0, 27);
}
-(BOOL)shouldShowBottomBar{
    return YES;
}


#pragma mark - keyboard methods
-(void)keyboardWillHide:(NSNotification *)notif{
    

    CGSize keyBoardSize = [[[notif userInfo]
                            objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    float duration = [[[notif userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    self.keyBoardHeight=0;
    self.blockLayout=YES;
    [UIView animateWithDuration:duration animations:^{
        [self itemsLayout];
    }completion:^(BOOL finished) {
        self.blockLayout=NO;
    }];
    
}
-(void)keyboardWillAppear:(NSNotification*)notif{
    return;
    CGSize keyBoardSize = [[[notif userInfo]
                            objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    self.keyBoardHeight=keyBoardSize.height;
    
      self.blockLayout=YES;
    if (!self.initialAppear) {
//        self.initialAppear=YES;
     
//            [self itemsLayout];
//     
//            self.blockLayout=NO;
     
    }else{
        float duration = [[[notif userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        self.blockLayout=YES;
        [UIView animateWithDuration:duration animations:^{
            [self itemsLayout];
        }completion:^(BOOL finished) {
            self.blockLayout=NO;
        }];
    }
    

    //    float duration = [[[notif userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
}
-(void)keyboardWillChangeFrame:(NSNotification*)notif{
    CGSize keyBoardSize = [[[notif userInfo]
                            objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    self.keyBoardHeight=keyBoardSize.height;
  

    if (!self.initialAppear) {
//        self.initialAppear=YES;
//
//        [self itemsLayout];
//        
//        self.blockLayout=NO;
        
    }else{
            self.blockLayout=YES;
        float duration = [[[notif userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        self.blockLayout=YES;
        [UIView animateWithDuration:duration animations:^{
            [self itemsLayout];
        }completion:^(BOOL finished) {
            self.blockLayout=NO;
        }];
    }

}
-(UIImageView *)littleDudeImageView{
    
    if (!_littleDudeImageView&&[self shouldShowLittleDude]) {
        _littleDudeImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lb_tiny_cute"]];

        
        
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1 / 500.0;
        transform = CATransform3DRotate(transform, (M_PI * 30)/180, 0, 0, 1);
        [_littleDudeImageView.layer setTransform:transform];
//        _littleDudeImageView.transform=CGAffineTransformScale(_littleDudeImageView.transform, .5, .5);
        
        [self.view addSubview:_littleDudeImageView];
    }
    return _littleDudeImageView;
    
}
///
-(BOOL)shouldShowLittleDude{
    return YES;
}
@end
