//
//  PPJSDTableViewHeaderFooterView.m
//  Blok
//
//  Created by Alex Padalko on 9/27/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "PPJSDTableViewHeaderFooterView.h"

@implementation PPJSDTableViewHeaderFooterView

-(void)setDisplayView:(UIView *)displayView{
    
    if (_displayView) {
        [_displayView removeFromSuperview];
    }
    
    _displayView=displayView;
    
    [self addSubview:_displayView];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_displayView setFrame:self.bounds];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
