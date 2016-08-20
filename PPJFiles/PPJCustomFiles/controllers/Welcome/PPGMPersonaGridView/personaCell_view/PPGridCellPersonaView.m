//
//  PPGridCellPersonaView.m
//  PPGMPersonaGridView
//
//  Created by Alex Padalko on 2/21/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//
#import <FLAnimatedImage/FLAnimatedImage.h>
#import "PPGridCellPersonaView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface PPGridCellPersonaView ()

@property (nonatomic,retain)FLAnimatedImageView * personaImageView;
@end
@implementation PPGridCellPersonaView
@dynamic cellObject;
-(instancetype)initWithGridCellObject:(PPGridCellPersonaObject *)cellObject{
    
    if (self=[super initWithGridCellObject:cellObject]) {
        
        
        NSData * d = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.cellObject.personaGifName ofType:@"gif"]];
        FLAnimatedImage *image = [[FLAnimatedImage alloc] initWithAnimatedGIFData:d optimalFrameCacheSize:5 predrawingEnabled:NO];
        
        self.personaImageView  = [[FLAnimatedImageView alloc] init];
        self.personaImageView.animatedImage = image;
        [self.personaImageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.personaImageView];
    }
    return self;
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.personaImageView setFrame:self.bounds];
}
-(void)setstaticUser:(id<PPUserProt>)user{
    
    [self.personaImageView stopAnimating];
    
    [self.personaImageView sd_setImageWithURL:[NSURL URLWithString:[user profilePictureThumbUrlStr]] placeholderImage:[UIImage imageNamed:@"gm_user_large"]];
    
    self.personaImageView.layer.cornerRadius=self.personaImageView.frame.size.height/2;
    [self.personaImageView setClipsToBounds:YES];
    
    
}
@end
