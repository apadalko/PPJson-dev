//
//  PPJTransitionDirector.h
//  PPJTransitionDirector
//
//  Created by Alex Padalko on 01/10/15.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class PPJTransitionDirector;
typedef void(^UpdateBlock)(PPJTransitionDirector * transactionDirector);
typedef void(^AnimationBlock)(PPJTransitionDirector * transactionDirector,void (^complitBlock)());
typedef void(^InteractiveComplitionBlock)(PPJTransitionDirector * transactionDirector);
enum PPJGestureType {
    PPJGestureTypeNone,
    PPJGestureTypePan,
    PPJGestureTypeEdgePan,
    PPJGestureTypePinch,
    PPJGestureTypeRotation
    
};
Class gestureClassForType(enum PPJGestureType type);
enum PPJGestureType typeFromGesture(UIGestureRecognizer*gesture);

@interface PPJTransitionRule : NSObject
//blocks define
typedef void (^ActionBlock)();
typedef ActionBlock (^ActionBlockForValue)(float value,BOOL initial);

//typedef void (^SetupBlock)(float duration,float percentToComplite);
//typedef void (^SetupCallBlock)(SetupBlock setupBlock);

typedef void (^ValueBlock)(float value,float maxValue);
typedef void (^ValueCallBlock)(UIGestureRecognizer * gesture,CGPoint firstTouch,ValueBlock valueBlock);


@property (nonatomic,readonly)enum PPJGestureType gestureType;
@property (nonatomic)float duration;
@property (nonatomic)float percentToComplite;
//blocks prop
@property (copy) ActionBlockForValue actionBlockForValue;
@property (copy) void (^setupGestureBlock) (UIGestureRecognizer * gesture);
@property (copy) BOOL (^gestureShouldBeginBlock)(UIGestureRecognizer * gesture);
@property (copy)  ValueCallBlock  valueCallBlock;
//@property (copy) SetupCallBlock setupCallBlock;

+(instancetype)ruleWithGesture:(enum PPJGestureType)gestureType;

-(instancetype)setDuration:(float)duration andComplitPercent:(float)percentToComplite;
//block methods
-(instancetype)setupGesture:(void(^)(UIGestureRecognizer*gesture))setupGestureBlock;
//-(instancetype)setupBlock:(SetupCallBlock)setupBlock;
-(instancetype)valueCalculationBlock:( ValueCallBlock )valueCalculationBlock;
-(instancetype)actionBlockForValue:( ActionBlockForValue )valueBlock;
-(instancetype)gestureShouldBeginBlock:( BOOL (^)(UIGestureRecognizer *gesture) )gestureShouldBegin;

@end







#pragma mark - PPJTransitionProtocol
//You will need this protocol in case that u will use PPJTransitions categories or just using delegate as for controll
@protocol  PPJTransitionProtocol <NSObject>
@required

/**
 * animation block.Use APPJTransitionDirector (PPJFastAcces) to get all needed views. NOTE: if you use it for animation without interactive !!YOU MUST RUN!! complitBlock at end.
 *
 */
-(void)animationTransition:(PPJTransitionDirector*) transitionDirector andComplitionBlock:(void(^)())complitBlock;
@optional
/**
 * NOTE! Implementation of this method would be the main value for duration
 *
 */
-(CGFloat)animationDurationFor:(PPJTransitionDirector*)transitionDirector;

@end
#pragma mark - PPJTransitions Categorys

#pragma mark  UIViewController
@interface UIViewController(PPJTransitions)
/**
 * simple dismiss, sender(UIViewController) will be asked for conform PPJTransitionProtocol
 *
 */
-(void)PPJTransactionPresentViewController:(UIViewController*)viewController;
-(void)PPJTransactionPresentViewController:(UIViewController*)viewController withTransitionProtocol:(id<PPJTransitionProtocol>)transitionProtocol;
/**
 * simple dismiss, sender(UIViewController) will be asked for conform PPJTransitionProtocol
 *
 */
-(void)PPJTransactionDismissViewController;
-(void)PPJTransactionDismissViewControllerWithTransitionProtocol:(id<PPJTransitionProtocol>)transitionProtocol;
@end

#pragma mark  UINavigationController
@interface UINavigationController(PPJTransitions)
/**
 * simple push, sender(UINavigationController) will be asked for conform PPJTransitionProtocol
 *
 */
-(void)PPJTransactionPushViewController:(UIViewController*)viewController;
-(void)PPJTransactionPushViewController:(UIViewController*)viewController withTransitionProtocol:(id<PPJTransitionProtocol>)transitionProtocol;
/**
 * simple pop, sender(UINavigationController) will be asked for conform PPJTransitionProtocol
 *
 */
-(UIViewController*)PPJTransactionPopViewController;
-(UIViewController*)PPJTransactionPopViewControllerWithTransitionProtocol:(id<PPJTransitionProtocol>)transitionProtocol;
@end

#pragma mark  UITabBarController

@interface UITabBarController (PPJTransitions)
/**
 * simple switch to index, sender(UITabBarController) will be asked for conform PPJTransitionProtocol
 *
 */
-(void)PPJTransactionSelectIndex:(NSUInteger)idx;
-(void)PPJTransactionSelectIndex:(NSUInteger)idx withTransitionProtocol:(id<PPJTransitionProtocol>)transitionProtocol;

@end

#pragma mark -
#pragma mark - PPJRuleInteractiveTransitions Categorys
@interface UIViewController (PPJRuleInteractiveTransitions)
-(void)registerInteractiveTransactionWithRule:(PPJTransitionRule*)rule withAnimationBlockForValueAndGesture:(AnimationBlock (^)(float value,UIGestureRecognizer*gesture))animationBlockForValue;

-(void)registerInteractiveTransactionWithRule:(PPJTransitionRule*)rule withAnimationBlockForValueAndGesture:(AnimationBlock (^)(float value,UIGestureRecognizer*gesture))animationBlockForValue andUpdateBlockForValueAndGesture:(void (^)(PPJTransitionDirector * director, float value,UIGestureRecognizer * gesture))updateBlockForValue;
@end
#pragma mark -

#pragma mark - PPJInteractiveTransitions Categorys
@interface UIViewController (PPJInteractiveTransitions)
#warning not ready yet
-(PPJTransitionRule*)registerDissmisInteractiveTrasactionWithGesture:(enum PPJGestureType)gesture;


@end
#pragma mark -

#pragma mark - APPJTransitionDirector


enum PPJDirectorInteractiveState{
    
    PPJDirectorInteractiveStateNone,
    PPJDirectorInteractiveStateInProgress,
    PPJDirectorInteractiveStateCanceling,
    PPJDirectorInteractiveStateFinishing
    
};
enum PPJDirectorOperation{
    PPJDirectorOperationPop,
    PPJDirectorOperationPush,
    PPJDirectorOperationPresent,
    PPJDirectorOperationDismiss,
    PPJDirectorOperationSelectIndex
    
};

@interface PPJTransitionDirector : UIPercentDrivenInteractiveTransition<UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate,UIViewControllerInteractiveTransitioning,UITabBarControllerDelegate,UIViewControllerTransitioningDelegate>

@property (assign,nonatomic)id<PPJTransitionProtocol> delegate;
/**
 * animation block.Use APPJTransitionDirector (PPJFastAcces) to get all needed views. NOTE: if you use it for animation without interactive !!YOU MUST RUN!! complitBlock at end.
 *
 */
@property (copy)AnimationBlock animBlock;

/**
 * interactive update block.Use transactionContext to get all needed views.updating after percent changing
 *
 */
@property (copy)UpdateBlock interactiveUpdateBlock;
@property (copy)InteractiveComplitionBlock interactiveComplitionBlock;
@property (nonatomic)float animDuration;
/**
 * only for navigation controller;
 *
 */
@property (nonatomic,readonly)enum PPJDirectorOperation transitionOperation ;
/**
 * used to detect if the transition is interactive, default = NO
 *
 */
@property (nonatomic, assign, getter = isInteractive) BOOL interactive;
/**
 * used to detect the interactive state from enum PPJDirectorInteractiveState
 *
 */
@property (nonatomic,readonly)enum PPJDirectorInteractiveState interactiveState;

-(void)fastCancel;
/**
 * run to end interactive transaction
 *
 */
-(void)endInteractiveTranscation:(BOOL)didComplete complition:(void (^)(PPJTransitionDirector * director))complitBlock ;

@property (nonatomic)CFTimeInterval timeOffset;


@property (nonatomic)float percent;
@end


@interface PPJTransitionDirector (PPJFastAcces)
-(UIView*)fromView;
-(UIView*)toView;
-(UIViewController*)fromViewController;
-(UIViewController*)toViewController;
-(UIView*)containerView;
@end


