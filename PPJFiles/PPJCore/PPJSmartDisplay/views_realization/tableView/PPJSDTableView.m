//
//  PPJSDTableView.m
//  PPJSmartDisplay
//
//  Created by Alex Padalko on 4/13/15.
//  Copyright (c) 2015 Alex Padalko. All rights reserved.
//

#import "PPJSDTableView.h"
#import "PPJSDObject.h"
#import "PPJSDTableViewCell.h"
#import "PPJSDTableViewHeaderFooterView.h"
@interface PPJSDTableView()
{
    
    
}
@property (nonatomic)NSInteger loadCellPosition;
@property (nonatomic)BOOL shouldShowLoadCell;
@property (nonatomic)BOOL shouldShowStateCell;

//
@property (nonatomic)CGSize deltaSize;
@end
@implementation PPJSDTableView
@synthesize dynamicDirector=_dynamicDirector;
@synthesize PPJSD_items=_PPJSD_items;
@synthesize specifier;
@synthesize baseDirector=_baseDirector;
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self=[super initWithFrame:frame style:style]) {
        
        [self setDelegate:self];
        _deltaSize=CGSizeZero;
        [self setDataSource:self];
        
        _displayType=PPJSDTableViewDisplayTypeOneObejectOneSection;
        
    }
    return self;
}
-(void)setContentInset:(UIEdgeInsets)contentInset{
    [super setContentInset:contentInset];
    [self setScrollIndicatorInsets:contentInset];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0){
    
    
    
    if(otherGestureRecognizer.view.tag==-777){
        
        return YES;
    }
    return NO;
    
}
-(CGSize)getSize{
    
    return [self frame].size;
}
-(void)setBaseDirector:(id<PPJSDirectorProtocol>)baseDirector{
    _baseDirector=baseDirector;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
  
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   id<PPJSDObjectProtocol>  obj = [self objectForIndex:indexPath.section];
    
    if ([obj conformsToProtocol:@protocol(PPJSDLoadObjectProt)]) {
        
        id<PPJSDObjectProtocol,PPJSDLoadObjectProt>  loadObject =[self.dynamicDirector PPJSD_loadCellObject];
        
        
        [loadObject setLoadState:PPJSDLoadStateTypeLoading];
        
        @weakify(loadObject);
        [[[self.dynamicDirector PPJSD_loadNextPageCommand] execute:nil] subscribeError:^(NSError *error) {
            @strongify(loadObject);
            
            if (![error.userInfo valueForKey:RACUnderlyingCommandErrorKey]) {
                [loadObject setLoadState:PPJSDLoadStateTypeFail];
            }else{
             
            }
            
            
        } completed:^{
             [loadObject setLoadState:PPJSDLoadStateTypeNone];
            
        }];
        
        return;
    }
    
    [self.baseDirector PPJSD_didSelectItem:[self.PPJSD_items objectAtIndex:indexPath.section] atIndexPath:indexPath];
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.resignResponderOnScroll) {
        [self endEditing:YES];
    }
    
}
#pragma mark - views
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id<PPJSDObjectProtocol> PPJSDObj = [self objectForIndex:indexPath.section];
    PPJSDMappingObject * object =   [PPJSDObj responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableView, PPJSDMRPostionTypeDefault, PPJSDMappingRequestDataTypeMappingObject) withAditionalData:[NSNumber numberWithInteger:indexPath.row] andSpecifier:self.specifier];
    
    if (!object) {
 
    
    static NSString * cellIndif = @"aa_cell_indif";
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellIndif];
    
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndif];
    }
        
   
     
    
    return cell;
}
    if ([PPJSDObj conformsToProtocol:@protocol(PPJSDLoadObjectProt)]) {
        id<PPJSDObjectProtocol,PPJSDLoadObjectProt>  loadObject =(        id<PPJSDObjectProtocol,PPJSDLoadObjectProt> )PPJSDObj;
        if ([loadObject loadState]!=PPJSDLoadStateTypeLoading) {
            [loadObject setLoadState:PPJSDLoadStateTypeNone];
        }
    }else if([PPJSDObj conformsToProtocol:@protocol(PPJSDStateObjectProt)]){
        id<PPJSDObjectProtocol,PPJSDStateObjectProt>  stateObject =( id<PPJSDObjectProtocol,PPJSDStateObjectProt> )PPJSDObj;
        

        [stateObject setAvailableSize:CGSizeMake(self.frame.size.width, MAX(130, self.frame.size.height-(self.contentSize.height-[stateObject availableSize].height)-self.contentInset.top-self.contentInset.bottom))];
    }
    
    
    PPJSDTableViewCell * cell=[self dequeueReusableCellWithIdentifier:object.indifiter];
    
    if (!cell) {
        cell=[[PPJSDTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:object.indifiter];
        
      
        [cell setDisplayView:[[object.viewClass alloc] init]];
        
    }
    object.viewConfigurateBlock(cell.displayView);
    
    if (self.shouldCopyTransform) {
        cell.transform=self.transform;
    }
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    PPJSDMappingObject * object =   [[self objectForIndex:section] responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableView, PPJSDMRPostionTypeHeader, PPJSDMappingRequestDataTypeMappingObject) withAditionalData:nil andSpecifier:self.specifier];
    if (!object) {
        return nil;
    }
    PPJSDTableViewHeaderFooterView  * cell=[self dequeueReusableHeaderFooterViewWithIdentifier:object.indifiter];

    
    if (!cell) {
        cell=[[PPJSDTableViewHeaderFooterView  alloc] initWithReuseIdentifier:object.indifiter];
        [cell setDisplayView:[[object.viewClass alloc] init]];
    }
    object.viewConfigurateBlock(cell.displayView);
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    PPJSDMappingObject * object =   [[self objectForIndex:section] responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableView, PPJSDMRPostionTypeFooter, PPJSDMappingRequestDataTypeMappingObject) withAditionalData:nil andSpecifier:self.specifier];
    if (!object) {
        return nil;
    }
    PPJSDTableViewHeaderFooterView  * cell=[self dequeueReusableHeaderFooterViewWithIdentifier:object.indifiter];
    
 

    if (!cell) {
        cell=[[PPJSDTableViewHeaderFooterView  alloc] initWithReuseIdentifier:object.indifiter];
        [cell setDisplayView:[[object.viewClass alloc] init]];
    }
    object.viewConfigurateBlock(cell.displayView);
    
 
    
    return cell;
}
#pragma mark - counts
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    NSInteger a =[[[self objectForIndex:section] responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableView, 0, PPJSDMappingRequestDataTypeSubItemsCount) withAditionalData:nil  andSpecifier:self.specifier] integerValue];

    
    return a ;
    
    
}
-(void)reloadData{
    [super reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger sections = self.PPJSD_items.count;
    

        
        
        
    if ([self.dynamicDirector PPJSD_shouldShowLoadCell]==PPJSDShowTypeYES&&[[self dynamicDirector] PPJSD_currentState]==PPJSDLoadStateTypeNone) {
        
        sections++;
        _shouldShowLoadCell=YES;
        _shouldShowStateCell=NO;
        self.loadCellPosition=[self.dynamicDirector PPJSD_loadCellPosition];
        
        return sections;
        
    }else {
        _shouldShowLoadCell=NO;
        _shouldShowStateCell=NO;
        if ([self.dynamicDirector PPJSD_shouldShowInitialLoader]==PPJSDShowTypeYES&&[[self dynamicDirector] PPJSD_currentState]==PPJSDLoadStateTypeLoading) {
            
            sections++;
            _shouldShowStateCell=YES;
            
        }
        else  if ([self.dynamicDirector PPJSD_shouldShowEmptyView]==PPJSDShowTypeYES&&[[self dynamicDirector] PPJSD_currentState]==PPJSDLoadStateTypeEmpty) {
            
            sections++;
            _shouldShowStateCell=YES;
            
        }
        else  if ([self.dynamicDirector PPJSD_shouldShowErrorView]==PPJSDShowTypeYES&&[[self dynamicDirector] PPJSD_currentState]==PPJSDLoadStateTypeFail) {
            
            sections++;
            _shouldShowStateCell=YES;
            
        }
        return sections;
    }
    
    
//    return self.items.count;
}
#pragma mark - ppjpears


-(BOOL)isSectionForLoadCell:(NSInteger)section{
    
    if (self.PPJSD_items.count==0) {
        return  NO;
    }
    
    if (self.shouldShowLoadCell) {
        
        if (self.loadCellPosition<0) {
            if (section<self.PPJSD_items.count) {
                return NO;
            }else{
                return YES;
            }
            
        }else{
            if (section!=self.loadCellPosition) {
                return NO;
            }else{
                return YES;
            }
        }
        
    }else{
        return NO;
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id<PPJSDObjectProtocol> obj =[self objectForIndex:indexPath.section];
    
    [obj responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableView, PPJSDMRPostionTypeDefault, PPJSDMappingRequestDataTypeViewWillAppear) withAditionalData:[NSNumber numberWithInteger:indexPath.row] andSpecifier:self.specifier];
    
    
    if ([obj conformsToProtocol:@protocol(PPJSDLoadObjectProt)]) {
        
        
        @weakify(self);
        
        id<PPJSDObjectProtocol,PPJSDLoadObjectProt>  loadObject =[self.dynamicDirector PPJSD_loadCellObject];
        
        if ([loadObject loadState]!=PPJSDLoadStateTypeLoading&&[loadObject shouldLoadAutomatic  ]) {
            
//               [loadObject setLoadState:PPJSDLoadStateTypeLoading];
            [[[self.dynamicDirector PPJSD_loadNextPageCommand] execute:nil] subscribeError:^(NSError *error) {
                @strongify(self);
                
                if (![error.userInfo valueForKey:RACUnderlyingCommandErrorKey]) {
                    [[self.dynamicDirector PPJSD_loadCellObject] setLoadState:PPJSDLoadStateTypeFail];
                }
//                     [[self.dynamicDirector PPJSD_loadCellObject] setLoadState:PPJSDLoadStateTypeFail];
                
            } completed:^{
                
                     [[self.dynamicDirector PPJSD_loadCellObject] setLoadState:PPJSDLoadStateTypeNone];
            }];
        }
    }
    
  
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
        [[self objectForIndex:indexPath.section] responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableView, PPJSDMRPostionTypeDefault, PPJSDMappingRequestDataTypeViewWillDissapear) withAditionalData:[NSNumber numberWithInteger:indexPath.row] andSpecifier:self.specifier];
     
}
#pragma mark - heighes

-(CGSize)getSizeOfItemAtIndexPath:(NSIndexPath*)indexPath{
       return [[[self objectForIndex:indexPath.section] responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableView, PPJSDMRPostionTypeDefault, PPJSDMappingRequestDataTypeSize) withAditionalData:[NSNumber numberWithInteger:indexPath.row]  andSpecifier:self.specifier] CGSizeValue];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  return [[[self objectForIndex:section] responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableView, PPJSDMRPostionTypeHeader, PPJSDMappingRequestDataTypeSize) withAditionalData:nil  andSpecifier:self.specifier] CGSizeValue].height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
 return [[[self objectForIndex:indexPath.section] responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableView, PPJSDMRPostionTypeDefault, PPJSDMappingRequestDataTypeSize) withAditionalData:[NSNumber numberWithInteger:indexPath.row]  andSpecifier:self.specifier] CGSizeValue].height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [[[self objectForIndex:section] responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableView, PPJSDMRPostionTypeFooter, PPJSDMappingRequestDataTypeSize) withAditionalData:nil  andSpecifier:self.specifier] CGSizeValue].height;
}
#pragma mark - PPJSDController delegate
-(void)recivedCostomSignal:(NSInteger)signal{
    
    if (signal==-10001) {
        [self beginUpdates];
    }else if (signal==-10002){
        [self endUpdates];
    }
}
-(void)dataDidReload{

    [self reloadData];
}
-(void)dataDidUpdated{
    [self reloadData];
}
-(void)dataDidUpdatedFromIndex:(NSInteger)index withObjects:(NSArray*)objects{
    
    
    if (self.displayType==PPJSDTableViewDisplayTypeOneObejectOneSection) {
        
        if (index!=0) {
            NSMutableArray * indexPathes =[[NSMutableArray alloc] init];
            
            NSInteger deltaidx = index;
            for (id<PPJSDObjectProtocol> obj in objects ) {
                
                
                NSInteger a =   [[obj responseForMappingRequest:PPJSDMappingRequestMake(PPJSDMRRequesterTypeTableView, PPJSDMRPostionTypeDefault, PPJSDMappingRequestDataTypeSubItemsCount) withAditionalData:nil andSpecifier:self.specifier] integerValue];
                
                for (NSInteger r = 0; r<a; r++) {
                    NSIndexPath * ip = [NSIndexPath indexPathForRow:r inSection:deltaidx];
                    [indexPathes addObject:ip];
                }
                
                
                deltaidx++;
                
            }
            
            [self beginUpdates];
            
            [self deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationNone];
            [self insertSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, [self numberOfSectionsInTableView:self]-index)] withRowAnimation:UITableViewRowAnimationTop];
            //         [self insertRowsAtIndexPaths:indexPathes withRowAnimation:UITableViewRowAnimationAutomatic];
            
            
            
            [self endUpdates];
            
        }else if (index==0){
         [self reloadData];
        }else{
                [self reloadData];
        }

        
        
    }else
    [self reloadData];
}
-(void)dataDidUpdatedAtIndex:(NSInteger)index{
    [self reloadData];
}
-(void)refreshDataAtIndex:(NSInteger)index{
    
     if (self.shouldShowLoadCell) {
         if (self.loadCellPosition<0) {
             
                   [self reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            
           
             
         }else{
             if (index>=self.loadCellPosition) {
                 
                   [self reloadSections:[NSIndexSet indexSetWithIndex:MIN(MAX(0, index+self.loadCellPosition), [self numberOfSections])] withRowAnimation:UITableViewRowAnimationAutomatic];
   
             }else{
  [self reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationAutomatic];
             }
         }

         
     }else
    [self reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationAutomatic];

}



-(id<PPJSDObjectProtocol>)objectForIndex:(NSInteger)index{
    
    if (self.shouldShowStateCell) {
        if (index<self.PPJSD_items.count) {
            return [self.PPJSD_items objectAtIndex:index];
        }else{
           if ([[self dynamicDirector] PPJSD_currentState]==PPJSDLoadStateTypeLoading){
                return [self.dynamicDirector PPJSD_initialLoadCellObject];
            }else if ([[self dynamicDirector] PPJSD_currentState]==PPJSDLoadStateTypeEmpty){
                return [self.dynamicDirector PPJSD_emptyStateObject];
            }else if ([[self dynamicDirector] PPJSD_currentState]==PPJSDLoadStateTypeFail){
                return [self.dynamicDirector PPJSD_errorStateObject];
            }else{
                return nil;
            }
        }
    }else
    if (self.shouldShowLoadCell) {
        
        if (self.loadCellPosition<0) {
            if (index<self.PPJSD_items.count) {
                return [self.PPJSD_items objectAtIndex:index];
            }else{
                return [self.dynamicDirector PPJSD_loadCellObject];
            }
            
        }else{
            if (index!=self.loadCellPosition) {
                return [self.PPJSD_items objectAtIndex:MAX(0, index-self.loadCellPosition)];
            }else{
                return [self.dynamicDirector PPJSD_loadCellObject];
            }
        }
        
    }else{
        return  [self.PPJSD_items objectAtIndex:index];
    }
    

    
}


@end
