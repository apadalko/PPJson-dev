//
//  PPJSDController.m
//  PPJSmartDisplay
//
//  Created by Alex Padalko on 4/11/15.
//  Copyright (c) 2015 Alex Padalko. All rights reserved.
//

#import "PPJSDController.h"
#import "PPJSDDirectorProtocol.h"
#import "PPJSDObjectProtocol.h"


@interface PPJSDController ()<PPJSDMutableArrayDelegate>
//        @property (nonatomic,strong)dispatch_queue_t workQuene;
@property (nonatomic)CGSize deltaSize;
@end

@implementation PPJSDController
#pragma mark - construct/init/setup

-(instancetype)init{
    if (self=[super init]) {

        self.workQuene = dispatch_queue_create("com.PPJSDController",  0);
    }
    return self;
}
+(instancetype)displayControllerWithView:(id<PPJSDControllerViewProtocol>)view{
    PPJSDController * dc=[[PPJSDController alloc] init];
    dc.bindedView=view;
   // [view setViewDelegate:self];
    return dc;
}
+(instancetype)displayControllerWithView:(id<PPJSDControllerViewProtocol>)view andDirector:(id<PPJSDirectorProtocol>)director{
    PPJSDController * dc = [self displayControllerWithView:view];
    dc.director=director;
    [director setPPJSD_smartDisplayControllerRef:dc];
    
    
    return dc;
}
+(instancetype)displayControllerWithView:(id<PPJSDControllerViewProtocol>)view andDirector:(id<PPJSDirectorProtocol>)director andSpecifier:(id)spec{
    PPJSDController * dc = [self displayControllerWithView:view];
    dc.specifier=spec;
    dc.director=director;
    [director setPPJSD_smartDisplayControllerRef:dc];
    
    
    return dc;
}
-(void)setSpecifier:(id)specifier{
    _specifier=specifier;
  [_bindedView setSpecifier:self.specifier];
}
-(void)setBindedView:(id<PPJSDControllerViewProtocol>)bindedView{
    _bindedView=bindedView;
    [_bindedView setSpecifier:self.specifier];
}
#pragma mark -

-(void)setDirector:(id<PPJSDirectorProtocol>)director{
    _director=director;
    
    if ([director respondsToSelector:@selector(PPJSD_registerSpecifierFor:)]) {
        
  self.specifier  =    [director PPJSD_registerSpecifierFor:self];
        
    }
    
    if ([director respondsToSelector:@selector(PPJSD_registerItemsForSmartDisplayController:)]) {
        @weakify(self);
        [[director PPJSD_registerItemsForSmartDisplayController:self] subscribeNext:^(PPJSDMutableArray * x) {
            
            if (x) {
                
                @strongify(self);
                
                self.deltaSize=CGSizeZero;
                [x setDelegate:self];
                [self.bindedView setPPJSD_items:x];
                @weakify(x);
                UIView * v= (UIView*)self.bindedView;
                [[RACObserve(v, frame) takeWhileBlock:^BOOL(id x_x) {
                    @strongify(x);
                    if (x) {
                        return YES;
                    }else{
                        return NO;
                    }
                    
                    
                }] subscribeNext:^(NSValue * rectVal) {
                   
                   
                    if ([rectVal CGRectValue].size.width!=self.deltaSize.width) {
                   
                 //   if (!CGSizeEqualToSize(([rectVal CGRectValue].size), self.deltaSize)) {
                        
                                 @strongify(self);
                        self.deltaSize=[rectVal CGRectValue].size;
                        NSMutableArray * arrToCalc=[[NSMutableArray alloc] initWithArray:x.realArray];
                        
                        dispatch_async(self.workQuene, ^{
                            for (id <PPJSDObjectProtocol> object in arrToCalc) {
                                
                                [object calculateObjectInWithSuperViewSize:[self.bindedView getSize]];
                            }
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                         @strongify(self);
                                [self.bindedView dataDidReload];
                                if ([self.director respondsToSelector:@selector(PPJSD_didCalculateItems)]) {
                                    [self.director PPJSD_didCalculateInitialItems];
                                }
                            });
                            
                        });
                        
                    }
                 
                    
                }];
                
                
        //
                
//                if (x.count>0) {
//                    
//                   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                        for (id <PPJSDObjectProtocol> object in x.realArray) {
//                            
//                            [object calculateObjectInWithSuperViewSize:[self.bindedView getSize]];
//                        }
//                        
//                       dispatch_async(dispatch_get_main_queue(), ^{
//                            [self.bindedView dataDidReload];
//                      });
//                        
//                  });
//                }
         

            }
            
        }];
    }
    
    
}
-(void)update{
    
    [self.bindedView  dataDidUpdated];
}
#pragma  mark - PPJSDViewDelegate



#pragma mark - PPJSDMutableArrayDelegate
-(void)refreshObjectAtIndex:(NSInteger)index{

    

    
    
    [self.bindedView refreshDataAtIndex:index];
}
-(void)objectAtIndex:(NSInteger)index didSendActions:(NSArray *)actions{
    
    

  //  BOOL shouldUpd;
    for (id<PPJActionProt> act in actions)
    
    {
        

     PPJActionResponse r =   [self.director PPJSD_smartDisplayController:self didSendAction:act];
        
        if (r==PPJActionResponseReloadAllData) {
            [self.bindedView reloadData];
        }else     if (r==PPJActionResponseReloadParticularSection) {
            
            [self.bindedView refreshDataAtIndex:index];
        }
        
    }
    

}

-(void)smartDisplayArray:(PPJSDMutableArray *)array didAddedObjects:(NSArray *)objects fromIndex:(NSInteger)idx{
    
    
    __block NSInteger blockIdx=idx;
        dispatch_async(self.workQuene, ^{
    for (id <PPJSDObjectProtocol> object in objects) {
        
        [object calculateObjectInWithSuperViewSize:[self.bindedView getSize]];
    }
        
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                if ([self.director respondsToSelector:@selector(PPJSD_didCalculateItems)]) {
                    [self.director PPJSD_didCalculateItems];
                }
                [self.bindedView dataDidUpdatedFromIndex:blockIdx withObjects:objects];
               
            });
            
        });
}
-(void)smartDisplayArray:(PPJSDMutableArray *)array didInsertObject:(id<PPJSDObjectProtocol>)object atIndex:(NSInteger)index{
      [object calculateObjectInWithSuperViewSize:[self.bindedView getSize]];
         [self.bindedView dataDidUpdatedAtIndex:index];
   // }];
}
-(void)smartDisplayArray:(PPJSDMutableArray *)array didRemoveObject:(id<PPJSDObjectProtocol>)object atIndex:(NSInteger)index{
        [self.bindedView dataDidUpdatedAtIndex:index];
}

#pragma mark -

-(void)dealloc{
    NSLog(@"PPJSD DEALLOC:%@",self);
}
@end
