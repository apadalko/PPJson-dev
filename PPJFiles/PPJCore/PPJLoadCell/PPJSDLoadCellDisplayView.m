//
//  PPJSDLoadCellDisplayView.m
//  Gabbermap
//
//  Created by Alex Padalko on 1/12/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPJSDLoadCellDisplayView.h"
#import "UIColor+HEX.h"
@interface PPJSDLoadCellDisplayView ()
        @property (nonatomic,retain)UIActivityIndicatorView * loadingView;

@end

@implementation PPJSDLoadCellDisplayView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        

        self.loadingView=[[UIActivityIndicatorView alloc] init];
        [self.loadingView setColor:[UIColor blackColor]];
        [self.loadingView setFrame:CGRectMake(0, 0, 44, 44)];
        [self addSubview:self.loadingView];
        
    }
    return self;
}

-(void)setLoadState:(PPJSDLoadStateType)loadState{
    _loadState=loadState;
    
    if (self.loadState==PPJSDLoadStateTypeNone||self.loadState==PPJSDLoadStateTypeFail) {
        [self.loadingView stopAnimating];
        [self.loadingView setHidden:YES];
    }
    else{
        [self.loadingView startAnimating];
        [self.loadingView setHidden:NO];
    }
 
}
@end
