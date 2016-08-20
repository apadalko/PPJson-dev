//
//  PPGridCellChatBubleView.m
//  Gabbermap
//
//  Created by Alex Padalko on 2/22/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//
//#import "UIFont+AppFonts.h"
#import "PPGridCellChatBubleView.h"
//#import "APTextHelper.h"
@interface PPGridCellChatBubleView ()

@property (nonatomic,retain)UILabel * textLabel;
@property (nonatomic,retain)UIImageView * bakgroundView;

@end
@implementation PPGridCellChatBubleView

-(instancetype)initWithText:(NSString *)text{
    
    if (self=[super initWithFrame:CGRectZero]) {
        
        
        UIEdgeInsets resizeInset=UIEdgeInsetsMake(21, 16, 25, 24);
        self.bakgroundView=[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"gm_textbubble"] resizableImageWithCapInsets:resizeInset resizingMode:UIImageResizingModeStretch]];
        
        [self addSubview:self.bakgroundView];
        [self setBackgroundColor:[UIColor clearColor]];
        self.text=text;
        
        self.textLabel=[[UILabel alloc] init];
        
        NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:text attributes:@{
                                                                                                              
//                                                                                                              NSFontAttributeName:[UIFont muesoRounded500WithSize:17]
                                                                                                              }];
        
        
//        [str findwithFinders:@[@"#"] andHexColor:@"000000" andFont:[UIFont muesoRounded700WithSize:17] removeFinder:NO];
        [self.textLabel setAttributedText:str];
        
//        [self.textLabel setText:text];
        
//        [self.textLabel setFont:[UIFont muesoRounded700WithSize:19]];
        [self.textLabel setTextColor:[UIColor blackColor]];
        
        [self addSubview:self.textLabel];
        


    }
    return self;
}
-(void)rotatebubble{
    self.bakgroundView.transform=CGAffineTransformMakeScale(-1.0, 1.0);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.textLabel setFrame:CGRectMake(((self.frame.size.width-2)/2)-self.textLabel.frame.size.width/2, (self.frame.size.height-3)/2-self.textLabel.frame.size.height/2, self.textLabel.frame.size.width, self.textLabel.frame.size.height)];
    
    [self.bakgroundView setFrame:self.bounds];
}
-(void)sizeToFit{
    
    
    [self.textLabel sizeToFit];
    
    [self setFrame:CGRectMake(0, 0, self.textLabel.frame.size.width+32, 42)];
    
}


@end
