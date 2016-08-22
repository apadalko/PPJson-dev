//
//  PPGridCellPersonaView.h
//  PPGMPersonaGridView
//
//  Created by Alex Padalko on 2/21/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPGridCellView.h"
#import "PPUserProt.h"
#import "PPGridCellPersonaObject.h"
@interface PPGridCellPersonaView : PPGridCellView
-(instancetype)initWithGridCellObject:(PPGridCellPersonaObject *)cellObject;
@property (nonatomic,retain)PPGridCellPersonaObject * cellObject;

-(void)setstaticUser:(id<PPUserProt>)user;
@end
