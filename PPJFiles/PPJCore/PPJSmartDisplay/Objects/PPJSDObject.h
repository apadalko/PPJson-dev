//
//  PPJSDObject.h
//  Blok
//
//  Created by Alex Padalko on 4/14/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import <Foundation/Foundation.h>
#import "PPJSDMappingObject.h"
#import "PPJSDObjectProtocol.h"
#import "PPJSDObjectDelegate.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface PPJSDObject : NSObject<PPJSDObjectProtocol,PPJSDObjectDelegate>
@property (nonatomic)CGSize size;



@end
