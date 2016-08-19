//
//  PPJMCArrayHolder.m
//  Blok
//
//  Created by Alex Padalko on 6/16/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJMCDataHolder.h"
//#import "MGRetryLoadObject.h"
@implementation PPJMCDataHolder
#pragma mark -   <PPJSDirectorProtocol>
@synthesize  PPJSD_smartDisplayControllerRef=_PPJSD_smartDisplayControllerRef;
-(id)PPJSD_registerSpecifierFor:(PPJSDController*)smartDisplayController{
    
    return self.specifier?self.specifier : @"spec";
}
-(PPJActionResponse)PPJSD_smartDisplayController:(PPJSDController*)smartDisplayController didSendAction:(id<PPJActionProt>)action{
    return  [self.outerReciver PPJSD_smartDisplayController:smartDisplayController didSendAction:action];
}
-(void)PPJSD_didSelectItem:(id<PPJSDObjectProtocol>)item atIndexPath:(NSIndexPath *)indexPath{
    [self.outerReciver PPJSD_didSelectItem:item atIndexPath:indexPath];
    
}
-(RACSignal*)PPJSD_registerItemsForSmartDisplayController:(PPJSDController*)smartDisplayController{
    return RACObserve(self, array);
}
-(void)setPPJSD_currentState:(PPJSDLoadStateType)PPJSD_currentState{
    _PPJSD_currentState=PPJSD_currentState;
}

-(void)setPPJSD_shouldShowLoadCell:(PPJSDShowType)PPJSD_shouldShowLoadCell{
    _PPJSD_shouldShowLoadCell=PPJSD_shouldShowLoadCell;
}
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
    return self.loadCommand;
}

-(NSInteger)PPJSD_loadCellPosition{
    
    return -1;
    
}
-(BOOL)PPJSD_enableAutomaticLoad{
    return YES;
}

#pragma mark -

#pragma mark - PPJSD state cells objects

-(id<PPJSDObjectProtocol,PPJSDStateObjectProt>)PPJSD_emptyStateObject{
    if (!_PPJSD_emptyStateObject) {
        return [self.outerReciver PPJSD_emptyStateObject];
    }else{
        return _PPJSD_emptyStateObject;
    }
    
}
-(id<PPJSDObjectProtocol,PPJSDStateObjectProt>)PPJSD_initialLoadCellObject{
    if (!_PPJSD_initialLoadCellObject) {
        return [self.outerReciver PPJSD_initialLoadCellObject];
    }else{
        return _PPJSD_initialLoadCellObject;
    }
}

-(id<PPJSDObjectProtocol,PPJSDStateObjectProt>)PPJSD_errorStateObject{
    if (!_PPJSD_errorStateObject) {
        return [self.outerReciver PPJSD_errorStateObject];
    }else{
        return _PPJSD_errorStateObject;
    }
    
}

-(id<PPJSDObjectProtocol>)PPJSD_loadCellObject{
    if (!_PPJSD_loadCellObject) {
            return [self.outerReciver PPJSD_loadCellObject];
    }else{
        return _PPJSD_loadCellObject;
    }

}




#pragma mark -
+(instancetype)createWithSegment:(NSInteger)segment  andLoadBlock:(PPJMCDataHolderLoadBlock)loadBlock andFinishBlock:(PPJMCDataHolderFinishBlock)finishBlock{
    
    PPJMCDataHolder * dh = [[self alloc] init];
    dh.segment=segment;
    dh.finishBlock=finishBlock;
    dh.loadBlock=loadBlock;

    
    
    return dh;
    
}

-(instancetype)init{
    
    if (self=[super init]) {

        
        self.PPJSD_shouldShowInitialLoader=YES;
        self.PPJSD_shouldShowInitialLoader=YES;
        self.PPJSD_shouldShowLoadCell=YES;
        self.PPJSD_shouldShowEmptyView=YES;
        self.PPJSD_shouldShowErrorView=YES;
        
        
        
        _pageSize=1;
        _currentIndex=0;

   
        @weakify(self);
        self.loadCommand=[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            if (input) {
                if ([input integerValue]==1) {
                    self.currentIndex=0;
                }
            }
            self.loading=YES;
            return [self loadItemsSignal];
        }];
        
        [[self.loadCommand executionSignals] subscribeNext:^(RACSignal * x) {
            
            [[x dematerialize] subscribeError:^(NSError *error) {
                @strongify(self);
            self.loading=NO;
            } completed:^{
                @strongify(self);
             self.loading=NO;
            }];
            
            
        }];

        
    }
    
    return self;
}





#pragma mark -



-(void)reload{
    self.array=self.array;
}
-(RACSignal *)loadItemsSignal{
    @weakify(self)
    return  [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        @strongify(self);
        
        if (self.currentIndex==0||!self.deltaDate) {
            self.deltaDate=[NSDate date];
        }
        
        if (self.loadBlock) {
            
            if (self.currentIndex==0) {
                self.PPJSD_currentState=PPJSDLoadStateTypeLoading;
                self.array=self.array?self.array:[[PPJSDMutableArray alloc] init];
            }else{
                 self.PPJSD_currentState=PPJSDLoadStateTypeNone;
            }
           
           
            self.loadBlock(self.segment,self.currentIndex,self.pageSize+self.currentIndex,self.deltaDate,^(PPJSDMutableArray * items,NSError * error){
                
                __weak PPJMCDataHolder * selfW=self;
                NSInteger idx=self.currentIndex;
                if (error||!items) {
               
                    if (self.currentIndex==0) {
                      
                        self.PPJSD_currentState=PPJSDLoadStateTypeFail;
                        self.PPJSD_shouldShowLoadCell=NO;
                        
                    }
                    PPJSDMutableArray * arr  =[[PPJSDMutableArray alloc] init];
                      self.finishBlock(selfW, arr,error);
                    
                    self.array=arr;
                 
                   [subscriber sendError:nil];
                    
                    return ;
                }else{
                    
                    if (items.count==0&&   self.currentIndex==0) {
                        
                        self.PPJSD_currentState=PPJSDLoadStateTypeEmpty;
                  
                    }else{
                        self.PPJSD_currentState=PPJSDLoadStateTypeNone;
                    }
                    
                    
                         if (self.PPJSD_shouldShowLoadCell!=PPJSDShowTypeBLOCKED) {
                    
                             if (items.count>=self.pageSize) {
                                 
                                 
                                 self.PPJSD_shouldShowLoadCell=YES;
                             }else{
                                 
                                 self.PPJSD_shouldShowLoadCell=NO;
                             }
                         }
     
                    self.finishBlock(selfW,items,error);
                    
                }
                
                    if (idx==0) {
                        self.array=[[PPJSDMutableArray alloc] initWithArray:items];
                    }else{
                        [self.array addObjectsFromArray:items];
                    }
                    
                    self.currentIndex+=self.pageSize;
                    [subscriber sendNext:@""];
                    [subscriber sendCompleted];
              
                
                
                
                
            });

        }else{
            [subscriber sendError:[[NSError alloc] initWithDomain:@"TOD" code:-123 userInfo:nil]];
        }
        
        
 
            
//        }];
        return [RACDisposable disposableWithBlock:^{
            
            
            
        }];
        
    }] materialize];
}
@end
