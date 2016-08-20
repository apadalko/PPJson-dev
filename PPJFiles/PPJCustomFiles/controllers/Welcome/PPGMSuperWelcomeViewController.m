//
//  PPGMSuperWelcomeViewController.m
//  Gabbermap
//
//  Created by Alex Padalko on 6/1/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGMSuperWelcomeViewController.h"
#import "PPGridView.h"

#import "PPGridCellPersonaView.h"
#import "PPGridCellPersonaObject.h"
//#import "APTextHelper.h"

#import "PPGMWelcomeChatBubbleView.h"
#import "PPGMWelcomeChatTextBubbleView.h"
#import "PPGMChatBubbleAuthView.h"
@interface PPGMSuperWelcomeViewController ()<PPGridViewDelegate,PPGridViewAnimationDelegate,PPGMChatBubbleAuthViewDelegate>
{
    
}
@property (nonatomic)BOOL stopAll;
@property (nonatomic,retain)PPGridView * gridView;

@property (nonatomic,retain)PPGridCellPersonaObject * owl;
@property (nonatomic,retain)PPGridCellPersonaObject * dog;
@property (nonatomic,retain)PPGridCellPersonaObject * koala;
@property (nonatomic,retain)PPGridCellPersonaObject * hamster;

@property (nonatomic)BOOL firstAppear;


@property (nonatomic,retain)UIImageView * mapBackgroundView;
@property (nonatomic,retain)UIView * tealOverlayView;
@end

@implementation PPGMSuperWelcomeViewController
@synthesize viewModel=_viewModel;
#pragma mark - text


-(BOOL)shouldShowBottomBar{
    return NO;
}
-(BOOL)shouldShowLittleDude{
    return NO;
}

-(NSMutableAttributedString *)topTitleWithText:(NSString*)text{
    
    
    NSString * top =text;
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment                = NSTextAlignmentCenter;
    NSMutableAttributedString * topAttr =[[NSMutableAttributedString alloc] initWithString:top attributes:@{
                                                                                                            
//                                                                                                            NSFontAttributeName:[UIFont muesoRounded900WithSize:21],
                                                                                                            NSForegroundColorAttributeName:[UIColor colorFromHexString:@"666666"],
                                                                                                            
                                                                                                            }];
    
    
//    [topAttr findwithFinders:@[@"@"] andHexColor:@"666666" andFont:[UIFont muesoRounded1000WithSize:21] removeFinder:YES];
    

    
    [topAttr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [topAttr string].length)];
    
    return topAttr;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
 NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)self));
    
}

#pragma mark -
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//          [PPAnswer trackScreenWithName:@"Welcome"];
    if (self.firstAppear) {
        return;
    }
    self.firstAppear=YES;
    [UIView animateWithDuration:1.0 animations:^{
        [self.tealOverlayView setBackgroundColor:[[UIColor colorFromHexString:@"f2eee8"] colorWithAlphaComponent:0.1]];
    }];
    [self.gridView showGridWithAnimation:YES complitBlock:^{
        
    
        [self startChatScript];
        
        
    }];
}
-(UIColor *)apvc_defaultBackgroundColor{
    return [UIColor redColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    self.mapBackgroundView=[[UIImageView alloc] init];
    
    [self.mapBackgroundView setImage:[UIImage imageNamed:@"mapScr"]];
    [self.mapBackgroundView setContentMode:UIViewContentModeScaleAspectFill];
    
    [self.view addSubview:self.mapBackgroundView];
    
    self.tealOverlayView=[[UIView alloc] init];
    [self.tealOverlayView setBackgroundColor:[UIColor colorFromHexString:@"10d6d2"]];
    [self.view addSubview:self.tealOverlayView];
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSInteger offset = 0;
    if ([UIScreen mainScreen].bounds.size.height==480) {
          self.gridView=[[PPGridView alloc] initWithGridSize:CGSizeMake(5, 8)];
        offset=1;
    }else{
          self.gridView=[[PPGridView alloc] initWithGridSize:CGSizeMake(5, 9)];
    }
  

    [self.gridView setBackgroundColor:[UIColor clearColor]];
    
    [self.gridView setDelegate:self];
//    [self.gridView setShouldShowBakgroundImage:YES];
    [self.gridView setAnimationDelegate:self];
    [self.view addSubview:self.gridView];
    self.koala=[[PPGridCellPersonaObject alloc] initWithGridPoint:CGPointMake(1, 1) andPersonaGifName:@"koala"];
    self.owl=[[PPGridCellPersonaObject alloc] initWithGridPoint:CGPointMake(4, 2) andPersonaGifName:@"owl"];
    self.hamster=[[PPGridCellPersonaObject alloc] initWithGridPoint:CGPointMake(0, 4-offset) andPersonaGifName:@"racoon"];
    self.dog=[[PPGridCellPersonaObject alloc] initWithGridPoint:CGPointMake(3, 5-offset) andPersonaGifName:@"dog"];
    
    
    
    
    
    
    
    [[self gridView] addGridCellObject:self.owl];
    [[self gridView] addGridCellObject:self.hamster];
    [self.gridView addGridCellObject:self.koala];
    [self.gridView addGridCellObject:self.dog];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAuth) name:@"pp_auth" object:nil];
    
    

    
}
-(void)onAuth{
    
     [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_coreChat_1_0) object:nil];
     [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_coreChat_2) object:nil];
     [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector( personaChating) object:nil];
     [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_coreChat_1_1) object:nil];
     [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_coreChat_1_0) object:nil];
    
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(cs_1) object:nil];
     [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(cs_2) object:nil];
     [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(cs_3) object:nil];
     [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(cs_4) object:nil];
     [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(cs_5) object:nil];

    

    [self.gridView removeFromSuperview];
    self.gridView=nil;
    self.stopAll=YES;
    
    [[self.koala representation] removeFromSuperview];
    
    [[self.hamster representation] removeFromSuperview];
    
    [[self.owl representation] removeFromSuperview];
    
    [[self.dog representation] removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
       [self.gridView setFrame:CGRectMake(6, 6, self.view.frame.size.width-12, self.view.frame.size.height-12)];
    
    [self.tealOverlayView setFrame:self.view.bounds];
    [self.mapBackgroundView setFrame:self.view.bounds];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PPGMChatBubbleAuthViewDelegate

-(void)authBubble_didSelectFacebook{

    [self.viewModel activateActionWithName:@"facebook_auth" andData:nil];

    [[self.viewModel facebookAuthCommand] execute:nil];
}
-(void)authBubble_didSelectSkip{
    [[self.viewModel skipCommand]execute:nil];
}
-(void)authBubble_didSelectSignIn{
   [ [self.viewModel signInCommand]execute:nil];
}
-(void)authBubble_didSelectSignUp{
  [  [self.viewModel singUpCommad]execute:nil];
}

#pragma mark - grid
-(PPGridCellView*)gv_gridCellViewFormObject:(id)object{
    
    if ([object isKindOfClass:[PPGridCellPersonaObject class]]) {
        return  [[PPGridCellPersonaView alloc] initWithGridCellObject:object];
    }else
    return nil;
}
-(NSArray<PPGridAnimationObject*>*)gva_gridApperanceAnimationSequence{
    
    NSMutableArray  * randomCell = [[NSMutableArray alloc] init];

    
    
    for (NSInteger a = 0; a<self.gridView.gridSize.width; a++) {
        
        for (NSInteger i = 0; i<self.gridView.gridSize.height; i++) {
        
            [randomCell addObject:[NSValue valueWithCGPoint:CGPointMake(a, i)]];
            
            
        }
        
     
        
    }
    
    NSMutableArray * result = [[NSMutableArray alloc] init];
    
    while (randomCell.count>0) {
        
        
        NSInteger count = MIN(randomCell.count, MAX(2, arc4random()%6));
        
        NSMutableArray * values = [[NSMutableArray alloc] init];
        while (count>0) {
            
            [values addObject:[self getRandomAnimFramesinArr:randomCell]];
            count--;
        }
        [result addObject:[PPGridAnimationObject createWithPoints:values andDelayFrames:arc4random()%5]];
        
  
        
    }
    
    return result;
    
}

-(NSValue*)getRandomAnimFramesinArr:(NSMutableArray*)array{
    
    
    NSInteger idx = arc4random()%array.count;
    
    NSValue  * val = [array objectAtIndex:idx];
    [array removeObjectAtIndex:idx];
    
    return val;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)startChatScript{
    
    
    [self performSelector:@selector(_coreChat_1_0) withObject:nil afterDelay:0.1];
    [self performSelector:@selector(_coreChat_2) withObject:nil afterDelay:0.1];
    
    
        [self performSelector:@selector(personaChating) withObject:nil afterDelay:.5];
}


///core chat
-(void)_coreChat_1_0{
    if(self.stopAll){
        return;
    }
    PPGMWelcomeChatTextBubbleView * cb = [[PPGMWelcomeChatTextBubbleView alloc] initWithFrame:CGRectMake(0,0, self.gridView.frame.size.width, self.gridView.blockSize.height+5)];
    cb.contentViewInsets=UIEdgeInsetsMake(5, 10, 10, 10);
    [self.gridView addSubview:cb];

    [cb setAttrString:[self topTitleWithText:@"welcome!"]];
    
    
    [cb showFromPoint:CGPointMake(self.koala.representation.center.x, self.koala.representation.center.y-self.koala.representation.frame.size.height) withDirection:PPGMChatBubbleDirectionTop removeAfter:7.5];
    
     [self performSelector:@selector(_coreChat_1_1) withObject:nil afterDelay:7.0];
    
}
-(void)_coreChat_1_1{
    if(self.stopAll){
        return;
    }
    PPGMWelcomeChatTextBubbleView * cb = [[PPGMWelcomeChatTextBubbleView alloc] initWithFrame:CGRectMake(0,0, self.gridView.frame.size.width, self.gridView.blockSize.height+5)];
    cb.contentViewInsets=UIEdgeInsetsMake(5, 10, 10, 10);
    [self.gridView addSubview:cb];
    
    [cb setAttrString:[self topTitleWithText:@"1_1"]];
    
    
    [cb showFromPoint:CGPointMake(self.koala.representation.center.x, self.koala.representation.center.y-self.koala.representation.frame.size.height) withDirection:PPGMChatBubbleDirectionTop removeAfter:6.1];
    
    [self performSelector:@selector(_coreChat_1_0) withObject:nil afterDelay:7.0];
    
}
-(void)_coreChat_2{
    if(self.stopAll){
        return;
    }
    PPGMChatBubbleAuthView * cb = [[PPGMChatBubbleAuthView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.dog.representation.frame)-5, self.gridView.frame.size.width,  self.gridView.blockSize.height*3+10)];
    cb.contentViewInsets=UIEdgeInsetsMake(10, 10, 5, 10);
    [self.gridView addSubview:cb];
    [cb setDelegate:self];
    [cb showFromPoint:CGPointMake(self.dog.representation.center.x, self.dog.representation.center.y+self.dog.representation.frame.size.height) withDirection:PPGMChatBubbleDirectionBottom removeAfter:0];
    [cb setDelegate:self];
}

////chating
-(void)personaChating{
    
    [self cs_1];
}
-(void)cs_1{
    if(self.stopAll){
        return;
    }
    [self _chatBubbleWithText:@"cs_1" onPersona:self.hamster andTime:3.1];
    [self performSelector:@selector(cs_2
                                    ) withObject:nil afterDelay:2.0];
}
-(void)cs_2{
    if(self.stopAll){
        return;
    }
    [self _chatBubbleWithText:@"cs_1" onPersona:self.owl andTime:3.1];
    [self performSelector:@selector(cs_3
                                    ) withObject:nil afterDelay:2.0];
}
-(void)cs_3{
    if(self.stopAll){
        return;
    }
     [self _chatBubbleWithText:@"cs_1" onPersona:self.hamster andTime:3.1];
    [self performSelector:@selector(cs_4
                                    ) withObject:nil afterDelay:2.0];
}
-(void)cs_4{
    if(self.stopAll){
        return;
    }
    [self _chatBubbleWithText:@"cs_1" onPersona:self.owl andTime:3.1];
    [self performSelector:@selector(cs_5
                                    ) withObject:nil afterDelay:2.0];
}
-(void)cs_5{
    if(self.stopAll){
        return;
    }
    [self _chatBubbleWithText:@"cs_1" onPersona:self.hamster andTime:4.1];
    [self performSelector:@selector(personaChating
                                    ) withObject:nil afterDelay:5];
}

-(void)_chatBubbleWithText:(NSString*)text onPersona:(PPGridCellPersonaObject*)persona andTime:(float)time{
    
  
    PPGMWelcomeChatTextBubbleView * cb = [[PPGMWelcomeChatTextBubbleView alloc] initWithFrame:CGRectMake(0, 0, self.gridView.blockSize.width*4, self.gridView.blockSize.height+10)];
    [self.gridView addSubview:cb];
    [cb setText:text];
    if ([persona isEqual:self.owl]) {
            [cb showFromPoint:CGPointMake(self.owl.representation.center.x-self.owl.representation.frame.size.width/2, self.owl.representation.center.y) withDirection:PPGMChatBubbleDirectionRight removeAfter:8];
    }else{
         [cb showFromPoint:CGPointMake(self.hamster.representation.center.x+self.hamster.representation.frame.size.width/2, self.hamster.representation.center.y) withDirection:PPGMChatBubbleDirectionLeft removeAfter:5];
    }

}

-(void)dealloc{
    NSLog(@"DDD");
}
@end
