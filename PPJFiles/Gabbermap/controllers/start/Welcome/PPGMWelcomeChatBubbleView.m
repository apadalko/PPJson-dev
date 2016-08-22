//
//  PPGMChatBubbleView.m
//  Gabbermap
//
//  Created by Alex Padalko on 6/2/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGMWelcomeChatBubbleView.h"

@interface PPGMWelcomeChatBubbleView ()

@property (nonatomic) PPGMChatBubbleDirection direction;
@property (nonatomic, strong) UIBezierPath *bezierPath;
@end
@implementation PPGMWelcomeChatBubbleView

-(instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self=[super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.contentViewInsets=UIEdgeInsetsMake(10, 10, 10, 10);
       
    }
    return self;
}

-(void)showFromPoint:(CGPoint)point withDirection:(PPGMChatBubbleDirection)direction removeAfter:(float)removeAfter{
    

    CGPoint origin;
    switch (direction) {
        case PPGMChatBubbleDirectionLeft:{
            
            origin=CGPointMake(point.x, point.y-self.frame.size.height/2);
            
            CGFloat inset = 10.0f ;
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:(CGPoint){ inset+3, self.frame.size.height/2-inset }];
            [bezierPath addLineToPoint:(CGPoint){ 0+3, self.frame.size.height/2 }];
            [bezierPath addLineToPoint:(CGPoint){ inset+3, self.frame.size.height/2+inset }];
            [bezierPath closePath];
            
            self.bezierPath = bezierPath;
            
            
            
        }
            
            break;
        case PPGMChatBubbleDirectionRight:
            
        {
            origin=CGPointMake(point.x-self.frame.size.width, point.y-self.frame.size.height/2);
            
            CGFloat inset = 10.0f ;
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:(CGPoint){ self.frame.size.width -(inset+3) ,self.frame.size.height/2-inset }];
            [bezierPath addLineToPoint:(CGPoint){ self.frame.size.width-3, self.frame.size.height/2 }];
            [bezierPath addLineToPoint:(CGPoint){ self.frame.size.width+-(inset+3), self.frame.size.height/2+inset }];
            [bezierPath closePath];
            
            self.bezierPath = bezierPath;
        }
            
            break;
        case PPGMChatBubbleDirectionTop:{
            
           
            origin=self.frame.origin;
            CGFloat inset = 10.0f ;
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:(CGPoint){point.x-inset, self.frame.size.height-inset -3}];
            [bezierPath addLineToPoint:(CGPoint){ point.x, self.frame.size.height -3 }];
            [bezierPath addLineToPoint:(CGPoint){ point.x+inset,self.frame.size.height-inset -3}];
            [bezierPath closePath];
            
            self.bezierPath = bezierPath;
            
        }
            
            break;
        case PPGMChatBubbleDirectionBottom:{
            
            
            origin=self.frame.origin;
            CGFloat inset = 10.0f ;
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:(CGPoint){point.x-inset, inset +3}];
            [bezierPath addLineToPoint:(CGPoint){ point.x, 3 }];
            [bezierPath addLineToPoint:(CGPoint){ point.x+inset,inset +3}];
            [bezierPath closePath];
            
            self.bezierPath = bezierPath;
        }
            
            break;
        default:
            break;
    }
 
    [self setFrame:CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height)];
    

    
    
    

      self.transform=CGAffineTransformMakeScale(.0, .0);
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform=CGAffineTransformMakeScale(1.0, 1.0);
        [self setAlpha:1.0];
    } completion:^(BOOL finished) {
        if (removeAfter>0) {
                [self performSelector:@selector(ns) withObject:nil afterDelay:removeAfter];
        }
    
        
    }];
    
    
}
-(void)ns{
    [UIView animateWithDuration:0.3  animations:^{
        [self setAlpha:0];
        //        cb.transform=CGAffineTransformMakeScale(.0, .0);
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}
-(void)layoutSubviews{
    
    [self.contentView setFrame:UIEdgeInsetsInsetRect(self.bounds, self.contentViewInsets)];
}

-(UIView *)contentView{
    if (!_contentView) {
        _contentView=[[UIView alloc] init];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        _contentView.layer.cornerRadius=12.0;
        [self addSubview:_contentView];
    }
    return _contentView;
}

-(void)drawRect:(CGRect)rect{
    
    
   
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGColorRef col = [self.contentView backgroundColor].CGColor;
    CGColorRef bcol = [self.contentView backgroundColor].CGColor;
    CGContextSetFillColorWithColor(c, col);
    CGContextSetStrokeColorWithColor(c, bcol);
    CGContextSetLineWidth(c, 4);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    CGContextSetLineCap(c, kCGLineCapRound);
    CGContextAddPath(c, self.bezierPath.CGPath);
    CGContextStrokePath(c);
    CGContextAddPath(c, self.bezierPath.CGPath);
    CGContextFillPath(c);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
