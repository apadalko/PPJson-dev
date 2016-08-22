//
// Created by Alex Padalko on 8/21/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import "PPJTextHelper.h"

#import <UIKit/UIKit.h>
@import JavaScriptCore;
@implementation NSString (PPMEmojiString)

static  JSContext *context;


-(BOOL)ppj_onlyEmojiString:(NSInteger*)foundEmojis{

    if (!context) {


        NSError  *err;
        NSRegularExpression *regex;
        //    regex=[NSRegularExpression regularExpressionWithPattern:@"[\uD800-\\uDBFF][\\uDC00-\\uDFFF]" options:0 error:&err];
        NSString * str=self;
        NSArray *matches = [regex matchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];


        context= [JSContext new];

    }
    NSString * newStr ;

    @try {
        NSString *jsFunctionText =
                @"var isValidNumber = function(string) {"
                        "    var newStr= string.replace(/[\\uD800-\\uDBFF][\\uDC00-\\uDFFF]/g, '{');"
                        "return newStr;"
                        "}";
        [context evaluateScript:jsFunctionText];

        // calling a JavaScript function
        JSValue *jsFunction = context[@"isValidNumber"];
        JSValue *value = [jsFunction callWithArguments:@[ self ]];

        newStr = [value toString];
    } @catch (NSException *exception) {
        return NO;

    }
    // defining a JavaScript function

    *foundEmojis=newStr.length;


    if ([newStr stringByReplacingOccurrencesOfString:@"{" withString:@""].length==0) {

        return YES;
    }

    return NO;
}
-(BOOL)ppj_onlyEmojiString{

    __block BOOL onlyEmoji=YES;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
            ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                BOOL returnValue;
                const unichar hs = [substring characterAtIndex:0];
                // surrogate pair
                if (0xd800 <= hs && hs <= 0xdbff) {
                    if (substring.length > 1) {
                        const unichar ls = [substring characterAtIndex:1];
                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                            returnValue = YES;
                        }
                    }
                } else if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    if (ls == 0x20e3) {
                        returnValue = YES;
                    }

                } else {
                    // non surrogate
                    if (0x2100 <= hs && hs <= 0x27ff) {
                        returnValue = YES;
                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                        returnValue = YES;
                    } else if (0x2934 <= hs && hs <= 0x2935) {
                        returnValue = YES;
                    } else if (0x3297 <= hs && hs <= 0x3299) {
                        returnValue = YES;
                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                        returnValue = YES;
                    }
                }

                if (returnValue){

                }else {
                    onlyEmoji=NO;
                    *stop=YES;
                }

            }];

    return onlyEmoji;
}
- (BOOL)ppj_stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
            ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {

                const unichar hs = [substring characterAtIndex:0];
                // surrogate pair
                if (0xd800 <= hs && hs <= 0xdbff) {
                    if (substring.length > 1) {
                        const unichar ls = [substring characterAtIndex:1];
                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                            returnValue = YES;
                        }
                    }
                } else if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    if (ls == 0x20e3) {
                        returnValue = YES;
                    }

                } else {
                    // non surrogate
                    if (0x2100 <= hs && hs <= 0x27ff) {
                        returnValue = YES;
                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                        returnValue = YES;
                    } else if (0x2934 <= hs && hs <= 0x2935) {
                        returnValue = YES;
                    } else if (0x3297 <= hs && hs <= 0x3299) {
                        returnValue = YES;
                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                        returnValue = YES;
                    }
                }
            }];

    return returnValue;
}

@end



@implementation NSMutableAttributedString (PPMSelectionFinder)

-(NSArray*)ppj_findAndSelect:(NSString*)finder color:(UIColor *)selectionColor font:(UIFont*)font removeFinder:(BOOL)removeFinder{

    NSString * str=[self string];
    NSError *error = nil;
    NSRegularExpression *regex;

    if ([finder  isEqualToString:@"http"]) {

        NSMutableArray* result=[[NSMutableArray alloc] init];
        NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
        NSArray *matches = [linkDetector matchesInString:self.string options:0 range:NSMakeRange(0, self.length)];

        for (NSTextCheckingResult *match in matches)
        {
            if ([match resultType] == NSTextCheckingTypeLink)
            {

                NSString *  word = [str substringWithRange:NSMakeRange(match.range.location, MAX(0,  match.range.length))];
                if (selectionColor) {
                    [self addAttribute:NSForegroundColorAttributeName value:selectionColor range:match.range];
                }

                if (font) {
                    [self addAttribute:NSFontAttributeName value:font range:match.range];
                }

                [self addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:match.range];
                [result addObject:[PPJStringSelectionObject createWithRange:match.range color:selectionColor font:font type:finder andValue:word]];
            }
        }

        return  result;
    }
    else{
        NSArray *matches;
        if ([finder isEqualToString:@"$"]) {
            regex=[NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"(\\$[^\\$\\.,?;\\s\"{}\\/<>\\]\\[()\\:@]*)"] options:NSRegularExpressionCaseInsensitive error:&error];
        }else
        if ([finder isEqualToString:@"#"]) {
            regex=[NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"(#[^#\\.,?;\\s\"{}\\/<>\\]\\[()\\:@]*)"] options:NSRegularExpressionCaseInsensitive error:&error];
        }else
            regex= [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"%@(\\w+\\.?(?:\\w+))",finder] options:0 error:&error];

        matches = [regex matchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];


        NSMutableArray* result=[[NSMutableArray alloc] init];

        for (NSTextCheckingResult *match in matches) {


            NSRange wordRange = [match rangeAtIndex:1];


            if (wordRange.location+wordRange.length>str.length) {
                continue;
            }
            NSString* word ;

            NSRange realRange;

            if ([finder isEqualToString:@"#"]) {
                word = [str substringWithRange:NSMakeRange(wordRange.location+1, MAX(0,  wordRange.length-1))];




                realRange=   NSMakeRange(wordRange.location, wordRange.length);
                if (selectionColor) {
                    [self addAttribute:NSForegroundColorAttributeName value:selectionColor range:realRange];
                }

                if (font) {
                    [self addAttribute:NSFontAttributeName value:font range:realRange];
                }
                [result addObject:[PPJStringSelectionObject createWithRange:realRange color:selectionColor font:font type:finder andValue:word]];
            }else    {


                word = [str substringWithRange:wordRange];



                //                if (!removeFinder) {
                realRange=   NSMakeRange(wordRange.location-1, wordRange.length+1);
                //                }

                if (selectionColor) {
                    [self addAttribute:NSForegroundColorAttributeName value:selectionColor range:realRange];
                }

                if (font) {
                    [self addAttribute:NSFontAttributeName value:font range:realRange];
                }

                [result addObject:[PPJStringSelectionObject createWithRange:realRange color:selectionColor font:font type:finder andValue:word]];
            }




        }
        if (removeFinder) {
            [ [self mutableString] replaceOccurrencesOfString:finder withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, self.string.length)];
        }

        return result;
    }



//    regex=[NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"([\UD800-\UDBFF][\UDC00-\Udfff])"] options:0 error:&error];




}

@end


@implementation NSAttributedString (PPMStringSize)

-(CGSize)ppj_sizeOfStringWithAvailableSize:(CGSize)size{

    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     context:nil];


    return rect.size;
}

@end
@implementation PPJStringSelectionObject
+(instancetype)createWithRange:(NSRange)r color:(UIColor *)color font:(UIFont *)font type:(NSString *)type andValue:(NSString *)value{

    PPJStringSelectionObject * rs=[[self alloc] init];

    rs.selectionColor=color;
    rs.selectionFont=font;
    rs.vlaue=value;
    rs.range=r;
    rs.type=type;

    return rs;

}

@end