//
//  MGSDViewController.m
//  Blok
//
//  Created by Alex Padalko on 4/14/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJSDViewController.h"
#import "PPJSDTableView.h"

@interface PPJSDViewController ()
@property (nonatomic,retain)NSMutableArray  * textFieldsArray;
@property (nonatomic)float deltaOffset;
@property (nonatomic)float deltaInset;
@end
@implementation PPJSDViewController
@synthesize viewModel;

-(void)viewDidLoad{
    [super viewDidLoad];
    self.contentViewClass=[PPJSDTableView class];
    self.deltaOffset=0;
    self.deltaInset=0;
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    @weakify(self);
    [RACObserve(self.viewModel, fieldsArraySignal) subscribeNext:^(RACSignal * sig) {
       
        if (sig) {
            
            [sig subscribeNext:^(id x) {
                @strongify(self);
                self.textFieldsArray=[[NSMutableArray alloc] initWithArray:x];
            }];
            

        }
        
    }];
}
-(BOOL)resignResonderOnScroll{
    return NO;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated   ];
    if(self.allowAutomaticInputOffset){
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_keyboardWillChangeFrame:)
                                                     name:UIKeyboardWillChangeFrameNotification
                                                   object:nil];
    }

}
-(void)contentViewDidCreated:(id<PPJSDControllerViewProtocol>)contentView{
    
    if ([contentView isKindOfClass:[UITableView class]]) {
        UITableView * tb =(UITableView*)contentView;
        [tb setSeparatorColor:[UIColor redColor]];
    }
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if([self allowAutomaticInputOffset]){
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }

}
-(id<PPJSDControllerViewProtocol>)contentView{
    
    if (!_contentView) {
        if(self.contentViewClass ){
             id tv=[[self.contentViewClass alloc ] initWithFrame:CGRectZero];
            
            
            
            _contentView=tv;
            [_contentView setBaseDirector:self.viewModel];
            [self contentViewDidCreated:_contentView];
            
        }
    
        else _contentView=[[self.contentViewClass alloc] init];
        
        [self.view addSubview:(UIView*)_contentView];
        [self.viewModel bindSmartView:_contentView];
       // [(MGPPJSDBaseTableView*)_contentView setResignResponderOnScroll:[self resignResonderOnScroll]];
    }
    
    return _contentView;
    
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    float topY=CGRectGetMaxY(self.navigationController.navigationBar.frame);

    
    if (self.navigationController.navigationBar.translucent) {
            [(UIView*) self.contentView   setFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44)];
    }else
    
    [(UIView*) self.contentView   setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
}


-(void)setTextFieldsArray:(NSMutableArray *)textFieldsArray{
    
    NSMutableArray * newArr=[[NSMutableArray alloc] init];

        

                    for (id obj2 in textFieldsArray) {
                        
                        BOOL shouldAdd=YES;
                                for (id obj in _textFieldsArray) {
                                        if ([obj isEqual:obj2]) {
           
                                            shouldAdd=NO;
                                            break;
                                        }
                            
                                    
                    }
                        
                        if (shouldAdd) {
                                    [newArr addObject:obj2];
                        }
                        
        }
        
    
    _textFieldsArray=textFieldsArray;
    

    
}

-(UIView*)currentTextField{
    
    for (UIView * v in self.textFieldsArray) {
        if ([v isFirstResponder]) {
            return v;
        }
    }
    return nil;
}

-(void)_keyboardWillShow:(NSNotification*)notify{
    [self updatePostionWithNotification:notify];
}
-(void)_keyboardWillChangeFrame:(NSNotification*)notify{
      //  [self updatePostionWithNotification:notify];
}
-(UIScrollView*)sv{
    return (UIScrollView*) self.contentView;
}
-(void)updatePostionWithNotification:(NSNotification*)notif{
    
    CGSize    keyboardSize = [[[notif userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
 //   NSTimeInterval dur=[self keyboardAnimationDurationForNotification:notif];
    UIWindow * w=[[UIApplication sharedApplication].delegate window];
    
    float kbTopY =w.frame.size.height-keyboardSize.height;
   
    
    UIView * curView=[self currentTextField];

    if (!curView) {
        return;
    }
    
    CGRect txtFrame =  [w convertRect:[curView frame] fromView:curView];
 
    float offset=(CGRectGetMaxY(txtFrame)+20)-kbTopY;
    
   // self.deltaOffset=offset-self.deltaOffset;
    if (offset>0) {

            [[self sv] setContentOffset:CGPointMake( 0,[self sv].contentOffset.y+offset)];
            [[self sv] setContentInset:UIEdgeInsetsMake(self.sv.contentInset.top, 0, keyboardSize.height+20, 0)];
        

 
    }
 //   float offset=kbTopY
//    if (txtFrame.origin.y > visibleY ) {
//    } else {
//    }
    
}


-(void)_keyboardWillHide:(NSNotification*)notify{
    //CGSize    keyboardSize = [[[notify userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
 //   [[self sv] setContentOffset:CGPointMake( 0,MAX(0, [self sv].contentOffset.y-self.deltaOffset))];
    [[self sv] setContentInset:UIEdgeInsetsMake(self.sv.contentInset.top, 0, 0, 0)];
    self.deltaInset=0;
    
}

-(BOOL)allowAutomaticInputOffset{
    return NO;
}


- (NSTimeInterval)keyboardAnimationDurationForNotification:(NSNotification*)notification
{
    NSDictionary* info = [notification userInfo];
    NSValue* value = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval duration = 0;
    [value getValue:&duration];
    return duration;
}
@end
