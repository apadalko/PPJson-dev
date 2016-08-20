//
//  PPGridCellObject.h
//  PPGMPersonaGridView
//
//  Created by Alex Padalko on 2/20/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol  PPGridCellObjectTextDelegate <NSObject>

-(void)sayText:(NSString*)text removeAfter:(float)delay directiom:(NSInteger)direction;

@end

@interface PPGridCellObject : NSObject


+(instancetype)createWithGridPoint:(CGPoint)gridPoint;
-(instancetype)initWithGridPoint:(CGPoint)gridPoint;

@property (nonatomic)CGPoint gridPoint;

@property (nonatomic,weak)UIView * representation;

@property (nonatomic,weak)id<PPGridCellObjectTextDelegate>delegate;


-(void)sayText:(NSString*)text removeAfter:(float)delay directiom:(NSInteger)direction;

@end
