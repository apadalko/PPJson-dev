//
//  MGPPJSDMultipleViewController.m
//  Blok
//
//  Created by Alex Padalko on 5/6/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJSDMultipleContentViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
//#import "MGFeedLoadingView.h"

#import "PPJSDMultipleContentPageCell.h"

#import "PPJSDTableView.h"

//#import "TLYShyNavBarManager.h"


@interface MCCollectionVIew : UICollectionView

@end
@implementation MCCollectionVIew


-(void)setFrame:(CGRect)frame{
    
    [super setFrame:frame];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0){
    
    
    
    if(otherGestureRecognizer.view.tag==-777){
        
        return YES;
    }
    return NO;
    
}

@end


@interface PPJSDMultipleContentViewController(){
    
}


@property (nonatomic)float currentOffser;

@property (nonatomic,retain)NSMutableDictionary * refreshControlDict;

@end
@implementation PPJSDMultipleContentViewController
@synthesize viewModel=_viewModel;
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
      if (self.hideNavBarOnScroll) {

      }
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.hideNavBarOnScroll) {
        [(UIView*)self.selectionView  setFrame:CGRectMake(0, 0, self.view.frame.size.width, [self heightForSelectorView])];
        
        [self.containerView reloadData];
    }

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}
-(BOOL)hideNavBarOnScroll{
    return NO;
}
-(void)setTopOffset:(float)topOffset{
    self.currentOffser=topOffset;
    _topOffset=topOffset;
}
-(void)setContentViewInset:(UIEdgeInsets)contentViewInset{
    
    _contentViewInset=contentViewInset;
    
    [self.view setNeedsLayout];
    
}
-(void)viewDidLoad{
    [super viewDidLoad];
    _contentViewInset=UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.topOffset=0;
    self.currentOffser=0;
    self.refreshControlDict=[[NSMutableDictionary alloc] init];
    
    
    
    

    self.containerTopOffset=0;
    
    
    
    UICollectionViewFlowLayout * fl =    [[UICollectionViewFlowLayout alloc] init];
    
    fl.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    [fl setMinimumInteritemSpacing:0];
    [fl setMinimumLineSpacing:0];
    
    
    
    
    self.containerView=[[MCCollectionVIew alloc] initWithFrame:CGRectZero collectionViewLayout:fl];
    [self.containerView setDataSource:self];
    [self.containerView setDelegate:self];
    [self.containerView setPagingEnabled:YES];
    
    
    for(NSInteger a= 0;a<self.viewModel.segmentsCount;a++){
           [self.containerView registerClass:[self classForPageCellForPageAtIndex:a] forCellWithReuseIdentifier:[NSString stringWithFormat:@"cell_indif_%ld",a]];
    }
    [self.containerView setBackgroundColor:[UIColor whiteColor]];
    self.containerView.scrollsToTop=NO;
    [self.containerView setBackgroundColor:[UIColor purpleColor]];
    [self.view addSubview:self.containerView];
    
    
    if ([self pageSelectorClass]&&!self.selectionView) {
        self.selectionView=[self.pageSelectorClass create];
        [self.selectionView setPageView:self.containerView];
        [self.view addSubview:(UIView*)self.selectionView];
    }else if (self.selectionView){
        [self.selectionView setPageView:self.containerView];
        [self.view addSubview:(UIView*)self.selectionView];
    }

    
     
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.containerView setBackgroundColor:[UIColor whiteColor]];
    
    [self.containerView setContentOffset:CGPointMake(self.view.frame.size.width*self.viewModel.selectedIndex, 0) animated:NO];
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.containerView flashScrollIndicators];
    [self.containerView setContentOffset:CGPointMake(self.containerView.frame.size.width*self.viewModel.selectedIndex, 0)];
    
    
    
    
    [self.selectionView setSegmetsCount:self.viewModel.segmentsCount];
    
    for (int a=0    ;a<self.selectionView.buttonsArray.count;a++){
        
        
        [self.selectionView setTitile:[self selectorTitleForIndex:a] forIndex:a];
//        
//        UIButton * but=[self.selectionView.buttonsArray objectAtIndex:a];
//        NSString * t=[self selectorTitleForIndex:a];
//        [but setTitle:t forState:UIControlStateNormal];
//        [but setTitle:t forState:UIControlStateSelected];
//        [but setTitle:t forState:UIControlStateHighlighted];
    
    }
    @weakify(self);
[RACObserve(self.viewModel, scrollToIndexSignal) subscribeNext:^(RACSignal * sig) {
   
    if (sig) {
        [sig subscribeNext:^(id x) {
            if (x) {
                @strongify(self);
                if ([x isKindOfClass:[NSArray class]]) {
                    [self.containerView setContentOffset:CGPointMake([[x firstObject] integerValue]*self.containerView.frame.size.width, self.containerView.contentOffset.y) animated:YES];
                    //                [self didFinishScroll];
                    
                    
                    for (id<PPJSDMultipleContentPageProt>page in [self.containerView visibleCells]) {
                        
                        [(UIScrollView*)[page innerListView]  setContentOffset:CGPointMake(0, 0)animated:[[x lastObject] boolValue]];
                    }
                }else{
                    [self.containerView setContentOffset:CGPointMake([x integerValue]*self.containerView.frame.size.width, self.containerView.contentOffset.y) animated:YES];
                    //                [self didFinishScroll];
                    
                    
                    for (id<PPJSDMultipleContentPageProt>page in [self.containerView visibleCells]) {
                        
                        [(UIScrollView*)[page innerListView]  setContentOffset:CGPointMake(0, 0)animated:NO];
                    }
                }

            }
            
        }];
        
        
   

    }
    
}];
    
    [RACObserve(self.viewModel, rebuildSegmentSignal)subscribeNext:^(RACSignal * sig) {
        
        if (sig) {
            [sig subscribeNext:^(id x) {
                if (x) {
                      @strongify(self);
                    NSInteger idx = [x integerValue];
                    
                    [[self viewModel] removeDataHolderAtIdx:idx];
                    [self.refreshControlDict removeObjectForKey:[NSString stringWithFormat:@"s_%ld",idx]];
                    [self.containerView reloadData];
                }
                
            }];
        }
        
        
    }];
    
}
-(void)didFinishScroll{
    
    [self.selectionView didEndScrollWithOffset:self.containerView.contentOffset.x ];
    
}
-(NSString *)selectorTitleForIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"%ld",(long)index];
}
-(float)heightForSelectorView{
    return 44.0;
}
-(BOOL)shouldIgnoreTabBar{
    return YES;
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    float additionalOffset=0;
    if (self.navigationController.navigationBar.translucent) {
        additionalOffset=44;//CGRectGetMaxY(self.navigationController.navigationBar.frame);
    }else{
        
    }
    if (self.hideNavBarOnScroll) {
          [self.containerView setFrame:CGRectMake(0+self.contentViewInset.left,self.currentOffser+additionalOffset-self.contentViewInset.top+self.containerTopOffset, self.view.frame.size.width-self.contentViewInset.left-self.contentViewInset.right, self.view.frame.size.height-50-additionalOffset-self.contentViewInset.bottom-self.contentViewInset.top)];
    }else{
        
        if (self.selectionView) {
            [(UIView*)self.selectionView  setFrame:CGRectMake(0, self.currentOffser+additionalOffset, self.view.frame.size.width, [self heightForSelectorView])];
            
            CGRect r =CGRectMake(0+self.contentViewInset.left,
                                 CGRectGetMaxY([(UIView*)self.selectionView frame])+self.contentViewInset.top+self.containerTopOffset, self.view.frame.size.width-self.contentViewInset.left-self.contentViewInset.right,
                                 self.view.frame.size.height-([self shouldIgnoreTabBar]?0:50)-CGRectGetMaxY([(UIView*)self.selectionView frame]) -self.contentViewInset.top-self.contentViewInset.bottom );
            [self.containerView setFrame:r];
        }else{
            [(UIView*)self.selectionView  setFrame:CGRectMake(0, self.currentOffser+additionalOffset+self.containerTopOffset, self.view.frame.size.width, [self heightForSelectorView])];
            float y =(self.currentOffser+additionalOffset)+self.contentViewInset.top;
            CGRect r =CGRectMake(0+self.contentViewInset.left,y+self.containerTopOffset
                                , self.view.frame.size.width-self.contentViewInset.left-self.contentViewInset.right,
                                 self.view.frame.size.height-([self shouldIgnoreTabBar]?0:50)-(self.currentOffser+additionalOffset) -self.contentViewInset.top-self.contentViewInset.bottom );
            [self.containerView setFrame:r];
        }
    
        
    }
    
  //  [self.selectionView  setFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, 44)];
  
    
    [(UICollectionViewFlowLayout * )self.containerView.collectionViewLayout setItemSize:CGSizeMake(self.containerView.frame.size.width, self.containerView.frame.size.height) ];
    
    
}

#pragma mark - collectionviewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.viewModel.segmentsCount;
    
}
-(BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    
    
    return YES;
}
-(void)reloadSegmentTable:(UIRefreshControl*)rControll{
    
    if ([[[self.viewModel loadCommandForSegment:rControll.tag] executing] not]) {
        [[self.viewModel loadCommandForSegment:rControll.tag] execute:[NSNumber numberWithInteger:1]];
    }
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (!decelerate) {
        [self.viewModel setSelectedIndex:scrollView.contentOffset.x/scrollView.frame.size.width];
       // self.shyNavBarManager.scrollView = [[[self.containerView visibleCells] firstObject] innerListView];
        [self didFinishScroll];
    }
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
        [self.viewModel setSelectedIndex:scrollView.contentOffset.x/scrollView.frame.size.width];
    [self didFinishScroll];
      //   self.shyNavBarManager.scrollView = [[[self.containerView visibleCells] firstObject] innerListView];
    
}
-(void)scrollDidScroll{
    
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  
        [self.viewModel setSelectedIndex:scrollView.contentOffset.x/scrollView.frame.size.width];
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString * indif = [NSString stringWithFormat:@"cell_indif_%ld",(long)indexPath.row];
    
    PPJSDMultipleContentPageCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:indif forIndexPath:indexPath];
    
        
        if (! [self.refreshControlDict valueForKey:[self.viewModel segmentKey:indexPath.row]]) {
                
            [cell setInnerListView:[self viewForSegment:indexPath.row]];
            [self.viewModel bindSmartView:cell.innerListView atSegment:indexPath.row];
            [cell.innerListView setBaseDirector:[self.viewModel dataHolderForSegment:indexPath.row]];
            [cell.innerListView setDynamicDirector:[self.viewModel dataHolderForSegment:indexPath.row]];
            UIRefreshControl * rControll = [[UIRefreshControl alloc] init];
            [rControll setTintColor:[UIColor blackColor]];
            rControll.tag=indexPath.row;
            
            [self.refreshControlDict setValue:rControll forKey:[self.viewModel segmentKey:indexPath.row]];
            @weakify(self)
            [[[(UIScrollView*)cell.innerListView rac_signalForSelector:@selector(scrollViewWillBeginDragging:)]
             takeUntilBlock:^BOOL(id x) {
                 @strongify(self);
                 if (self) {
                     return NO;
                 }else{
                     return YES;
                 }
             } ]

             
             subscribeNext:^(id x) {
                @strongify(self);
                [self scrollDidScroll];
                
                
            }];
            @weakify(cell)
            [[[self.viewModel loadCommandForSegment:indexPath.row] executionSignals] subscribeNext:^(RACSignal * x) {
                [[x dematerialize] subscribeError:^(NSError *error) {
                      @strongify(self)
                         UIRefreshControl * rControl=[self.refreshControlDict valueForKey:[self.viewModel segmentKey:indexPath.row]];
                    [rControl endRefreshing];
                } completed:^{
                    
                
                    
                    @strongify(self)
                    if ([self enablePullToRefresh]) {
                        UIRefreshControl * rControl=[self.refreshControlDict valueForKey:[self.viewModel segmentKey:indexPath.row]];
                        if (! rControll.superview) {
                            
                            
                            rControl.tintColor = [UIColor blackColor];
                            [rControl addTarget:self
                                         action:@selector(reloadSegmentTable:)
                               forControlEvents:UIControlEventValueChanged];
                        }
                        @strongify(cell);
                        [(UIView*)cell.innerListView insertSubview:rControll atIndex:0];
                        [rControll endRefreshing];
                    }
           
                    
                    
                    
                }];
                
                
            }];
            if ([self automaticLoadOnAppear]) {
                            [[self.viewModel loadCommandForSegment:indexPath.row] execute:nil];
            }
            
                  [self didCreatePageCell:cell forSegment:indexPath.row];

        }
        
 
    if (self.hideNavBarOnScroll) {
//          self.shyNavBarManager.scrollView =cell.innerListView; 
    }
    
        
           [cell.innerListView reloadData];
    
      
    
    return cell;
}
-(BOOL)enablePullToRefresh{
    
    return YES;
}
-(BOOL)automaticLoadOnAppear{
    return YES;
}


-(void)didCreatePageCell:(id<PPJSDMultipleContentPageProt>)pageCell{
    
    
}
-(id<PPJSDControllerViewProtocol>)viewForSegment:(NSInteger)segment{
    PPJSDTableView * innerListView=[[PPJSDTableView alloc] init];
    [innerListView setResignResponderOnScroll:YES];
    [innerListView setBackgroundColor:[UIColor orangeColor]];
           [innerListView setBackgroundColor:[UIColor whiteColor]];
            [innerListView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  
    return innerListView;
    
    
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(PPJSDMultipleContentPageCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.viewModel viewAtIndexBecomeVisible:indexPath.row];
    

}
-(BOOL)shouldControllNavigation{
    return YES;
}
-(Class<PPJSDMultipleContentPageProt>)classForPageCellForPageAtIndex:(NSInteger)idx{
    
    return [PPJSDMultipleContentPageCell class];
}
-(Class<PPJSDMultipleContentPageSelectorProt>)pageSelectorClass{
    
    return [PPJSDMultipleContentPageSelectorView class];
}
-(void)didCreatePageCell:(id<PPJSDMultipleContentPageProt>)pageCell forSegment:(NSInteger)segment{
    
    
}

@end
