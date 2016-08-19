//
//  PPJSDStateObjectProt.h
//  Gabbermap
//
//  Created by Alex Padalko on 2/25/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPJSDLoadStates.h"
#import <CoreGraphics/CGGeometry.h>
@protocol PPJSDStateObjectProt <NSObject>

@property (nonatomic)PPJSDLoadStateType stateType;

@property (nonatomic)CGSize availableSize;

@end
