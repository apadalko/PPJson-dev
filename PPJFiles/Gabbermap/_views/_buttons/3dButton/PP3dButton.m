//
//  PP3dButton.m
//  Blok
//
//  Created by Alex Padalko on 12/11/15.
//  Copyright © 2015 com.placepixel. All rights reserved.
//

#import "PP3dButton.h"
@interface PP3dButton ()


@property (nonatomic,retain)UIView * topView;
@property (nonatomic)float offset;


@end
@implementation PP3dButton

+(instancetype)buttonWithColor:(UIColor*)buttonColor andTitle:(NSString*)title{
    
    PP3dButton * but=[self buttonWithColor:buttonColor];
    [but setTitle:title forState:UIControlStateNormal];
    
    return but;
}
+(instancetype)buttonWithColor:(UIColor*)buttonColor andTitle:(NSString*)title andFont:(UIFont*)font{
    PP3dButton * but=[self buttonWithColor:buttonColor andTitle:title];
    but.titleLabel.font=font;
    
    return but;
}

+(instancetype)buttonWithColor:(UIColor *)buttonColor{
    
    
    PP3dButton * but=[PP3dButton new];
    [but setup];
    but.buttonColor=buttonColor;
    
    return but;
    
}
- (void)setBackgroundColor:(UIColor *)backgroundColor {

}
-(void)setButtonColor:(UIColor *)buttonColor{
    [self setBackgroundColor:[self darkerColorFromColor:buttonColor percent:0.9]];
    [self.topView setBackgroundColor:buttonColor];
}

-(void)setup{
    _offset=3;
    [self setClipsToBounds:YES];
    [self addTarget:self action:@selector(a) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(b) forControlEvents:UIControlEventTouchDragOutside];
    [self addTarget:self action:@selector(a) forControlEvents:UIControlEventTouchDragInside];
    [self.layer setCornerRadius:8.0f];
}
-(void)a{

    self.highlighted=YES;
}
-(void)b{
    self.highlighted=NO;
}

//-(UIView *)bottomView{
//    
//    if (!_bottomView) {
//        _bottomView=[[UIView alloc] init];
//        [_bottomView setUserInteractionEnabled:NO];
//        [self addSubview:_bottomView];
//    }
//    return _bottomView;
//}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGRect r = [super titleRectForContentRect:contentRect];
    r.origin.y-=self.offset/2.0;
//    r.size.height-=self.offset;
    return r;
    
}
-(UIView *)topView{
    
    if (!_topView) {
        _topView=[[UIView alloc] init];
       [_topView.layer setCornerRadius:8.0f];
        [_topView setUserInteractionEnabled:NO];
        [self addSubview:_topView];
    }
    return _topView;
}
-(void)setOffset:(float)offset{
    _offset=offset;
    [self.topView setFrame:CGRectMake(0, -self.offset, self.frame.size.width, self.frame.size.height)];

}
-(void)setHighlighted:(BOOL)highlighted{
    
    if (self.highlighted!=highlighted) {
        [super setHighlighted:highlighted];
        self.offset=highlighted?0:3;
    }

    
}
-(void)setCustomOverlayView:(UIView *)customOverlayView{
    if (_customOverlayView) {
        [_customOverlayView removeFromSuperview];
    }
    
    _customOverlayView=customOverlayView;
    [_customOverlayView setUserInteractionEnabled:NO];
    [self addSubview:customOverlayView];
}
-(void)layoutSubviews{
    
    
    [super layoutSubviews];
    
    
    [self.topView setFrame:CGRectMake(0, -self.offset, self.frame.size.width, self.frame.size.height)];
   
    [self.customOverlayView setFrame:self.topView.frame];
//    [_bottomView setFrame:self.bounds];
    
}
- (UIColor *)darkerColorFromColor:(UIColor*)color percent:(float)percent

{
    CGFloat h, s, b, a;
    if ([color getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b * percent
                               alpha:a];
    return [UIColor clearColor];
}
@end
