//
//  PPJSDirectorProtocol.h
//  Blok
//
//  Created by Alex Padalko on 4/13/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import <Foundation/Foundation.h>



@class PPJSDController;
#import "PPJSDMutableArray.h"
#import "PPJActionProt.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


@protocol PPJSDirectorProtocol <NSObject>
@property (nonatomic,strong)PPJSDController * PPJSD_smartDisplayControllerRef;

@optional

-(id)PPJSD_registerSpecifierFor:(PPJSDController*)smartDisplayController;
-(PPJActionResponse)PPJSD_smartDisplayController:(PPJSDController*)smartDisplayController didSendAction:(id<PPJActionProt>)action;

-(void)PPJSD_didCalculateItems;
-(void)PPJSD_didCalculateInitialItems;

-(void)PPJSD_willShowLoadCell;

#warning PPJSD UPDATE
-(RACSignal*)PPJSD_registerItemsForSmartDisplayController:(PPJSDController*)smartDisplayController;



-(void)PPJSD_didSelectItem:(id<PPJSDObjectProtocol>)item atIndexPath:(NSIndexPath*)indexPath;
@end
