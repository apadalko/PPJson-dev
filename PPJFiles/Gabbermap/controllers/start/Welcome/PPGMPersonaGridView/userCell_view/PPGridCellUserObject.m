//
//  PPGridPersonaCellObject.m
//  Gabbermap
//
//  Created by Alex Padalko on 2/22/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGridCellUserObject.h"

@implementation PPGridCellUserObject
-(instancetype)initWithGridPoint:(CGPoint)gridPoint andUser:(id<PPUserProt>)user{
    if (self=[super initWithGridPoint:gridPoint]) {
        
        self.user=user;
    }
    return self;
}
@end
