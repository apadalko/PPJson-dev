//
//  MGSDDirectorViewModel.m
//  Blok
//
//  Created by Alex Padalko on 4/14/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJSDDirectorViewModel.h"
#import "PPJSDController.h"
@interface PPJSDDirectorViewModel()
@property (nonatomic)BOOL initialAppear;
@end
@implementation PPJSDDirectorViewModel
//@synthesize deleteSectionCommand;
#pragma mark - PPJSD director prot realization
@synthesize  PPJSD_smartDisplayControllerRef=_PPJSD_smartDisplayControllerRef;
-(NSArray *)availableFieldsArray{
    return nil;
}
-(void)reloadData{
    self.items=self.items;
}
-(PPJActionResponse)PPJSD_smartDisplayController:(PPJSDController*)smartDisplayController didSendAction:(id<PPJActionProt>)action{
  return  [self didReciveAction:action];
}

-(RACSignal*)PPJSD_registerItemsForSmartDisplayController:(PPJSDController*)smartDisplayController{
    return RACObserve(self, items);
}
-(void)dataDidLoad{
    self.initialAppear=NO;
    [super dataDidLoad];
    @weakify(self);
    [RACObserve(self, viewWillDissapiarSignal) subscribeNext:^(id x) {
       
        if (x) {
            @strongify(self);
            if (!self.initialAppear) {
                self.initialAppear=YES;
            }else{
                [self shouldRealoadItemsOnAppear];
            }
        }
        
    }];
}

-(void)smartDisplayObject:(id<PPJSDObjectProtocol>)smartDisplayObject sendAction:(id<PPJActionProt>)action{
    [self didReciveAction:action];
}
-(void)refresh:(id<PPJSDObjectProtocol>)smartDisplayObject{
    
}
-(PPJSDMutableArray *)items{
    if (!_items) {
        _items=[[PPJSDMutableArray alloc] init];
    }
    return _items;
}
-(void)shouldRealoadItemsOnAppear{
  //  self.items=self.items;
}
#pragma mark - 
-(void)bindSmartView:(id<PPJSDControllerViewProtocol>)smartView{
    
    [PPJSDController displayControllerWithView:smartView andDirector:self];
}
-(void)dataModelDidBind{
    
    [super dataDidLoad];
//    self.items=[[PPJSDMutableArray alloc] init];
    
}
#pragma mark -

-(void)PPJSD_didSelectItem:(id<PPJSDObjectProtocol>)item atIndexPath:(NSIndexPath *)indexPath{
    
}


@end
