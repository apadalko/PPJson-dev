//
//  PPFonts.m
//  PlacePixel
//
//  Created by Hung Dinh on 9/24/15.
//  Copyright (c) 2015 com.placepixel. All rights reserved.
//

#import "UIFont+AppFonts.h"
#import <UIKit/UIKit.h>
@implementation UIFont (AppFonts)

+(UIFont*)muesoRounded300WithSize:(float)size{
  return  [UIFont fontWithName:@"MuseoSansRounded-300" size:size];
}
+(UIFont*)muesoRounded500WithSize:(float)size{
   return  [UIFont fontWithName:@"MuseoSansRounded-500" size:size];
}
+(UIFont*)muesoRounded900WithSize:(float)size{
       return [UIFont fontWithName:@"MuseoSansRounded-900" size:size];
}
+(UIFont*)muesoRounded700WithSize:(float)size{
   return [UIFont fontWithName:@"MuseoSansRounded-700" size:size];
}
+(UIFont*)muesoRounded1000WithSize:(float)size{
       return [UIFont fontWithName:@"MuseoSansRounded-1000" size:size];
}



+ (UIFont *)ppTitleFont { return [UIFont fontWithName:@"MuseoSansRounded-500" size:19]; }
+ (UIFont *)ppTitleBoldFont { return [UIFont fontWithName:@"MuseoSansRounded-700" size:19]; }
+ (UIFont *)ppHeaderFont { return [UIFont fontWithName:@"MuseoSansRounded-300" size:17]; }
+ (UIFont *)ppHeaderBoldFont { return [UIFont fontWithName:@"MuseoSansRounded-700" size:17]; }
+ (UIFont *)ppBodyFont { return [UIFont fontWithName:@"MuseoSansRounded-300" size:15]; }
+ (UIFont *)ppBodyMediumFont { return [UIFont fontWithName:@"MuseoSansRounded-500" size:15]; }
+ (UIFont *)ppBodyMediumBoldFont { return [UIFont fontWithName:@"MuseoSansRounded-700" size:15]; }
+ (UIFont *)ppFootnoteFont { return [UIFont fontWithName:@"MuseoSansRounded-500" size:13]; }
+ (UIFont *)ppFootnoteBoldFont { return [UIFont fontWithName:@"MuseoSansRounded-700" size:13]; }


+(UIFont*)ppMediumFontWithSize:(float)size{
    return [UIFont fontWithName:@"MuseoSansRounded-500" size:size];
}
+(UIFont*)ppBoldFontWithSize:(float)size{
    return [UIFont fontWithName:@"MuseoSansRounded-700" size:size];
}

@end