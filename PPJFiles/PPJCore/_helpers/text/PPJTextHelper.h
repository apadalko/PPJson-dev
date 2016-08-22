//
// Created by Alex Padalko on 8/21/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSString+Localized.h"
#import <UIKit/UIColor.h>
#import <UIKit/UIFont.h>
#import "NSString+Localized.h"
@interface PPJTextHelper : NSObject
@end

@interface PPJStringSelectionObject : NSObject
+(instancetype)createWithRange:(NSRange)r color:(UIColor*)color font:(UIFont*)font type:(NSString*)type andValue:(NSString*)value;
@property (nonatomic)NSRange range;
@property (nonatomic,retain)UIColor * selectionColor;
@property (nonatomic,retain)UIFont * selectionFont;
@property (nonatomic,retain)NSString * type;
@property (nonatomic,retain)NSString * vlaue;
@end

@interface NSMutableAttributedString (PPJSelectionFinder)

-(NSArray*)ppj_findAndSelect:(NSString*)finder color:(UIColor *)selectionColor font:(UIFont*)font removeFinder:(BOOL)removeFinder;

@end
@interface NSAttributedString (PPJStringSize)
-(CGSize)ppj_sizeOfStringWithAvailableSize:(CGSize)size;
@end
@interface NSString (PPMEmojiString)
-(BOOL)ppj_onlyEmojiString:(NSInteger*)foundEmojis;
-(BOOL)ppj_onlyEmojiString;

@end