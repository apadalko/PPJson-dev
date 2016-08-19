//
//  MGSDDirectorViewModel.h
//  Blok
//
//  Created by Alex Padalko on 4/14/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJViewModel.h"

#import "PPJSDController.h"
#import "PPJSDObjectProtocol.h"

@interface PPJSDDirectorViewModel : PPJViewModel<PPJSDirectorProtocol,PPJSDObjectActionReciverProtocol>
@property (nonatomic,retain)PPJSDMutableArray * items;

-(void)bindSmartView:(id<PPJSDControllerViewProtocol>)smartView;
@property (nonatomic,retain)RACSignal * fieldsArraySignal;

-(void)shouldRealoadItemsOnAppear;
-(void)reloadData;
@end
