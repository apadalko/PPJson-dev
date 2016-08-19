//
//  MGSDViewController.h
//  Blok
//
//  Created by Alex Padalko on 4/14/15.
//  Copyright © 2015 com.placepixel. All rights reserved..
//

#import "PPJViewController.h"
#import "PPJSDController.h"
#import "PPJSDDirectorViewModel.h"

@interface PPJSDViewController : PPJViewController

@property (nonatomic,retain)PPJSDDirectorViewModel * viewModel;
@property (nonatomic,retain)id<PPJSDControllerViewProtocol> contentView;

@property (nonatomic,retain)Class contentViewClass;


-(void)contentViewDidCreated:(id<PPJSDControllerViewProtocol>)contentView;


-(BOOL)allowAutomaticInputOffset;

-(BOOL)resignResonderOnScroll;

@end
