//
//  MGMultipleContentViewModel.h
//  Blok
//
//  Created by Alex Padalko on 5/6/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//
#import "PPJSDDirectorViewModel.h"
#import "PPJSDDynamicDirectorProtocol.h"
#import "PPJMCDataHolder.h"
#import "PPJSDLoadCellDisplayObject.h"
#import "PPJSDStatesObject.h"
@interface PPJSDMultipleContentViewModel :  PPJSDDirectorViewModel <PPJSDDynamicDirectorProtocol>


-(void)deleteDataHolderAtSegment:(NSUInteger)segment;
-(void)viewAtIndexBecomeVisible:(NSInteger)idx;
@property (nonatomic)NSInteger selectedIndex;

@property (nonatomic,retain)RACSignal * scrollToIndexSignal;


-(BOOL)reloadDataOnAppear;
-(void)bindSmartView:(id<PPJSDControllerViewProtocol>)smartView atSegment:(NSInteger)segment;

-(void)loadItemsForSegment:(NSInteger)segment fromIdx:(NSInteger)fromIdx toIdx:(NSInteger)toIdx deltaDate:(NSDate*) deltaDate andComplBlock:(void(^)(PPJSDMutableArray *items, NSError *error))complitBlock;



-(RACCommand *)loadCommandForSegment:(NSInteger)segment;
-(NSString*)segmentKey:(NSInteger)seg;


@property (nonatomic)NSInteger segmentsCount;
-(PPJMCDataHolder*)dataHolderForSegment:(NSInteger)segment;




-(void)didReciveNewItems:(PPJSDMutableArray*)newItemsArray fromDataHolder:(PPJMCDataHolder*)dataHolder withError:(NSError *)error;
-(void)configurateDataHolder:(PPJMCDataHolder*)dataHolder;



-(BOOL)automaticLoadOnInit;


@property (nonatomic,retain)PPJSDObject * topDisplayObject;

@property (nonatomic,retain)RACSignal * rebuildSegmentSignal;
-(void)removeDataHolderAtIdx:(NSInteger)idx;

//

//-(void)bindFirstView:(id<PPJSDControllerViewProtocol>)smartView;
//-(void)bindSecondView:(id<PPJSDControllerViewProtocol>)smartView;




//@property (nonatomic,retain)RACCommand * loadFirstCommand;
//@property (nonatomic,retain)RACCommand * loadSecondCommand;

//@property (retain,nonatomic)PPJSDController *firstDisplayController;
//@property (retain,nonatomic)PPJSDController *secondDisplayController;


//@property (retain,nonatomic)PPJSDMutableArray * firstItemsArray;
//@property (retain,nonatomic)PPJSDMutableArray * secondItemsArray;


//-(void)loadFirstItemsComplBlock:(void(^)(PPJSDMutableArray *items, NSError *error))complitBlock;
//-(void)loadSecondItemsComplBlock:(void(^)(PPJSDMutableArray *items, NSError *error))complitBlock;

//@property (nonatomic)BOOL firstIsloading;
//@property (nonatomic)BOOL secondIsloading;


@end
