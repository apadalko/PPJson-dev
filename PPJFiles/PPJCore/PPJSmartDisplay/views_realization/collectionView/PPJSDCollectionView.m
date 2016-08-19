//
//  PPJSDCollectionView.m
//  Blok
//
//  Created by Alex Padalko on 9/27/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import "PPJSDCollectionView.h"
#import "PPJSDDirectorProtocol.h"
#import "PPJSDMutableArray.h"
#import "PPJSDMappingObject.h"
#import "PPJSDObjectProtocol.h"
#import "PPJSDCollectionViewCell.h"

#import "PPJSDCollectionReusableView.h"
@interface PPJSDCollectionView() 

@property (nonatomic,retain)NSMutableArray * registedCells;

@end
@implementation PPJSDCollectionView
@synthesize dynamicDirector=_dynamicDirector;
@synthesize baseDirector=_baseDirector;
@synthesize PPJSD_items=_PPJSD_items;
@synthesize specifier;
-(NSMutableArray *)registedCells{
    
    if (!_registedCells) {
        _registedCells=[[NSMutableArray alloc] init];
    }
    return _registedCells;
}
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self=[super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.displayType=PPJSDCollectionViewDisplayTypeAsSecions;
        
        [self setDataSource:self];
        
        [self setDelegate:self];
           [self registerClass:[PPJSDCollectionReusableView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"aa_header_indif"];
        
        [self registerClass:[PPJSDCollectionViewCell class] forCellWithReuseIdentifier:@"aa_cell_indif"];
        
    }
    return self;
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.displayType==PPJSDCollectionViewDisplayTypeAsSecions) {
        [self.baseDirector PPJSD_didSelectItem:[self objectForIndex:indexPath.section] atIndexPath:indexPath];
    }else{
         [self.baseDirector PPJSD_didSelectItem:[self objectForIndex:indexPath.row] atIndexPath:indexPath];
    }
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(CGSize)getSize{
    
    return [self frame].size;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
          [[self objectForIndex:indexPath.section] responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableViewCollectionView, PPJSDMRPostionTypeDefault, PPJSDMappingRequestDataTypeViewWillAppear) withAditionalData:[NSNumber numberWithInteger:indexPath.row] andSpecifier:self.specifier];
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
       [[self objectForIndex:indexPath.section] responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableViewCollectionView, PPJSDMRPostionTypeDefault, PPJSDMappingRequestDataTypeViewWillDissapear) withAditionalData:[NSNumber numberWithInteger:indexPath.row] andSpecifier:self.specifier];
}
//-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
//    
//          [[self objectForIndex:indexPath.section] responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableViewCollectionView, PPJSDMRPostionTypeDefault, PPJSDMappingRequestDataTypeViewWillDissapear) withAditionalData:[NSNumber numberWithInteger:indexPath.row] andSpecifier:self.specifier];
//}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     if (self.displayType==PPJSDCollectionViewDisplayTypeAsSecions) {
         return  [[[self objectForIndex:section] responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableViewCollectionView, 0, PPJSDMappingRequestDataTypeSubItemsCount) withAditionalData:nil  andSpecifier:self.specifier] integerValue];

     }else{
             return [self.PPJSD_items count];
     }

    
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
            PPJSDMappingObject * object;
         object =   [[self objectForIndex:indexPath.section] responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableViewCollectionView, PPJSDMRPostionTypeHeader, PPJSDMappingRequestDataTypeMappingObject) withAditionalData:[NSNumber numberWithInteger:indexPath.section] andSpecifier:self.specifier];
        
      PPJSDCollectionReusableView * v =  [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"aa_header_indif" forIndexPath:indexPath];
        
        if (!v.displayView) {
            [v setDisplayView:self.globalHeaderView];
        }
        
        return v;
    }
    
    return nil;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    PPJSDMappingObject * object;
    
    
    if (self.displayType==PPJSDCollectionViewDisplayTypeAsSecions) {
          object =   [[self objectForIndex:indexPath.section] responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableViewCollectionView, PPJSDMRPostionTypeDefault, PPJSDMappingRequestDataTypeMappingObject) withAditionalData:[NSNumber numberWithInteger:indexPath.row] andSpecifier:self.specifier];
    }else{
          object =   [[self objectForIndex:indexPath.row] responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableViewCollectionView, PPJSDMRPostionTypeDefault, PPJSDMappingRequestDataTypeMappingObject) withAditionalData:[NSNumber numberWithInteger:indexPath.row] andSpecifier:self.specifier];
    }

   
    
   
    
    if (!object) {
        
        
        static NSString * cellIndif = @"aa_cell_indif";
        
        UICollectionViewCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:cellIndif forIndexPath:indexPath];
        
        
        return cell;
    }
    
    
    BOOL initalAdd=NO;
    if (![self.registedCells containsObject:object.indifiter]) {
        initalAdd=YES;
        [self registerClass:[PPJSDCollectionViewCell class] forCellWithReuseIdentifier:object.indifiter];
        [self.registedCells addObject:object.indifiter];
    }
    
    PPJSDCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:object.indifiter forIndexPath:indexPath];
    
    if ( initalAdd || !cell.displayView ) {
        
        
        [cell setDisplayView:[self createDisplayViewFromMappingObject:object]];
    }

    object.viewConfigurateBlock(cell.displayView);
    return cell;
    
    
}
-(UIView<PPJDisplayViewProt>*)createDisplayViewFromMappingObject:(PPJSDMappingObject*)mappingObject{
    return [[mappingObject.viewClass alloc ] init];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.displayType==PPJSDCollectionViewDisplayTypeAsSecions) {
        return self.PPJSD_items.count;
    }else{
            return 1;
    }

    //      return self.items.count;
        
}
    
#pragma mark - helpers 
    
-(id<PPJSDObjectProtocol>)objectForIndex:(NSInteger)index{
     return [self.PPJSD_items objectAtIndex:index];
}
#pragma mark - PPJSDController delegate



-(CGSize)getSizeOfItemAtIndexPath:(NSIndexPath*)indexPath{
    
    if (self.displayType==PPJSDCollectionViewDisplayTypeAsSecions) {
        return [[[self objectForIndex:indexPath.section] responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableView, PPJSDMRPostionTypeDefault, PPJSDMappingRequestDataTypeSize) withAditionalData:[NSNumber numberWithInteger:indexPath.row]  andSpecifier:self.specifier] CGSizeValue];
        
    }else{
        return [[[self objectForIndex:indexPath.row] responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableView, PPJSDMRPostionTypeDefault, PPJSDMappingRequestDataTypeSize) withAditionalData:[NSNumber numberWithInteger:indexPath.row]  andSpecifier:self.specifier] CGSizeValue];
        
    }
    

}

-(void)recivedCostomSignal:(NSInteger)signal{
    

}
-(void)refreshDataAtIndex:(NSInteger)index{
    
    if (self.displayType==PPJSDCollectionViewDisplayTypeAsSecions) {
        
        [self reloadSections:[NSIndexSet indexSetWithIndex:index]];
    }else{
        
        [self reloadData];
//        return;
//        [self reloadItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexSet indexSetWithIndex:index]]];
    }
    
    
}
-(void)dataDidReload{
    [self reloadData];
}
-(void)dataDidUpdated{
    [self reloadData];
}
-(void)dataDidUpdatedFromIndex:(NSInteger)index withObjects:(NSArray*)objects{
    [self reloadData];
}
-(void)dataDidUpdatedAtIndex:(NSInteger)index{
    [self reloadData];
}

@end
