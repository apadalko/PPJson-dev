//
//  PPGridCellPersonaView.m
//  Gabbermap
//
//  Created by Alex Padalko on 2/22/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGridCellUserView.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface PPGridCellUserView ()

@property (nonatomic,retain)UIImageView * userImageView;

@end
@implementation PPGridCellUserView

@dynamic cellObject;

-(instancetype)initWithGridCellObject:(PPGridCellUserObject *)cellObject{
    
    if (self=[super initWithGridCellObject:cellObject]) {
        
    }
    return self;
}
-(UIImageView *)userImageView{
    if (!_userImageView) {
       _userImageView=[[UIImageView alloc] init];
        [self addSubview:_userImageView];
        
        [_userImageView setClipsToBounds:YES];
    }
    return _userImageView;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    float w = self.frame.size.width*0.9;
    [self.userImageView setFrame:CGRectMake(self.frame.size.width/2-w/2, self.frame.size.height/2-w/2, w, w)];
    self.userImageView.layer.cornerRadius=self.userImageView.frame.size.height/2;
    
}

-(void)setCellObject:(PPGridCellUserObject *)cellObject{
    [super setCellObject:cellObject];
    
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:[[cellObject user] profilePictureThumbUrlStr]] placeholderImage:[UIImage imageNamed:@"gm_user_large"]];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
