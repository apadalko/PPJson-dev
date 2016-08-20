//
//  PPGMPersonaGridView.m
//  PPGMPersonaGridView
//
//  Created by Alex Padalko on 2/20/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//
#import "PPGridBackgroundView.h"
#import "PPGridView.h"
#import <MapKit/MapKit.h>
#import "UIColor+HEX.h"
@interface PPGridView ()
@property (nonatomic,retain) UIImageView * bakgroundImageView;
@property (nonatomic,retain) PPGridBackgroundView * backgroundView;
@property (nonatomic,retain) CAGradientLayer * alphaGradientLayer;

@property (nonatomic,retain)NSMutableArray * cellsObjects;
@property (nonatomic,retain)NSMutableArray * cellsViews;

@end
@implementation PPGridView

-(instancetype)initWithGridSize:(CGSize)size{
    if (self=[super initWithFrame:CGRectZero]) {
        
        self.bakgroundImageView=[[UIImageView alloc] init];
        [self.bakgroundImageView setAlpha:0];
        [self addSubview:self.bakgroundImageView];
        
        self.alphaGradientLayer = [CAGradientLayer layer];
        NSArray *colors = [NSArray arrayWithObjects:
                           (id)[[UIColor colorWithWhite:0 alpha:0] CGColor],
                           (id)[[UIColor colorWithWhite:0 alpha:1.0] CGColor],
                           
                           nil];
        [ self.alphaGradientLayer setColors:colors];
        
        // Start the gradient at the bottom and go almost half way up.
        [ self.alphaGradientLayer setStartPoint:CGPointMake(0.0f, 0.0f)];
        [ self.alphaGradientLayer setEndPoint:CGPointMake(0.0f, .5f)];
        
//        [self.bakgroundImageView.layer setMask:self.alphaGradientLayer];
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setClipsToBounds:NO];
        self.gridSize=size;
        
        [self.bakgroundImageView setImage:[[UIImage imageNamed:@"gm_intromap"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        [self.bakgroundImageView setTintColor:[UIColor colorFromHexString:@"2ccdc8"]];
    }
    return self;
}

-(void)addGridCellObject:(id)gridCellObject{
    [self.cellsObjects addObject:gridCellObject];
}
-(void)addGridCellObject:(PPGridCellObject*)gridCellObject andPresent:(void(^)())complitBlock{
    [self.cellsObjects addObject:gridCellObject];
    
    PPGridCellView * v = [self.delegate gv_gridCellViewFormObject:gridCellObject];
    gridCellObject.representation=v;
    [self.cellsViews addObject:v];
   
    
    [self _presentingArray:[@[v] mutableCopy] withComplitBlock:complitBlock];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.blockSize = CGSizeMake((self.frame.size.width-(self.gridSize.width-1)*2)/self.gridSize.width, (self.frame.size.height-(self.gridSize.height-1)*2)/self.gridSize.height);
    self.blockSize=CGSizeMake(MIN( self.blockSize.width,  self.blockSize.height), MIN( self.blockSize.width,  self.blockSize.height));
    [self.bakgroundImageView setFrame:self
     .bounds];
    
    CGSize bkgrSize = CGSizeMake(self.blockSize.width*self.gridSize.width+(self.gridSize.width-1)*2, self.blockSize.height*self.gridSize.height+(self.gridSize.height-1)*2);
    [self.backgroundView setFrame:CGRectMake(self.frame.size.width/2-bkgrSize.width/2, self.frame.size.height/2-bkgrSize.height/2, bkgrSize.width, bkgrSize.height)];
    
    [self.alphaGradientLayer setFrame:[self
                                       bounds]];
}


-(void)showGridWithAnimation:(BOOL)withAnimation complitBlock:(void(^)())complitBlock{

    
    if (withAnimation) {
        self.inAnimation=YES;
        

        [self.backgroundView drawGridWithSize:self.gridSize withAnimationSequence:[self.animationDelegate gva_gridApperanceAnimationSequence] frameRate:0.1 andComplitBlock:^{
            
        
            NSMutableArray * cellsToPresent  = [[NSMutableArray alloc] init];
            
            
            for (PPGridCellObject * obj in self.cellsObjects) {
                
                PPGridCellView * v = [self.delegate gv_gridCellViewFormObject:obj];
                obj.representation=v;
                [self.cellsViews addObject:v];
                [cellsToPresent addObject:v];
            }
            
            
            if ([self shouldShowBakgroundImage]) {
                
                
             
                [UIView animateWithDuration:0.33*cellsToPresent.count   animations:^{
                    [self.bakgroundImageView setAlpha:1.0];
                } completion:^(BOOL finished) {
                    
                }];
                
            }
                
                
                [self _presentingArray:cellsToPresent withComplitBlock:^{
                    self.inAnimation=NO;
                    
                    complitBlock();
                    
                    
                    
                    
                    
                    self.initialApperiance=YES;
                }];
            
     
            
        
            
        }];
        
    }
    
}
-(void)refreshObject:(id)obj{
    
}

-(void)refreshObject:(PPGridCellObject*)object complitBlock:(void(^)())complitBlock{
    
    
    
    
    
    [UIView animateWithDuration:0.33 animations:^{
    
        [object.representation setAlpha:0];
        object.representation.transform=CGAffineTransformMakeScale(0.8, 0.8);
        
    }completion:^(BOOL finished) {
        
        [object.representation removeFromSuperview];
        [self.cellsViews removeObject:object.representation];
        PPGridCellView * v = [self.delegate gv_gridCellViewFormObject:object];
        object.representation=v;
        [self.cellsViews addObject:v];
        
        
        CGSize cellSize = CGSizeMake(self.frame.size.width/self.gridSize.width, self.frame.size.height/self.gridSize.height);
        [v setFrame:CGRectMake(v.cellObject.gridPoint.x*cellSize.width, v.cellObject.gridPoint.y*cellSize.height, cellSize.width, cellSize.height)];
        [self addSubview:v];
        
        
        v.transform=CGAffineTransformMakeScale(.8, .8);
        
        [UIView animateWithDuration:0.33 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
              v.transform=CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            
            complitBlock();
            
        }];
        
    }];
    
  
    
}
-(void)reloadData{
    
}
-(void)_presentingArray:(NSMutableArray*)arr withComplitBlock:(void(^)())complitBlock{
    
    if (arr.count>0) {
      __block  PPGridCellView * v = [arr objectAtIndex:0];
        [arr removeObjectAtIndex:0];
        
        CGSize cellSize = self.blockSize;
        float offsetX = self.frame.size.width-self.backgroundView.frame.size.width;
        float offsetY = self.frame.size.height-self.backgroundView.frame.size.height;
        [v setFrame:CGRectMake(v.cellObject.gridPoint.x*cellSize.width+v.cellObject.gridPoint.x*2+offsetX/2, v.cellObject.gridPoint.y*cellSize.height+v.cellObject.gridPoint.y*2+offsetY/2, cellSize.width, cellSize.height)];
        [self addSubview:v];
        
        
        v.transform=CGAffineTransformMakeScale(.8, .8);
        
        [UIView animateWithDuration:0.2 animations:^{
                    v.transform=CGAffineTransformMakeScale(1.1, 1.1);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                v.transform=CGAffineTransformMakeScale(1.0, 1.0);
            }completion:^(BOOL finished) {
            }];
            
            [self _presentingArray:arr withComplitBlock:complitBlock];

        }];
        
        
        
    }else{
        complitBlock();
    }
    

    
    
    
    
    
}






-(NSMutableArray *)cellsObjects{
    if (!_cellsObjects) {
        _cellsObjects=[[NSMutableArray alloc] init];
    }
    return _cellsObjects;
}
-(PPGridBackgroundView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView=[[PPGridBackgroundView alloc] init];
        [self addSubview:_backgroundView];
    }
    return _backgroundView;
}



@end
