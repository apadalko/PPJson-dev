//
//  PPJSDCollectionView.h
//  Blok
//
//  Created by Alex Padalko on 9/27/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPJSDControllerViewProtocol.h"
#import "PPJSDView.h"
#import "PPJSDObjectProtocol.h"
typedef NS_ENUM(NSInteger, PPJSDCollectionViewDisplayType) {
    
    //initial
    PPJSDCollectionViewDisplayTypeAsSecions,
    PPJSDCollectionViewDisplayTypeAsRows
    
};

@interface PPJSDCollectionView : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegate,PPJSDControllerViewProtocol>
@property (nonatomic)PPJSDCollectionViewDisplayType displayType;
-(CGSize)getSizeOfItemAtIndexPath:(NSIndexPath*)indexPath;
-(id<PPJSDObjectProtocol>)objectForIndex:(NSInteger)index;
@property (nonatomic,retain)PPJSDView * globalHeaderView;

-(UIView<PPJDisplayViewProt>*)createDisplayViewFromMappingObject:(PPJSDMappingObject*)mappingObject;
@end
