//
//  PPGMPersonaGridBackgroundView.h
//  PPGMPersonaGridView
//
//  Created by Alex Padalko on 2/20/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPGridAnimationObject.h"
typedef void(^gvbd_complitBlock)();
@interface PPGridBackgroundView : UIView

-(void)drawGridWithSize:(CGSize)size withAnimationSequence:(NSArray<PPGridAnimationObject*>*)animationSequence frameRate:(NSInteger)frameRate andComplitBlock:(void(^)())complitBlock;
@end
