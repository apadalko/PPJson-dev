//
//  MGNotifcationPageSelectorView.m
//  Blok
//
//  Created by Alex Padalko on 4/19/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJSDMultipleContentPageSelectorView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface PPJSDMultipleContentPageSelectorView ()
{
       CAGradientLayer *botShadow;
    
    
}




@property (nonatomic,retain)UIView * selectorView;

@end
@implementation PPJSDMultipleContentPageSelectorView
@synthesize buttonsArray=_buttonsArray;
@synthesize segmetsCount=_segmetsCount;
@synthesize pageView=_pageView;
+(instancetype)create{
    
    return [[self alloc] init];
    
    
}
-(void)didEndScrollWithOffset:(float)offset{
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self=[super initWithFrame:frame]) {
        
       [self setBackgroundColor:[UIColor whiteColor]];
        self.segmetsCount=1;
        botShadow = [CAGradientLayer layer];
        
        botShadow.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0.0 alpha:0.25f] CGColor], (id)[[UIColor clearColor] CGColor], nil];
       
        self.selectorOfsset=0;
      [self.layer insertSublayer:botShadow atIndex:0];
        

        
        
        self.selectorView=[[UIView alloc] init];
        [self.selectorView setBackgroundColor:[UIColor orangeColor]];
        [self addSubview:self.selectorView];
        
    }
    return self;
}

-(void)setSegmetsCount:(NSInteger)segmetsCount{
    
    _segmetsCount=segmetsCount;
    
    
    for (UIView * v in self.buttonsArray) {
        [v removeFromSuperview];
    }
    [self.buttonsArray removeAllObjects];
    
    self.buttonsArray=[[NSMutableArray alloc] init];
    
    for (int  a =0; a<segmetsCount; a++) {
        
        UIButton * but =[UIButton buttonWithType:UIButtonTypeCustom];
        [but.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [but setTitle:[NSString stringWithFormat:@"t%d",a] forState:UIControlStateNormal];
        
        [but setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [but setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [but addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:but];
        but.tag=a;

        
        [self.buttonsArray addObject:but];
    }
}

-(void)setButtonsSelectedColorTitleColor:(UIColor*)selectedColor{
    
    for (UIButton * but in self.buttonsArray) {
        [but setTitleColor:selectedColor forState:UIControlStateHighlighted];
        [but setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    
}
-(void)setButtonsDefaultTitleColor:(UIColor*)color{
    for (UIButton * but in self.buttonsArray) {
        [but setTitleColor:color forState:UIControlStateNormal];
    }
}
-(void)setButtonsFont:(UIFont*)font{
    for (UIButton * but in self.buttonsArray) {
        [but.titleLabel setFont:font];
    }
}

-(void)setSelectorColor:(UIColor*)color{
    [self.selectorView setBackgroundColor:color];
}


-(void)selectIndex:(NSInteger)idx{
    
    for (UIButton * b in  self.buttonsArray) {
        if (b.tag==idx) {
            [self onButton:b];
            
          //  [self.pageView setContentOffset:CGPointMake(b.frame.size.width*self.segmetsCount*b.tag, self.pageView.contentOffset.y)];
           return;
        }
    }
}
-(void)onButton:(UIButton*)but{
    if (but.selected) {
        return;
    }
    
    for (UIButton * b in self.buttonsArray) {
        if (but.tag!=b.tag) {
            but.selected=NO;
        }
    }
    but.selected=YES;
    
      [self.pageView setContentOffset:CGPointMake(but.frame.origin.x*self.segmetsCount, 0) animated:YES];
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.selectorView setFrame:CGRectMake(self.selectorView.frame.origin.x, self.frame.size.height-2-self.selectorOfsset, self.frame.size.width/self.segmetsCount, 2)];
    
           botShadow.frame = CGRectMake(0,self.frame.size.height, self.frame.size.width, 2);
    
    float w= self.frame.size.width/self.buttonsArray.count;
    for (int a=0; a<self.buttonsArray.count; a++) {
     
        UIButton * but=[[self buttonsArray] objectAtIndex:a];
        
        [but setFrame:CGRectMake(a*w, 0, w, self.frame.size.height)];
    }

    
}
-(void)setTitile:(NSString *)title forIndex:(NSInteger)index{
    
    if (index<self.buttonsArray.count) {
        
        UIButton * but=[self.buttonsArray objectAtIndex:index];
        
        [but setTitle:title forState:UIControlStateNormal];
        
    }
    
}

-(void)setPageView:(UIScrollView *)pageView{
    
    _pageView=pageView;
    @weakify(self);
    [RACObserve(pageView, contentOffset) subscribeNext:^(id x) {
       
        if (x) {
            @strongify(self);
            CGPoint pos=[x CGPointValue];
            
            [self.selectorView setFrame:CGRectMake(pos.x/self.segmetsCount, self.frame.size.height-2-self.selectorOfsset,self.frame.size.width/self.segmetsCount, 2)];
            
            
            float k = self.frame.size.width/self.buttonsArray.count;
            float px=pos.x/self.segmetsCount;
            
     
            
            NSInteger sIdx=roundf(px/k);
                           for (UIButton * b in self.buttonsArray) {
                if (b.tag!=sIdx) {
                    b.selected=NO;
                }else{
                    b.selected=YES;
                }
            }
            
        }
        
    }];
    
}

@end
