//
//  PPGMWelcomeChatTextBubbleView.m
//  Gabbermap
//
//  Created by Alex Padalko on 6/2/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGMWelcomeChatTextBubbleView.h"
#import "UIFont+AppFonts.h"
@interface PPGMWelcomeChatTextBubbleView ()

@property (nonatomic,retain)UILabel * textLabel;

@end
@implementation PPGMWelcomeChatTextBubbleView


-(void)setText:(NSString *)text{
    
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:text attributes:@{
                                                                                                          
                                                                                                          
                                                                                                          
                                                                                                          }];
    
    [str ppj_findAndSelect:@"@" color:[UIColor colorFromHexString:@"4d4d4d"] font:[UIFont muesoRounded900WithSize:15] removeFinder:NO];
        [str ppj_findAndSelect:@"#" color:[UIColor colorFromHexString:@"4d4d4d"] font:[UIFont muesoRounded900WithSize:15] removeFinder:YES];
    
    
    [self setAttrString:str];
}
-(void)setAttrString:(NSAttributedString *)attrString{
    _attrString=attrString;
    
    [self.textLabel setAttributedText:attrString];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.textLabel setFrame:CGRectMake(10, 5, self.contentView.frame.size.width-15, self.contentView.frame.size.height-10)];
}

-(UILabel *)textLabel{
    if(!_textLabel){
        _textLabel=[[UILabel alloc] init];
        
        [_textLabel setTextAlignment:NSTextAlignmentLeft];
        [_textLabel setNumberOfLines:2];
        [_textLabel setTextColor:[UIColor colorFromHexString:@"4d4d4d"]];
        [_textLabel setFont:[UIFont muesoRounded500WithSize:15]];
        [self.contentView addSubview:_textLabel];
        
    }
    return _textLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
