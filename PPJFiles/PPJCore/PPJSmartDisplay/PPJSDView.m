//
//  PPJSDView.m
//  Blok
//
//  Created by Alex Padalko on 9/27/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "PPJSDView.h"

@implementation PPJSDView
@synthesize baseViewDelegate=_baseViewDelegate;
@synthesize parentView=_parentView;
@synthesize contentInset=_contentInset;

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        [self setClipsToBounds:YES];
        
        self.contentInset=UIEdgeInsetsZero;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    


}
-(void)setValueContentInsets:(NSValue *)valueContentInsets{
    self.contentInset=[valueContentInsets UIEdgeInsetsValue];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
