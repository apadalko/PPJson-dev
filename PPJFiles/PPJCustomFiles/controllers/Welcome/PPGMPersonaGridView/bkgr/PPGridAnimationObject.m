//
//  PPGridAnimationObject.m
//  PPGMPersonaGridView
//
//  Created by Alex Padalko on 2/20/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPGridAnimationObject.h"

@implementation PPGridAnimationObject
+(instancetype)createWithPoints:(NSArray *)points andDelayFrames:(int)delayFrames{
    
    PPGridAnimationObject * obj =[[PPGridAnimationObject alloc] init];
    obj.drawingProcess=0;
    obj.points=points;
    obj.delayFrames=delayFrames;
    return obj;
    
}
-(void)setDrawingProcess:(NSInteger)drawingProcess{
    _drawingProcess=MIN(2, drawingProcess);
}
@end
