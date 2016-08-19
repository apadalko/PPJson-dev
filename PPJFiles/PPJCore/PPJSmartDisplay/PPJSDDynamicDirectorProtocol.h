//
//  MGPPJSDDynamicTableViewProtocol.h
//  Blok
//
//  Created by Alex Padalko on 4/15/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger,PPJSDShowType){
    
    PPJSDShowTypeNO=0,
    PPJSDShowTypeYES=1,
    PPJSDShowTypeBLOCKED
    
};
@class RACCommand;
@class PPJSDObject;

#import "PPJSDLoadObjectProt.h"
#import "PPJSDStateObjectProt.h"

#import "PPJSDLoadStates.h"
@protocol PPJSDirectorProtocol;
@protocol PPJSDObjectProtocol;



@protocol PPJSDDynamicDirectorProtocol <PPJSDirectorProtocol>


@property (retain,nonatomic)RACCommand *PPJSD_loadNextPageCommand;





@property (nonatomic)PPJSDShowType PPJSD_shouldShowLoadCell;
@property (nonatomic)PPJSDShowType PPJSD_shouldShowInitialLoader;
@property (nonatomic)PPJSDShowType PPJSD_shouldShowErrorView;
@property (nonatomic)PPJSDShowType PPJSD_shouldShowEmptyView;

@property (nonatomic)PPJSDLoadStateType PPJSD_currentState;



@property (nonatomic,retain)id<PPJSDObjectProtocol,PPJSDLoadObjectProt>  PPJSD_loadCellObject;
@property (nonatomic,retain)id<PPJSDObjectProtocol,PPJSDStateObjectProt> PPJSD_initialLoadCellObject;
@property (nonatomic,retain)id<PPJSDObjectProtocol,PPJSDStateObjectProt> PPJSD_errorStateObject;
@property (nonatomic,retain)id<PPJSDObjectProtocol,PPJSDStateObjectProt> PPJSD_emptyStateObject;





-(NSInteger)PPJSD_loadCellPosition;//if -1 will be always last


@end
