//
//  PPJSDLoadCellObject.h
//  Gabbermap
//
//  Created by Alex Padalko on 1/12/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPJSDObject.h"

#import "PPJSDLoadObjectProt.h"
@interface PPJSDLoadCellDisplayObject : PPJSDObject<PPJSDLoadObjectProt>


@property (nonatomic,retain)Class customCellClass;
@property (nonatomic)float height;
@end
