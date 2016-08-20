//
// Created by Alex Padalko on 8/18/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import "PPJApp.h"
#import "PPJFabricPool.h"
@interface PPJApp()
@property  (nonatomic, retain) PPJFabricPool * mainFabric;
@end
@implementation PPJApp {

}


+ (instancetype)create {


    NSData * data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ppj_test" ofType:@"json"]];

    NSError * readError;
    NSDictionary *  dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&readError];
    PPJApp * ppjApp =[self mj_objectWithKeyValues:dict];

    [ppjApp.navigator setPpjApp:ppjApp];

    return  ppjApp;

}

- (void)setClassesScope:(PPJClassesScope *)classesScope {
    _classesScope=classesScope;
    self.servicesFabric=[PPJServicesFabric createWithScope:classesScope.services];
    self.screenFabric=[PPJScreenFabric createWithViewModelsScope:classesScope.viewModels andViewControllersScope:classesScope.viewControllers];
    self.clientsFabric=[PPJClientsFabric createWithScope:classesScope.clients];

    [[PPJFabricPool sharedInstance] addFabric:self.servicesFabric ForRequestType:PPJFabricPoolRequestTypeService];
    [[PPJFabricPool sharedInstance] addFabric:self.clientsFabric ForRequestType:PPJFabricPoolRequestTypeClient];
//    [[self mainFabric] addFabric:self.servicesFabric ForRequestType:PPJFabricPoolRequestTypeManager];

}

- (instancetype)init {

    if (self=[super init]){






    }
    return self;
}






@end