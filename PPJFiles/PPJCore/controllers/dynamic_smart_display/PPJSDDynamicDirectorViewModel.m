//
//  MGDynamicContentViewModel.m
//  Blok
//
//  Created by Alex Padalko on 4/14/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJSDDynamicDirectorViewModel.h"
//#import "MGRetryLoadObject.h"
#import "PPJSDStatesObject.h"



@implementation PPJSDDynamicDirectorViewModel


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
    return self.loadItemsCommand;
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
#pragma mark -
-(void)dataDidLoad{
    [super dataDidLoad];
    self.shouldShowAutoReload=YES;
    
    
    
    self.PPJSD_shouldShowInitialLoader=YES;
    self.PPJSD_shouldShowLoadCell=YES;
    self.PPJSD_shouldShowEmptyView=YES;
    self.PPJSD_shouldShowErrorView=YES;
    
    
    self.pageSize=10;
    self.currentPageIndex=0;

    
    
        @weakify(self)
    [RACObserve(self, viewWillAppearSignal) subscribeNext:^(id x) {
       
        if (x) {
              @strongify(self);
            if (self.currentPageIndex==0) {
              
                  [[self loadItemsCommand] execute:nil];
            }else{
                self.items=self.items;
            }
          
        }
        
    }];
    
    self.loadItemsCommand=[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                @strongify(self);
        
        
        
        if ([input integerValue]==MGLoadItemsTypeReload) {
            self.currentPageIndex=0;
        }
        
        if (self.currentPageIndex==0) {
              self.deltaDate=[NSDate date];
        }
        
        return [self loadItemsSignal];
    }];
}

 
 

-(RACSignal *)loadItemsSignal{
    @weakify(self)
  return  [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        @strongify(self);
            self.loading=YES;
      
      if (self.currentPageIndex==0) {
          self.PPJSD_currentState=PPJSDLoadStateTypeLoading;
                self.items=self.items;
      }else{
          self.PPJSD_currentState=PPJSDLoadStateTypeNone;
      }


      [self shouldLoadItemsFromIndex:self.currentPageIndex toIndex:self.currentPageIndex+self.pageSize deltaDate:self.deltaDate complitBlock:^(PPJSDMutableArray *resultArray, NSError *error) {
          
       
           if (error||!resultArray) {
                  self.PPJSD_shouldShowLoadCell=NO;
             
               
               self.errorSignal=[RACSignal signalWithObject:error];
               
                [subscriber sendError:nil];
//               if (self.currentPageIndex==0&&self.shouldShowAutoReload) {
//                   self.items=[[PPJSDMutableArray alloc] init];
//                   
//                //   [self.items addObject:[MGRetryLoadObject create]];
//               }
           
               if (self.currentPageIndex==0) {
                   
                       self.PPJSD_currentState=PPJSDLoadStateTypeFail;
               }
                   [self  didRecivedItems:[[PPJSDMutableArray alloc] init]];
               
               
               [self didRecivedError:error];
              //  [subscriber sendNext:@""];
               
                  self.loading=NO;
                return;
            }
          
          
          
          
          
          if (resultArray.count==0&&   self.currentPageIndex==0) {
              
               self.PPJSD_currentState=PPJSDLoadStateTypeEmpty;
              self.emptyStateSignal=[RACSignal signalWithObject:@""];
          }else{
              self.PPJSD_currentState=PPJSDLoadStateTypeNone;
          }
          
           
          if (self.PPJSD_shouldShowLoadCell!=PPJSDShowTypeBLOCKED) {
              
              if (resultArray.count>=self.pageSize) {
                  
                  
                  self.PPJSD_shouldShowLoadCell=YES;
              }else{
                  
                  self.PPJSD_shouldShowLoadCell=NO;
              }
          }
          
          
 
         
            [self  didRecivedItems:resultArray];
          
            self.currentPageIndex+=self.pageSize;
            
            
            
               self.loading=NO;
            [subscriber sendNext:@""];
            [subscriber sendCompleted];
            
            
            
          
        }];
        return [RACDisposable disposableWithBlock:^{
            
            
            
        }];
        
    }] materialize];
  //  return _loadItemsSignal;
}
-(void)didRecivedError:(NSError *)error{
    
}
-(void)didRecivedItems:(PPJSDMutableArray *)newItems{
    if (self.currentPageIndex==0) {
        
        self.items=[[PPJSDMutableArray alloc] initWithArray:newItems];
    }else
        [self.items addObjectsFromArray:newItems];
}



-(void)shouldLoadItemsFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex deltaDate:(NSDate*)deltaDate complitBlock:(MGDynamicLoadItemsBlock)complitBlock{
    
    
    
}

#pragma mark - work with actions


#pragma mark - dynamic tableviewprotocol

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
