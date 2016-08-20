//
//  MGSDDynamicViewController.h
//  Blok
//
//  Created by Alex Padalko on 4/14/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJSDViewController.h"


#import "PPJSDDynamicDirectorViewModel.h"

@interface PPJSDDynamicViewController : PPJSDViewController
@property (nonatomic,retain)PPJSDDynamicDirectorViewModel * viewModel;
//@property (nonatomic,retain)MGPPJSDDynamicTableView * contentView;

-(BOOL)enablePullToRefresh;

@end
