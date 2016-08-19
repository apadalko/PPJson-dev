//
//  MGDynamicContentViewModel.h
//  Blok
//
//  Created by Alex Padalko on 4/14/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJSDDirectorViewModel.h"
#import "PPJSDDynamicDirectorProtocol.h"
#import "PPJSDLoadCellDisplayObject.h"

typedef NS_ENUM(NSInteger, MGLoadItemsType) {
    
    MGLoadItemsTypeNone,
    MGLoadItemsTypeReload
    
};

typedef void(^MGDynamicLoadItemsBlock)(PPJSDMutableArray*resultArray,NSError * error);

@interface PPJSDDynamicDirectorViewModel : PPJSDDirectorViewModel<PPJSDDynamicDirectorProtocol>


@property (nonatomic)NSInteger currentPageIndex;// def 0
@property (nonatomic)NSInteger pageSize;//def 16


@property (nonatomic)BOOL shouldShowAutoReload;
@property (nonatomic,retain)NSDate * deltaDate;
@property (retain,nonatomic)RACCommand * loadItemsCommand;
@property (nonatomic,getter=isLoading)BOOL loading;


@property (nonatomic,retain)RACSignal * emptyStateSignal;
@property (nonatomic,retain)RACSignal * errorSignal; /// with error




-(void)shouldLoadItemsFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex deltaDate:(NSDate*)deltaDate complitBlock:(MGDynamicLoadItemsBlock)complitBlock;
-(void)didRecivedItems:(PPJSDMutableArray *)newItems;
-(void)didRecivedError:(NSError *)error;
@end
