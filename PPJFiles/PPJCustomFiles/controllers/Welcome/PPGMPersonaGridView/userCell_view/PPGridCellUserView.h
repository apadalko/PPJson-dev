//
//  PPGridCellPersonaView.h
//  Gabbermap
//
//  Created by Alex Padalko on 2/22/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGridCellView.h"
#import "PPGridCellUserObject.h"

@interface PPGridCellUserView : PPGridCellView
-(instancetype)initWithGridCellObject:(PPGridCellUserObject *)cellObject;
@property (nonatomic,retain)PPGridCellUserObject * cellObject;
@end
