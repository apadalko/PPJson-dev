//
//  PPGridCellView.m
//  PPGMPersonaGridView
//
//  Created by Alex Padalko on 2/21/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPGridCellView.h"

#import "PPGridCellChatBubleView.h"

@interface PPGridCellView () <PPGridCellObjectTextDelegate>



@end
@implementation PPGridCellView
-(instancetype)initWithGridCellObject:(PPGridCellObject *)cellObject{
    if (self==[super init]) {
        self.cellObject=cellObject;
        
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(void)setCellObject:(PPGridCellObject *)cellObject{
    _cellObject=cellObject;
    
    
    [_cellObject setDelegate:self];
    
}

-(void)sayText:(NSString*)text removeAfter:(float)delay directiom:(NSInteger)direction{
    
    
    PPGridCellChatBubleView * cb =[[PPGridCellChatBubleView alloc] initWithText:text];
    
    
    [cb sizeToFit];
    
    
    [self addSubview:cb];
    if (direction==0) {
            [cb setFrame:CGRectMake(-cb.frame.size.width+4, self.frame.size.height*0.84-cb.frame.size.height, cb.frame.size.width, cb.frame.size.height)];
    }else{
   
           [cb setFrame:CGRectMake(self.frame.size.width-4, self.frame.size.height*0.84-cb.frame.size.height, cb.frame.size.width, cb.frame.size.height)];
             [cb rotatebubble];
    }

    
    cb.transform=CGAffineTransformMakeScale(.1, .1);
    [cb setAlpha:0.0];
    
//    [UIView animateWithDuration:0.33 animations:^{
//      
//    }];
    
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        cb.transform=CGAffineTransformMakeScale(1.0, 1.0);
          [cb setAlpha:1.0];
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(ns:) withObject:cb afterDelay:delay];
  
    }];
    
    
}
-(void)ns:(UIView*)cb{
    [UIView animateWithDuration:0.3  animations:^{
        [cb setAlpha:0];
//        cb.transform=CGAffineTransformMakeScale(.0, .0);
    } completion:^(BOOL finished) {
        
        [cb removeFromSuperview];
        
    }];
}
@end
