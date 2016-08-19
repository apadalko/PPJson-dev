//
//  PPJSDMutableArray.m
//  Blok
//
//  Created by Alex Padalko on 4/13/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJSDMutableArray.h"
#import "PPJSDMutableArray.h"
#import "PPJSDObject.h"
@interface PPJSDMutableArray ()<PPJSDObjectActionReciverProtocol>
{
    
}

@end
@implementation PPJSDMutableArray
#pragma mark - init
-(instancetype)init{
    if (self=[super init]) {
        self.realArray=[[NSMutableArray alloc] init];
    }
    return self;
    
}
+(instancetype)create{
    
    PPJSDMutableArray * arr =[[self alloc] init];
    
    return  arr;
    
}
+ (instancetype)arrayWithObject:(id<PPJSDObjectProtocol>)anObject{
    PPJSDMutableArray  *arr = [self create];
    [arr setRealArray:[NSMutableArray  arrayWithObject:anObject]];
    return arr;
}
+ (instancetype)arrayWithObjects:(const id<PPJSDObjectProtocol> [])objects count:(NSUInteger)cnt{
    PPJSDMutableArray  *arr = [self create];
    [arr setRealArray:[NSMutableArray  arrayWithObjects:objects count:cnt]];
    return arr;
}

//+ (instancetype)arrayWithObjects:(id<PPJSDObjectProtocol>)firstObj, ... NS_REQUIRES_NIL_TERMINATION{
//    PPJSDMutableArray  *arr = [self create];
//    [arr setRealArray:[NSMutableArray  arrayWithObjects:firstObj,...]];
//    return arr;
//}
+ (instancetype)arrayWithArray:(PPJSDMutableArray *)array{

    return [[PPJSDMutableArray alloc] initWithArray:array];
}
//- (instancetype)initWithObjects:(id<PPJSDObjectProtocol>)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
- (instancetype)initWithArray:(PPJSDMutableArray *)array{
    
    
    if (self=[super init]) {
        for (id<PPJSDObjectProtocol> obj in array.realArray) {
            [obj setActionReciver:self];
        }
            [self setRealArray:[NSMutableArray  arrayWithArray:array.realArray]];
    }
    return self;
    
}
#pragma mark - adds
-(NSInteger)count{
    return self.realArray.count;
}
- (void)addObjectsFromArray:(PPJSDMutableArray *)otherArray{
    [self addArrayOfObjects:otherArray.realArray];
}


-(void)addArrayOfObjects:(NSArray *)array{
      NSInteger idx=self.realArray.count;
    
    for (id<PPJSDObjectProtocol> obj in array) {
        [obj setActionReciver:self];
    }
    
    [self.realArray addObjectsFromArray:array];
    [self.delegate smartDisplayArray:self didAddedObjects:array fromIndex:idx];
}
-(void)addObject:(id<PPJSDObjectProtocol>)object{
    [self addObject:object shouldUpdate:YES];
  
}
-(void)addObject:(id<PPJSDObjectProtocol>)object shouldUpdate:(BOOL)shouldUpdate{
    if (object) {
        NSInteger idx=self.realArray.count;
        [self insertObject:object atIndex:idx shouldUpdate:shouldUpdate];
    }
}

- (void)insertObject:(id<PPJSDObjectProtocol>)anObject atIndex:(NSUInteger)index{
  
    [self insertObject:anObject atIndex:index shouldUpdate:YES];
}

-(void)insertObject:(id<PPJSDObjectProtocol>)anObject atIndex:(NSUInteger)index shouldUpdate:(BOOL)shouldUpdate{
    [anObject setActionReciver:self];
    [self.realArray insertObject:anObject atIndex:index];
    if (shouldUpdate) {
            [self.delegate smartDisplayArray:self didInsertObject:anObject atIndex:index];
    }

}



-(void)insertObjects:(PPJSDMutableArray*)otherArray atIndex:(NSUInteger)index{
    
    [self.realArray insertObjects:otherArray.realArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, otherArray.count)]];
    
       [self.delegate smartDisplayArray:self didAddedObjects:otherArray.realArray fromIndex:index];
    
    
}


- (void)removeLastObject{
    NSInteger idx=self.realArray.count-1;
    [self removeObjectAtIndex:idx];
}
- (void)removeObjectAtIndex:(NSUInteger)index{
    id <PPJSDObjectProtocol> obj = [self objectAtIndex:index];
    [obj setActionReciver:nil];
    [self.realArray removeObjectAtIndex:index];
    [self.delegate smartDisplayArray:self didRemoveObject:obj atIndex:index];
    
}
-(id<PPJSDObjectProtocol>)objectAtIndex:(NSInteger)index{
    if (index<self.realArray.count  ) {
        
        
            return [self.realArray objectAtIndex:index];
    }
    else return nil;
    
}
#pragma mark - methods

#pragma mark - action reciver
-(void)refresh:(id<PPJSDObjectProtocol>)smartDisplayObject{
    
    [self.delegate refreshObjectAtIndex:[self.realArray indexOfObject:smartDisplayObject]];
}
-(void)smartDisplayObject:(id<PPJSDObjectProtocol>)smartDisplayObject sendAction:(id<PPJActionProt>)action{
    [self.delegate objectAtIndex:[self.realArray indexOfObject:smartDisplayObject] didSendActions:[NSArray arrayWithObject:action]];
}

//-(void)sendOuterAction:(id<PPJActionProt>)action thenInternalAction:(id<PPJActionProt>)iternalAction{
//    [self.delegate objectAtIndex:[self.realArray indexOfObject:action] didSendActions:[NSArray arrayWithObjects:action,iternalAction, nil]];
//}
//-(void)sendInternalAction:(id<PPJActionProt>)iternalAction thenOuterAction:(id<PPJActionProt>)action{
//     [self.delegate objectAtIndex:[self.realArray indexOfObject:action] didSendActions:[NSArray arrayWithObjects:iternalAction,action, nil]];
//}
//
//-(void)sendInternalAction:(id<PPJActionProt>)iternalAction{
//        [self.delegate objectAtIndex:[self.realArray indexOfObject:action] didSendActions:[NSArray arrayWithObject:iternalAction]];
//}
//-(void)sendOuterAction:(id<PPJActionProt>)outerAction{
//    
//}


@end
