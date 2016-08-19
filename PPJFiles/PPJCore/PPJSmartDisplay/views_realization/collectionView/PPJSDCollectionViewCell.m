//
//  PPJSDCollectionViewCell.m
//  Blok
//
//  Created by Alex Padalko on 9/27/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "PPJSDCollectionViewCell.h"

@implementation PPJSDCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
    }
    return self;
}
-(void)setDisplayView:(UIView<PPJDisplayViewProt> *)displayView{
    
    if (_displayView) {
        [_displayView removeFromSuperview];
    }
    
    _displayView=displayView;
    
    [self addSubview:_displayView];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_displayView setFrame:CGRectMake(_displayView.contentInset.left, self.displayView.contentInset.top, self.frame.size.width-self.displayView.contentInset.right-self.displayView.contentInset.left, self.frame.size.height-self.displayView.contentInset.top-self.displayView.contentInset.bottom)];
}
@end
