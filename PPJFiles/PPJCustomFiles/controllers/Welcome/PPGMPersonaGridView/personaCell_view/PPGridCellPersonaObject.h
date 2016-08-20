//
//  PPGridCellPersonaObject.h
//  PPGMPersonaGridView
//
//  Created by Alex Padalko on 2/21/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPGridCellObject.h"
@interface PPGridCellPersonaObject : PPGridCellObject
-(instancetype)initWithGridPoint:(CGPoint)gridPoint andPersonaGifName:(NSString*)personaGifName;
@property (nonatomic,retain)UIImageView * personaGifName;


@end
