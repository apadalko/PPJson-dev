//
//  PPJSDLoadObjectProt.h
//  Gabbermap
//
//  Created by Alex Padalko on 2/25/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPJSDLoadStates.h"
@protocol PPJSDLoadObjectProt <NSObject>
@property (nonatomic)PPJSDLoadStateType loadState;
@property (nonatomic)BOOL shouldLoadAutomatic;
@end
