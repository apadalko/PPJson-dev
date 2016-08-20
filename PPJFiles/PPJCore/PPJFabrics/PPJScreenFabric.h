//
// Created by Alex Padalko on 8/19/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PPJViewController.h"
#import "PPJViewModel.h"
#import "PPJClassesScope.h"
@interface PPJScreenFabric : NSObject

+(PPJViewModel *)viewModelFromRoute:(NSString *)route data:(id)data classesScope:(PPJClassesScope *)classesScope;
+(PPJViewModel *)viewModelFromVCClassName:(NSString *)vcClassName data:(id)data classesScope:(PPJClassesScope *)classesScope;


+(PPJViewController *)viewControlleFromVCClassName:(NSString *)vcClassName andVM:(PPJViewModel *)viewModel classesScope:(PPJClassesScope *)classesScope;




@end