//
//  MGSDDynamicViewController.m
//  Blok
//
//  Created by Alex Padalko on 4/14/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJSDDynamicViewController.h"




@interface PPJSDDynamicViewController ()

@property (nonatomic,retain)UIRefreshControl *refreshControl ;

@end

@implementation PPJSDDynamicViewController
@synthesize viewModel=_viewModel;
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.contentView reloadData];
}
-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self.contentView setDynamicDirector:self.viewModel];
    
    [RACObserve(self.viewModel, errorSignal) subscribeNext:^(id x) {
       
        if (x) {
     
        }
        
    }];
    
    [RACObserve(self.viewModel, emptyStateSignal) subscribeNext:^(id x) {
       
        if (x) {
                
        }
        
    }];
    
    
    if (self.enablePullToRefresh) {
   
        
        @weakify(self)
        [[self.viewModel.loadItemsCommand executionSignals] subscribeNext:^(RACSignal * x) {
            [[x dematerialize] subscribeError:^(NSError *error) {
                    @strongify(self)
                   [self.refreshControl endRefreshing];
            } completed:^{
                
                
                @strongify(self)
                if (! self.refreshControl) {
                    self.refreshControl = [[UIRefreshControl alloc] init];
                    
                    self.refreshControl.tintColor = [UIColor blackColor];
                    [self.refreshControl addTarget:self
                                            action:@selector(reloadTable)
                                  forControlEvents:UIControlEventValueChanged];
                }
                
                [(UIView*)self.contentView insertSubview:self.refreshControl atIndex:0];
                [self.refreshControl endRefreshing];
                
                
             
            } ];
            
            
        }];
        
    }
  
    
}

-(void)reloadTable{
    
    
  //  static BOOL first=NO;
    
    if ([[self.viewModel.loadItemsCommand executing] not]) {
        
        [self.viewModel.loadItemsCommand execute:[NSNumber numberWithInteger:MGLoadItemsTypeReload]];
        
        
        
    }
}

-(BOOL)shouldControllNavigation{
    return YES;
}
-(BOOL)enablePullToRefresh{
    return YES;
}
@end
