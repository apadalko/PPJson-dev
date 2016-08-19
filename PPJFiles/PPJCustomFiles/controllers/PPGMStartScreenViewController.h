//
//  PPGMStartScreenViewController.h
//  Gabbermap
//
//  Created by Alex Padalko on 2/17/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPJViewController.h"
#import "PPGMStartScreenViewModel.h"
#import "UIColor+HEX.h"

#import "PPKeyBoardedViewControllerProt.h"
@interface PPGMStartScreenViewController : PPJViewController <PPKeyBoardedViewControllerProt>
@property (nonatomic,retain)PPGMStartScreenViewModel * viewModel;
@property (nonatomic,retain)UIImageView * littleDudeImageView;
@property (nonatomic,retain)UILabel * titleLable;
@property (nonatomic)float topOffset;
-(NSMutableAttributedString*)titleAttrString;

-(UIEdgeInsets)screenInsets;
@property (nonatomic)float titleItemSpace;

-(BOOL) shouldShowBottomBar;

@property (nonatomic)float keyBoardHeight;
@property (nonatomic)BOOL blockLayout;

@property (nonatomic,retain)UIScrollView * contentView;
@property (nonatomic,retain)UIButton * rightButton;
-(void)onRightButton:(UIButton*)button;

@property (nonatomic)BOOL continueEnabled;
-(void)continueButtonDidntPass;


-(void)didStartLoadingSoemthign;
-(void)didFinishLoadingSoemthingWithError:(NSError*)error;

-(BOOL)shouldShowLittleDude;
@end
