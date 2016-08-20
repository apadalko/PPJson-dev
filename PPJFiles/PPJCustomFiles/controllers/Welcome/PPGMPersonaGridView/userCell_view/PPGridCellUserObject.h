//
//  PPGridPersonaCellObject.h
//  Gabbermap
//
//  Created by Alex Padalko on 2/22/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGridCellObject.h"
#import "PPUserProt.h"
@interface PPGridCellUserObject : PPGridCellObject
-(instancetype)initWithGridPoint:(CGPoint)gridPoint andUser:(id<PPUserProt>)user;
@property (nonatomic,retain)id<PPUserProt>user;
@end
