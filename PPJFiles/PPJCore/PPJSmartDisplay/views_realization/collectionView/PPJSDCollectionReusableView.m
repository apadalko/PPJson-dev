//
//  PPJSDCollectionReusableView.m
//  Blok
//
//  Created by Alex Padalko on 10/21/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "PPJSDCollectionReusableView.h"

@implementation PPJSDCollectionReusableView

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.displayView setFrame:self.bounds];
}
-(void)setDisplayView:(UIView *)displayView{
    
    if (_displayView) {
        [_displayView removeFromSuperview];
    }
    
    _displayView=displayView;
    
    [self addSubview:_displayView];
    
    
}
@end
