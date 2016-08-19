//
//  MGNotificationsPageCell.m
//  Blok
//
//  Created by Alex Padalko on 4/17/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJSDMultipleContentPageCell.h"
//#import "MGLoadingCell.h"
//#import "MGInitialLoadingTableCell.h"

#import "PPJSDTableView.h"
@implementation PPJSDMultipleContentPageCell
@synthesize innerListView=_innerListView;
@synthesize innerListInsets=_innerListInsets;

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [(UIView*)self.innerListView setFrame:UIEdgeInsetsInsetRect(self.bounds, self.innerListInsets)];
}
-(void)setInnerListView:(UIScrollView<PPJSDControllerViewProtocol>*)innerListView{
    
    if (   _innerListView) {
        [(UIView*)_innerListView removeFromSuperview];
    }
    
    _innerListView=innerListView;
    [self addSubview:(UIView*)innerListView];
}
//-(id<PPJSDControllerViewProtocol> )innerListView{
//    
//    if (!_innerListView) {
//        _innerListView=[[PPJSDTableView alloc] init];
//        //[_innerListView setResignResponderOnScroll:YES];
////        [_innerListView setBackgroundColor:[UIColor whiteColor]];
////        [_innerListView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//        [self.contentView addSubview:(UIView*)_innerListView];
////        [_innerListView setInitialCellClass:[MGInitialLoadingTableCell class] andSize:200];
////        [_innerListView setLoadCellClass:[MGLoadingCell class] andSize:84];
//    }
//    
//    return _innerListView;
//}

@end
