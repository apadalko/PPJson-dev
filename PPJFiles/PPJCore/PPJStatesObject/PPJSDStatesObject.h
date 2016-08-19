//
//  PPJSDStatesObject.h
//  Gabbermap
//
//  Created by Alex Padalko on 2/25/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPJSDObject.h"
#import "PPJSDStateObjectProt.h"
@interface PPJSDStatesObject : PPJSDObject <PPJSDStateObjectProt>

-(instancetype)initWithStateType:(PPJSDLoadStateType)stateType;


@property (nonatomic,retain)Class displayViewClass;

@property (weak,nonatomic)id displayView;


@end
