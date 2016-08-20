//
// Created by Alex Padalko on 8/19/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//
@import JavaScriptCore;
#import "PPJFunction.h"
@interface PPJFunction()



@end

static  JSContext * context;
@implementation PPJFunction {

}


-(id)callFunction:(PPJObject *)caller{

    if (!context){
        context= [JSContext new];

    }

    @try {

        [context evaluateScript:self.js];

        // calling a JavaScript function
        JSValue *jsFunction = context[@"result"];

        NSMutableArray * args = [[NSMutableArray alloc] init] ;
        for(NSString * paramsPath in self.params){

            id var = [caller valueForKeyPath:paramsPath];

        }
//
//        NSString      |       string
//        NSNumber      |   number, boolean
//        NSDictionary    |   Object object
//        NSArray       |    Array object
//        NSDate       |     Date object



        JSValue * value = [jsFunction callWithArguments:args];


       if ([self.result isEqualToString:@"string"]){
           return [value toString];
       } else return nil;

    } @catch (NSException *exception) {
        return nil;

    }


}
-(void)callFunctionInBackground:(PPJObject *)caller complitBlock:(void(^)(id value))complitBlock{

    [PPJQueue switch_to_queue:self.workQuene queueBlock:^{
#pragma mark TODO work with caller queue
        id val  = [self callFunction:caller];

        complitBlock(val);

    }];

}
@end