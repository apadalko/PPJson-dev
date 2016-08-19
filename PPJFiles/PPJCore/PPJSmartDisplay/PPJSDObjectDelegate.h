//
//  PPJSDViewProtocol.h
//  Blok
//
//  Created by Alex Padalko on 4/14/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import <Foundation/Foundation.h>
#import "PPJAction.h"
@protocol PPJSDObjectDelegate  <NSObject>
-(void)sendActionType:(NSInteger)actionType;
-(void)sendAction:(PPJAction*)action;

@end


