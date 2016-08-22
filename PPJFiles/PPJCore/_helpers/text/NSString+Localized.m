//
//  NSString+Localized.m
//  Magra 2.0
//
//  Created by Alex Padalko on 1/27/15.
//  Copyright (c) 2015 Alex Padalko. All rights reserved.
//

#import "NSString+Localized.h"

@implementation NSString (Localized)
static NSDictionary*locExData;
-(NSString*)localized{
//    return @"fuck";
     return NSLocalizedString(self, nil);
}

@end
