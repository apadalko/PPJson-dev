//
//  PPGMPersonaGridView.h
//  PPGMPersonaGridView
//
//  Created by Alex Padalko on 2/20/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPGridCellView.h"
//typedef void(^UpdateBlock)(APTransitionDirector * transactionDirector);
#import "PPGridCellObject.h"
#import "PPGridAnimationObject.h"

@protocol PPGridViewDelegate <NSObject>

-(PPGridCellView*)gv_gridCellViewFormObject:(id)object;

@end

@protocol PPGridViewAnimationDelegate <NSObject>
-(NSArray<PPGridAnimationObject*>*)gva_gridApperanceAnimationSequence;


@end

@interface PPGridView : UIView

-(instancetype)initWithGridSize:(CGSize)size;
@property (nonatomic)CGSize gridSize;
-(void)refreshObject:(id)obj;
@property (nonatomic)BOOL inAnimation;
@property (nonatomic)BOOL initialApperiance;
@property (nonatomic)CGSize blockSize;

-(void)addGridCellObject:(PPGridCellObject*)gridCellObject;
-(void)addGridCellObject:(PPGridCellObject*)gridCellObject andPresent:(void(^)())complitBlock;

@property (nonatomic,weak)id<PPGridViewDelegate> delegate;
@property (nonatomic)BOOL shouldShowBakgroundImage;



-(void)showGridWithAnimation:(BOOL)withAnimation complitBlock:(void(^)())complitBlock;
@property (nonatomic,weak)id<PPGridViewAnimationDelegate> animationDelegate;


-(void)refreshObject:(PPGridCellObject*)object complitBlock:(void(^)())complitBlock;


@end
