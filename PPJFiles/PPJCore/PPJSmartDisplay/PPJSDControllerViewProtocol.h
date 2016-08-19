//
//  PPJSDControllerViewProtocol.h
//  Blok
//
//  Created by Alex Padalko on 9/28/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPJSDDynamicDirectorProtocol.h"
@class PPJSDMutableArray;
@protocol PPJSDirectorProtocol;
@protocol PPJSDControllerViewProtocol <NSObject>


-(CGSize)getSize;

-(CGSize)getSizeOfItemAtIndexPath:(NSIndexPath*)indexPath;
-(CGRect)frame;

-(void)dataDidReload;
-(void)dataDidUpdated;
-(void)dataDidUpdatedFromIndex:(NSInteger)index withObjects:(NSArray*)objects;
-(void)dataDidUpdatedAtIndex:(NSInteger)index;
-(void)refreshDataAtIndex:(NSInteger)index;

-(void)recivedCostomSignal:(NSInteger)signal;


@property (weak,nonatomic)PPJSDMutableArray * PPJSD_items;
@property (weak,nonatomic)id specifier;
//@property (weak,nonatomic)id<PPJSDViewDelegate> viewDelegate;

@property (nonatomic,weak)id<PPJSDirectorProtocol> baseDirector;
@property (nonatomic,weak)id<PPJSDDynamicDirectorProtocol>dynamicDirector;



-(void)reloadData;
@end
