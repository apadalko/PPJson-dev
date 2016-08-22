//
//  PPJMCArrayHolder.h
//  Blok
//
//  Created by Alex Padalko on 6/16/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import <Foundation/Foundation.h>
#import "PPJSDDynamicDirectorProtocol.h"
#import "PPJSDDirectorProtocol.h"
#import "PPJMCDataHolder.h"
@class PPJMCDataHolder;
typedef void(^PPJMCDataHolderComplBlock)(PPJSDMutableArray* arr,NSError*error);
typedef void(^PPJMCDataHolderLoadBlock)(NSInteger segment, NSInteger fromIdx,NSInteger toIdx,NSDate * deltaDate,PPJMCDataHolderComplBlock complBlock);
typedef void(^PPJMCDataHolderFinishBlock) (PPJMCDataHolder * dataHolder, PPJSDMutableArray* loadedItems,NSError* error);

@interface PPJMCDataHolder : NSObject<PPJSDDynamicDirectorProtocol,PPJSDirectorProtocol>
+(instancetype)createWithSegment:(NSInteger)segment  andLoadBlock:(PPJMCDataHolderLoadBlock)loadBlock andFinishBlock:(PPJMCDataHolderFinishBlock)finishBlock;

@property (nonatomic)NSInteger segment;
@property (nonatomic,retain)PPJSDMutableArray * array;
@property (nonatomic,retain)RACCommand * loadCommand;
@property (nonatomic,retain)PPJSDController * controller;
@property (copy,nonatomic)PPJMCDataHolderLoadBlock loadBlock;
@property (copy,nonatomic)PPJMCDataHolderFinishBlock finishBlock;
@property (nonatomic)NSInteger pageSize;
@property (nonatomic)NSInteger currentIndex;

@property (nonatomic,getter=isLoading)BOOL loading;


@property (nonatomic,weak)id <PPJSDirectorProtocol,PPJSDDynamicDirectorProtocol> outerReciver;

@property (nonatomic,retain)NSDate * deltaDate;
 
@property (nonatomic)id  specifier;

-(void)reload;
@end
