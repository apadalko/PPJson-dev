//
// Created by Alex Padalko on 8/19/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PPJViewController.h"
#import "PPJViewModel.h"
#import "PPJClassesScope.h"
@interface PPJScreenFabric : NSObject

+(instancetype)createWithViewModelsScope:(NSDictionary *)viewModelsScope andViewControllersScope:(NSDictionary *)viewControllersScope;

//-(PPJViewModel *)viewModelFromRoute:(NSString *)route data:(id)data;
-(PPJViewModel *)viewModelFromVCClassName:(NSString *)vcClassName data:(id)data;


-(PPJViewController *)viewControllerFromVCClassName:(NSString *)vcClassName andVM:(PPJViewModel *)viewModel;



@end