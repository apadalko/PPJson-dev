//
//  UIColor+HEX.h
//  Nextplorer
//
//  Created by Alex Padalko on 1/25/15.
//  Copyright (c) 2015 metaio, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HEX)
+ (UIColor *) colorFromHexString:(NSString *)hexString;
- (BOOL)isEqualToColor:(UIColor *)otherColor;

- (NSString *)hexStringFromColor;
@end
