//
//  PPObjectProt.h
//  Blok
//
//  Created by Alex Padalko on 12/9/15.
//  Copyright © 2015 com.placepixel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PPObjectProt

-(NSString*)objectId;
-(NSDate*)createdAt;

-(void)saveObject;
-(void)saveObject:(void(^)(BOOL succes,NSError*error))complitBlock;


-(void)saveObjectLocal;
-(void)saveObjectLocal:(void(^)(BOOL succes,NSError*error))complitBlock;
-(NSString*)emptyId;

-(NSString*)objectClassName;
-(NSDictionary*)dictionaryRepresentation;



@property (nonatomic,retain)NSHashTable * objObservers;

-(void)addObjObserver:(id )objObserver;
-(void)removeObjObserver:(id )objObserver;

@end
