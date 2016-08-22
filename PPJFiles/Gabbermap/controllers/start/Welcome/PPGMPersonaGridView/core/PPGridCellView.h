//
//  PPGridCellView.h
//  PPGMPersonaGridView
//
//  Created by Alex Padalko on 2/21/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPGridCellObject.h"
@interface PPGridCellView : UIView
-(instancetype)initWithGridCellObject:(PPGridCellObject*)cellObject;
@property (nonatomic,retain)PPGridCellObject *cellObject;
@end
