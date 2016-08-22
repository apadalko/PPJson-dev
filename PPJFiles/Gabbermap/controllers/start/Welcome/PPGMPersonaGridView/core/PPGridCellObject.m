
//
//  PPGridCellObject.m
//  PPGMPersonaGridView
//
//  Created by Alex Padalko on 2/20/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPGridCellObject.h"

@implementation PPGridCellObject
+(instancetype)createWithGridPoint:(CGPoint)gridPoint{
    
    return [[self alloc] initWithGridPoint:gridPoint];
}
-(instancetype)initWithGridPoint:(CGPoint)gridPoint{
    if (self=[super init]) {
        self.gridPoint=gridPoint;
    }
    return self;
}
-(void)sayText:(NSString *)text removeAfter:(float)delay directiom:(NSInteger)direction{
    [self.delegate sayText:text removeAfter:delay directiom:direction];
}
@end
