//
//  MGPPJSDObjectContainer.h
//  Blok
//
//  Created by Alex Padalko on 6/12/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJSDObject.h"

@interface PPJSDObjectsContainer : PPJSDObject

@property (nonatomic,retain)PPJSDObject * headerObject;
@property (nonatomic,retain)PPJSDObject * footerObject;

-(void)addSubObject:(PPJSDObject*)obj;
-(void)addArrayOfSubObject:(NSArray*)objArr;
@end
