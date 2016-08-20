//
//  PPGridAnimationObject.h
//  PPGMPersonaGridView
//
//  Created by Alex Padalko on 2/20/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPGridAnimationObject : NSObject
+(instancetype)createWithPoints:(NSArray*)points andDelayFrames:(int)delayFrames;

@property (nonatomic,retain)NSArray * points;
@property (nonatomic)int delayFrames;
@property (nonatomic)NSInteger drawingProcess;
@end
