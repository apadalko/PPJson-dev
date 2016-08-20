//
// Created by Alex Padalko on 8/18/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import "PPJApp.h"


@implementation PPJApp {

}


+ (instancetype)create {


    NSData * data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ppj_test" ofType:@"json"]];

    NSError * readError;
    NSDictionary *  dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&readError];
    PPJApp * ppjApp =[self mj_objectWithKeyValues:dict];

    [ppjApp.navigator setClassesScope:ppjApp.classesScope];

    return  ppjApp;

}

- (instancetype)init {

    if (self=[super init]){






    }
    return self;
}






@end