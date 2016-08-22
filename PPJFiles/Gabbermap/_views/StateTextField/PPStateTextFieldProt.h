//
//  PPStateTextFieldProt.h
//  Blok
//
//  Created by Alex Padalko on 12/11/15.
//  Copyright © 2015 com.placepixel. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RACSignal;
typedef NS_ENUM(NSInteger,  PPStateTFType) {
    PPStateTFTypeNone,
    PPStateTFTypeCheking,
    PPStateTFTypeFailed,
    PPStateTFTypeFailedFormat,
    PPStateTFTypeOk
    
};


@protocol PPStateTextFieldProt <NSObject>
@property (nonatomic)PPStateTFType stateType;

-(NSString *)currentText;

-(RACSignal*)inputSignal;
-(void)updateText:(NSString*)text;
-(BOOL)isNowEditig;
@property (nonatomic,retain)RACSignal * stopEditionSignal;
@end
