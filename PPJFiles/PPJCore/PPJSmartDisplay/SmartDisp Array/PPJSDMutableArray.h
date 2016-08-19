//
//  PPJSDMutableArray.h
//  Blok
//
//  Created by Alex Padalko on 4/13/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import <Foundation/Foundation.h>
#import "PPJSDObjectProtocol.h"
@protocol PPJSDObjectProtocol;
@class PPJSDMutableArray;
@protocol PPJSDMutableArrayDelegate <NSObject>


//-(void)smartDisplayArray:(PPJSDMutableArray*)array didAddObject:(id<PPJSDObjectProtocol>)object;
-(void)smartDisplayArray:(PPJSDMutableArray*)array didRemoveObject:(id<PPJSDObjectProtocol>)object atIndex:(NSInteger)index;
-(void)smartDisplayArray:(PPJSDMutableArray*)array didAddedObjects:(NSArray*)objects fromIndex:(NSInteger)idx;
-(void)smartDisplayArray:(PPJSDMutableArray*)array didInsertObject:(id<PPJSDObjectProtocol>)object atIndex:(NSInteger)index;


-(void)objectAtIndex:(NSInteger)index didSendActions:(NSArray*)actions;
-(void)refreshObjectAtIndex:(NSInteger)index;

@end


@interface PPJSDMutableArray : NSObject <PPJSDObjectActionReciverProtocol>

#pragma mark - reINIT
+ (instancetype)arrayWithObject:(id<PPJSDObjectProtocol>)anObject;
+ (instancetype)arrayWithObjects:(const id<PPJSDObjectProtocol> [])objects count:(NSUInteger)cnt;
//+ (instancetype)arrayWithObjects:(id<PPJSDObjectProtocol>)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
+ (instancetype)arrayWithArray:(PPJSDMutableArray *)array;
//- (instancetype)initWithObjects:(id<PPJSDObjectProtocol>)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
- (instancetype)initWithArray:(PPJSDMutableArray *)array;
//- (instancetype)initWithArray:(PPJSDMutableArray *)array copyItems:(BOOL)flag;
#pragma mark - adds
@property (nonatomic,retain)NSMutableArray * realArray;
- (void)addObjectsFromArray:(PPJSDMutableArray *)otherArray;

-(void)addArrayOfObjects:(NSArray*)array;
-(NSInteger)count;
-(void)addObject:(id<PPJSDObjectProtocol>)object;
-(void)addObject:(id<PPJSDObjectProtocol>)object shouldUpdate:(BOOL)shouldUpdate;
-(void)insertObject:(id<PPJSDObjectProtocol>)anObject atIndex:(NSUInteger)index;
-(void)insertObject:(id<PPJSDObjectProtocol>)anObject atIndex:(NSUInteger)index shouldUpdate:(BOOL)shouldUpdate;
-(void)insertObjects:(PPJSDMutableArray*)otherArray atIndex:(NSUInteger)index;

- (void)removeLastObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
-(id<PPJSDObjectProtocol>)objectAtIndex:(NSInteger)index;
#pragma mark - else

@property (weak,nonatomic)id<PPJSDMutableArrayDelegate>delegate;
@end
