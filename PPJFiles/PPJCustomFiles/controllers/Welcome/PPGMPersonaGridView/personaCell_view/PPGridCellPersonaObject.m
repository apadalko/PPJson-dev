//
//  PPGridCellPersonaObject.m
//  PPGMPersonaGridView
//
//  Created by Alex Padalko on 2/21/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPGridCellPersonaObject.h"


@interface PPGridCellPersonaObject ()

@end
@implementation PPGridCellPersonaObject
-(instancetype)initWithGridPoint:(CGPoint)gridPoint andPersonaGifName:(NSString *)personaGifName{
    
    if (self=[super initWithGridPoint:gridPoint ]) {
        self.personaGifName=personaGifName;
        
    }
    return self;
}

@end
