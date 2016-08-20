//
// Created by Alex Padalko on 8/19/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import "PPJScreenFabric.h"
#import "PPJApp.h"
#import <MJExtension/NSObject+MJProperty.h>

@interface PPJScreenFabric()

@property  (nonatomic, retain)NSDictionary * viewModelsScope;
@property (nonatomic, retain)NSDictionary * viewControllersScope;

@end

@implementation PPJScreenFabric {

}

+ (instancetype)createWithViewModelsScope:(NSDictionary *)viewModelsScope andViewControllersScope:(NSDictionary *)viewControllersScope {
    PPJScreenFabric * screenFabric = [[PPJScreenFabric alloc] init];

    screenFabric.viewControllersScope=viewControllersScope;
    screenFabric.viewModelsScope=viewModelsScope;

    return screenFabric;
}
-(PPJViewModel *)viewModelFromVCClassName:(NSString *)vcClassName data:(id)data{

    PPJViewModel * vm = [self _viewModelFromVCClassName:vcClassName];




    return vm;
}
-(PPJViewModel *)_viewModelFromVCClassName:(NSString *)vcClassName{

    NSDictionary * vcData = [self.viewControllersScope valueForKey:vcClassName];


    Class requaredVMClass = [self findRequredVMClassFromVCClassName:vcClassName];



    if ([vcData valueForKey:@"$view_model"]){
        NSDictionary * viewModelData = [self.viewModelsScope valueForKey:[vcData valueForKey:@"$view_model"]];
        if (viewModelData){

            return [requaredVMClass mj_objectWithKeyValues:viewModelData];

        } else {
            return [[requaredVMClass alloc] init];
        }

    } else{
        return [[requaredVMClass alloc] init];
    }

}
-(PPJViewController *)viewControllerFromVCClassName:(NSString *)vcClassName andVM:(PPJViewModel *)viewModel{

    Class  <PPJViewControllerProt> cl =  [self findRequredVCClassFromVCClassName:vcClassName];

    return [cl createWithViewModel:viewModel];

}


-(PPJViewModel *)viewModelWithData:(NSDictionary *)data{
    return nil;
}

-(Class)findRequredVCClassFromVCClassName:(NSString *)vcClassName{
    NSDictionary * vcData = [self.viewControllersScope valueForKey:vcClassName];
    Class coreVCClass=NSClassFromString(vcClassName);
    if (coreVCClass){
        return coreVCClass;
    } else{
        NSString * superClassName = [vcData valueForKey:@"$super"];
        if (!superClassName){
#pragma mark TODO - make auto find depend on VM
            return [PPJViewController class];

        } else{
            return  [self findRequredVCClassFromVCClassName:superClassName];
        }
    }



}
-(Class)findRequredVMClassFromVCClassName:(NSString *)vcClassName {

    NSDictionary * vcData = [self.viewControllersScope valueForKey:vcClassName];
    NSString * requearedVCSubclass;
    Class coreVCClass=NSClassFromString(vcClassName);
    NSString * viewModelClass = [vcData valueForKey:@"$view_model"];
    Class coreVMClass = NSClassFromString(viewModelClass);
    if (coreVMClass){
        return coreVMClass;
    }

    if (!coreVCClass){
        NSString * superClassName = [vcData valueForKey:@"$super"];
        if (!superClassName){
            return [PPJViewModel class];
        } else{
            return  [self findRequredVMClassFromVCClassName:superClassName];
        }
    } else {

        __block MJProperty * foundedPropery;
        [coreVCClass mj_enumerateProperties:^(MJProperty *property, BOOL *stop) {

            if ([property.name isEqualToString:@"viewModel"]){
                foundedPropery=property;
                *stop=YES;
            }

        }];

        if (foundedPropery){
            Class  cl =foundedPropery.type.typeClass;
            if ([cl isSubclassOfClass:[PPJViewModel class]]||[cl isKindOfClass:[PPJViewModel class]])
              return  cl;
            else  return [PPJViewModel class];

        } else{
            return [PPJViewModel class];
        }


    }

}
@end