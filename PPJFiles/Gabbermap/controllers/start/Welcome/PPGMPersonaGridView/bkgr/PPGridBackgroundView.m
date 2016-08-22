//
//  PPGMPersonaGridBackgroundView.m
//  PPGMPersonaGridView
//
//  Created by Alex Padalko on 2/20/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPGridBackgroundView.h"
@interface PPGridBackgroundView ()
{
    CAGradientLayer *alphaGradientLayer;
}
@property (nonatomic,retain)NSTimer * animTimer;
@property (nonatomic,retain)NSArray * animSequence;
@property (nonatomic)NSInteger currentAnimationStep;
@property (nonatomic)NSInteger waitingSteps;
@property (nonatomic)CGSize gridSize;
@property (nonatomic)BOOL animating;
@property (nonatomic)BOOL presented;
@property (nonatomic)CADisplayLink *displayLink ;

@property (nonatomic)NSInteger totalFramesCount;

@property (nonatomic,copy)gvbd_complitBlock complitBlock;

@end
@implementation PPGridBackgroundView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        
       alphaGradientLayer = [CAGradientLayer layer];
        NSArray *colors = [NSArray arrayWithObjects:
                                  (id)[[UIColor colorWithWhite:0 alpha:1] CGColor],
                           (id)[[UIColor colorWithWhite:0 alpha:0.3] CGColor],
                    
                           nil];
        [alphaGradientLayer setColors:colors];
        
        // Start the gradient at the bottom and go almost half way up.
        [alphaGradientLayer setStartPoint:CGPointMake(0.0f, 0.0f)];
        [alphaGradientLayer setEndPoint:CGPointMake(0.0f, 1.0f)];
     
//        [[self layer] setMask:alphaGradientLayer];
    }
    return self;
}


-(void)drawGridWithSize:(CGSize)size withAnimationSequence:(NSArray<PPGridAnimationObject *> *)animationSequence frameRate:(NSInteger)frameRate andComplitBlock:(void (^)())complitBlock{
    self.animating=YES;
    self.gridSize=size;
    self.animSequence=animationSequence;
    self.currentAnimationStep=0;
    
    [alphaGradientLayer setStartPoint:CGPointMake(0.0f, 0.0f)];
    [alphaGradientLayer setEndPoint:CGPointMake(0.0f, 1.0f-(1.0/self.gridSize.height *2 ))];
    
    self.waitingSteps=0;
//   self.animTimer= [NSTimer scheduledTimerWithTimeInterval:frameRate target:self selector:@selector(updateView) userInfo:nil repeats:YES];
    self.totalFramesCount=0;
    for (PPGridAnimationObject * obj in self.animSequence) {
        self.totalFramesCount+=obj.delayFrames;
        self.totalFramesCount++;
    }
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateView)];
    _displayLink.frameInterval=2;
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.complitBlock=complitBlock;
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
       [alphaGradientLayer setFrame:[self
                                     bounds]];
}
-(void)updateView{
   
   
    if (self.currentAnimationStep<self.animSequence.count) {
        PPGridAnimationObject * obj =[self.animSequence objectAtIndex:self.currentAnimationStep];
        
        float p = (float)self.totalFramesCount/52.0;
        p=0.2+ p*0.8;
    
        NSArray *colors = [NSArray arrayWithObjects:
                           (id)[[UIColor colorWithWhite:0 alpha:p] CGColor],
                           (id)[[UIColor colorWithWhite:0 alpha:1] CGColor],
                           
                           
                           nil];
        [alphaGradientLayer setColors:colors];
        if (obj.delayFrames>0) {
            obj.delayFrames--;
        }else{
             self.currentAnimationStep++;
        }
        self.totalFramesCount--;
        [self setNeedsDisplay];
    }else{
 
        self.animating=NO;
        self.presented=YES;
        [_displayLink invalidate];
        NSArray *colors = [NSArray arrayWithObjects:
                           (id)[[UIColor colorWithWhite:0 alpha:0.2] CGColor],
                           (id)[[UIColor colorWithWhite:0 alpha:1] CGColor],
                           
                           
                           nil];
        [alphaGradientLayer setColors:colors];
        
        [self setNeedsDisplay];
        
        
        
        [self performSelector:@selector(w) withObject:nil afterDelay:0.03];
    }
    
    
    
    
    
  
    
}
-(void)w{
    if (self.complitBlock) {
         self.complitBlock();
    }
   
//  [self drawGridWithSize:self.gridSize withAnimationSequence:self.animSequence frameRate:0 andComplitBlock:nil];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGSize blockSize = CGSizeMake((rect.size.width-(self.gridSize.width-1)*2)/self.gridSize.width, (rect.size.height-(self.gridSize.height-1)*2)/self.gridSize.height);
    blockSize=CGSizeMake(MIN(blockSize.width, blockSize.height), MIN(blockSize.width, blockSize.height));
    if (self.animating) {
        

        CGContextRef context = UIGraphicsGetCurrentContext();
         CGContextSetRGBFillColor(context, 16.0/255.0, 214.0/255.0, 210.0/255.0, 0 );
        for (NSInteger a = 0 ; a<self.currentAnimationStep; a++) {
            if (a>=self.animSequence.count) {
                return;
            }
            PPGridAnimationObject * obj =[self.animSequence objectAtIndex:a];
            obj.drawingProcess++;

            for (NSValue * val  in obj.points) {
                CGPoint p = [val CGPointValue];
                CGContextSetRGBStrokeColor(context, 255.0/255.0,255.0/255.0,255.0/255.0,0.3*obj.drawingProcess);
               
                
                
                [self drawRoundedRect:CGRectMake(p.x*blockSize.width+2.0*p.x, p.y*blockSize.height+2.0*p.y, blockSize.width, blockSize.height) andLineWidth:3 andRaious:6 DrawingMode:kCGPathFillStroke andContext:context];
            }
        }
    }else if (self.presented){
   
        CGContextRef context = UIGraphicsGetCurrentContext();
      
        CGContextSetRGBFillColor(context, 16.0/255.0, 214.0/255.0, 210.0/255.0, 0 );
        CGContextSetRGBStrokeColor(context, 255.0/255.0,255.0/255.0,255.0/255.0,0.6);
     
        for (int x = 0 ; x<self.gridSize.width; x++) {
            for (int y = 0 ; y<self.gridSize.height; y++) {
             
                
                 [self drawRoundedRect:CGRectMake(x*blockSize.width+2.0*x, y*blockSize.height+2.0*y, blockSize.width, blockSize.height) andLineWidth:3 andRaious:6 DrawingMode:kCGPathFillStroke andContext:context];
                
            }
        }

        
    }

    


    
}
-(void)drawRoundedRect:(CGRect)rect andLineWidth:(float)lineWidth andRaious:(float)radius DrawingMode:(CGPathDrawingMode)drawMode andContext:(CGContextRef)context{
    
    
    
    CGContextSetLineWidth(context,lineWidth);
    
    
    CGRect rrect = CGRectInset(rect, lineWidth/2, lineWidth/2);
    
    CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
    
    
    CGContextMoveToPoint(context, minx, midy);
    // Add an arc through 2 to 3
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    // Add an arc through 4 to 5
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    // Add an arc through 6 to 7
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    // Add an arc through 8 to 9
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
    // Close the path
    CGContextClosePath(context);
    // Fill & stroke the path
    //        CGContextDrawPath(context, kCGPathFillStroke);
    CGContextDrawPath(context, drawMode);
}
@end
