//
//  MGPPJSDMultipleViewController.h
//  Blok
//
//  Created by Alex Padalko on 5/6/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJViewController.h"
#import "PPJSDMultipleContentViewModel.h"
#import "PPJSDMultipleContentPageProt.h"
#import "PPJSDMultipleContentPageSelectorProt.h"
#import "PPJSDMultipleContentPageSelectorView.h"
@interface PPJSDMultipleContentViewController : PPJViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,retain)PPJSDMultipleContentViewModel *viewModel;
@property (nonatomic,retain)id<PPJSDMultipleContentPageSelectorProt>  selectionView;


@property (nonatomic,retain)UICollectionView * containerView;
@property (nonatomic)UIEdgeInsets contentViewInset;


-(void)didFinishScroll;
-(void)scrollDidScroll;
-(BOOL)hideNavBarOnScroll;

-(BOOL)enablePullToRefresh;
-(float)heightForSelectorView;
@property (nonatomic)float topOffset;


@property (nonatomic)float containerTopOffset;
-(NSString*)selectorTitleForIndex:(NSInteger)index;



-(id<PPJSDControllerViewProtocol>)viewForSegment:(NSInteger)segment;
-(Class<PPJSDMultipleContentPageProt>)classForPageCellForPageAtIndex:(NSInteger)idx;
-(Class<PPJSDMultipleContentPageSelectorProt>)pageSelectorClass;
-(void)didCreatePageCell:(id<PPJSDMultipleContentPageProt>)pageCell forSegment:(NSInteger)segment;





-(BOOL)shouldIgnoreTabBar;

-(BOOL)automaticLoadOnAppear;
@end
