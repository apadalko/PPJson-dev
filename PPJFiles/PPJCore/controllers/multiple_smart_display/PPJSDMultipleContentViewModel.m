//
//  MGMultipleContentViewModel.m
//  Blok
//
//  Created by Alex Padalko on 5/6/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJSDMultipleContentViewModel.h"
#import <objc/runtime.h>
#import "NSObject+DynamicProperties.h"


@interface PPJSDMultipleContentViewModel (){
    
}
@property (nonatomic,retain)NSMutableDictionary * segmentsDict;
@property (nonatomic,retain)NSMutableDictionary * displayControllersDict;


@property (retain,nonatomic)RACSignal * loadFirstItemsSignal;
@end
@implementation PPJSDMultipleContentViewModel



#pragma mark - <PPJSDDynamicDirectorProtocol>

@synthesize PPJSD_loadNextPageCommand=_PPJSD_loadNextPageCommand;
@synthesize PPJSD_shouldShowLoadCell=_PPJSD_shouldShowLoadCell;
@synthesize PPJSD_shouldShowInitialLoader=_PPJSD_shouldShowInitialLoader;
@synthesize PPJSD_shouldShowEmptyView=_PPJSD_shouldShowEmptyView;
@synthesize PPJSD_shouldShowErrorView=_PPJSD_shouldShowErrorView;


@synthesize PPJSD_currentState=_PPJSD_currentState;


@synthesize PPJSD_loadCellObject=_PPJSD_loadCellObject;
@synthesize PPJSD_initialLoadCellObject=_PPJSD_initialLoadCellObject;
@synthesize PPJSD_emptyStateObject=_PPJSD_emptyStateObject;
@synthesize PPJSD_errorStateObject=_PPJSD_errorStateObject;

#pragma mark methods

-(RACCommand *)PPJSD_loadNextPageCommand{
    return [self dataHolderForSegment:self.selectedIndex].loadCommand;
}

-(NSInteger)PPJSD_loadCellPosition{
    
    return -1;
    
}
-(BOOL)PPJSD_enableAutomaticLoad{
    return YES;
}

#pragma mark - PPJSD state cells objects

-(id<PPJSDObjectProtocol,PPJSDStateObjectProt>)PPJSD_emptyStateObject{
    if (!_PPJSD_emptyStateObject) {
        
        _PPJSD_emptyStateObject=[[PPJSDStatesObject alloc] initWithStateType:PPJSDLoadStateTypeEmpty];
    }
    return _PPJSD_emptyStateObject;
    
}
-(id<PPJSDObjectProtocol,PPJSDStateObjectProt>)PPJSD_initialLoadCellObject{
    if (!_PPJSD_initialLoadCellObject) {
        
        _PPJSD_initialLoadCellObject=[[PPJSDStatesObject alloc] initWithStateType:PPJSDLoadStateTypeLoading];
    }
    return _PPJSD_initialLoadCellObject;
}

-(id<PPJSDObjectProtocol,PPJSDStateObjectProt>)PPJSD_errorStateObject{
    if (!_PPJSD_errorStateObject) {
        
        _PPJSD_errorStateObject=[[PPJSDStatesObject alloc] initWithStateType:PPJSDLoadStateTypeFail];
    }
    return _PPJSD_errorStateObject;
    
}

-(id<PPJSDObjectProtocol,PPJSDLoadObjectProt>)PPJSD_loadCellObject{
    
    if (!_PPJSD_loadCellObject) {
        _PPJSD_loadCellObject=[[PPJSDLoadCellDisplayObject alloc] init];
    }
    return _PPJSD_loadCellObject;
    
}

#pragma mark - PPJSD

-(RACSignal *)PPJSD_registerItemsForSmartDisplayController:(PPJSDController *)smartDisplayController{
    PPJMCDataHolder * dh=   (PPJMCDataHolder*)[self.displayControllersDict valueForKey:smartDisplayController.specifier];
    return RACObserve(dh, array);
    
}



#pragma mark -
-(NSString*)segmentKey:(NSInteger)seg{
    
    return [NSString stringWithFormat:@"s_%ld",(long)seg];
    
    
}
-(NSMutableDictionary*)segmentsDict{
    
    if (!_segmentsDict) {
        
        _segmentsDict=[[NSMutableDictionary alloc] init];
    }
    return _segmentsDict;
    
}
-(NSMutableDictionary *)displayControllersDict{
    
    if (!_displayControllersDict) {
        _displayControllersDict=[[NSMutableDictionary alloc] init];
    }
    return _displayControllersDict;
}
-(PPJMCDataHolder *)dataHolderForSegment:(NSInteger)segment{
    
    return [self.displayControllersDict valueForKey:[self segmentKey:segment]];
}
-(BOOL)automaticLoadOnInit{
    return YES;
}

-(void)reloadData{
    
    
    for (NSString  * k  in self.displayControllersDict) {
        
        PPJMCDataHolder * dh = [self.displayControllersDict valueForKey:k];
        
        [dh reload];
        
    }
}
-(void)removeDataHolderAtIdx:(NSInteger)idx{
    [self.displayControllersDict removeObjectForKey:[self segmentKey:idx]];
}
-(void)bindSmartView:(id<PPJSDControllerViewProtocol>)smartView atSegment:(NSInteger)seg{

    PPJMCDataHolder * dh=[self.displayControllersDict valueForKey:[self segmentKey:seg]];
    if (!dh) {
        
        @weakify(self);
        dh=[PPJMCDataHolder createWithSegment:seg andLoadBlock:^(NSInteger segment, NSInteger fromIdx, NSInteger toIdx,NSDate * deltaDate, PPJMCDataHolderComplBlock complBlock) {

       
            @strongify(self);
         
//            [[dh loadCommand] execute:nil];
            
                    [self loadItemsForSegment:segment fromIdx:fromIdx toIdx:toIdx deltaDate:deltaDate andComplBlock:complBlock];
//
        
        } andFinishBlock:^(PPJMCDataHolder *dataHolder, PPJSDMutableArray *loadedItems, NSError *error) {
            
                   @strongify(self);
            [self didReciveNewItems:loadedItems fromDataHolder:dataHolder withError:error];
            
        }];
        
        dh.pageSize=10;
        dh.outerReciver=self;
        [self.displayControllersDict setValue:dh forKey:[self segmentKey:seg]];
        [PPJSDController displayControllerWithView:smartView andDirector:dh andSpecifier:[self segmentKey:seg]];
[self configurateDataHolder:dh];
    }

}

-(void)deleteDataHolderAtSegment:(NSUInteger)segment{
    
    
     [self.displayControllersDict removeObjectForKey:[self segmentKey:segment]];
}




-(RACCommand *)loadCommandForSegment:(NSInteger)segment{
    
     PPJMCDataHolder * dh=[self.displayControllersDict valueForKey:[self segmentKey:segment]];
    
    return dh.loadCommand;
    
}
-(void)configurateDataHolder:(PPJMCDataHolder *)dataHolder{
    
    
    
}
-(void)didReciveNewItems:(PPJSDMutableArray *)newItemsArray fromDataHolder:(PPJMCDataHolder *)dataHolder withError:(NSError *)error{
    
    if (error) {
        
    }else{
        
        if (newItemsArray.count>=dataHolder.pageSize) {
            self.PPJSD_shouldShowLoadCell=YES;
        }else{
            self.PPJSD_shouldShowLoadCell=NO;
        }
    }
    
    
    
}


-(void)PPJSD_didSelectItem:(id<PPJSDObjectProtocol>)item atIndexPath:(NSIndexPath*)indexPath{
    
}


-(void)viewAtIndexBecomeVisible:(NSInteger)idx{

    
}

-(void)loadItemsForSegment:(NSInteger)segment fromIdx:(NSInteger)fromIdx toIdx:(NSInteger)toIdx deltaDate:(NSDate *)deltaDate andComplBlock:(void (^)(PPJSDMutableArray *, NSError *))complitBlock{
    

    complitBlock(nil,nil);
}
-(void)dataDidLoad{
    [super dataDidLoad];
    
    
    self.PPJSD_shouldShowInitialLoader=YES;
    self.PPJSD_shouldShowInitialLoader=YES;
    self.PPJSD_shouldShowLoadCell=YES;
    self.PPJSD_shouldShowEmptyView=YES;
    self.PPJSD_shouldShowErrorView=YES;
    
    
    self.selectedIndex=0;
    self.segmentsCount=2;

    @weakify(self)
    [RACObserve(self,viewWillAppearSignal) subscribeNext:^(id x) {
    
        if (x) {
            @strongify(self);
            if (self.reloadDataOnAppear) {
                   [[self dataHolderForSegment:self.selectedIndex] setArray:[[self dataHolderForSegment:self.selectedIndex] array]];
            }
         
        }
        
    }];
    

    
}
-(BOOL)reloadDataOnAppear{
    return YES;
}


@end
