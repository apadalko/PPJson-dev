//
//  PPJTransitionDirector.m
//  PPJTransitionDirector
//
//  Created by Alex Padalko on 01/10/15.
//  Copyright (c) 2014 Alex Padalko. All rights reserved.
//

#import "PPJTransitionDirector.h"
#import <objc/runtime.h>
#pragma mark - RUNTimeHelper
@interface RuntimeHelper : NSObject
@end
@implementation RuntimeHelper
#pragma mark helper for UIViewController
+(void)superPresentViewController:(id)vc animated:(BOOL)animated fromViewController:(id)rootVC{
    IMP imp=class_getMethodImplementation([UIViewController class],@selector(presentViewController:animated:completion:));
    typedef void (*func)(id,SEL,id,BOOL,void (^)(void));
    func f = (func)imp;
    f(rootVC,@selector(presentViewController:animated:completion:),vc,animated,nil);
}
+(void)superDismissViewControllerAnimated:(BOOL)animated fromViewController:(id)rootVC{
    IMP imp=class_getMethodImplementation([UIViewController class],@selector(dismissViewControllerAnimated:completion:));
    typedef void (*func)(id,SEL,BOOL,void (^)(void));
    func f = (func)imp;
    f(rootVC,@selector(presentViewController:animated:completion:),animated,nil);
}
#pragma mark  helper for navigation controller
+(void)superPushViewController:(id)vc animated:(BOOL)animated fromNavigationController:(id)nav{
    IMP imp=class_getMethodImplementation([UINavigationController class],@selector(pushViewController:animated:));
    typedef void (*func)(id,SEL,id,BOOL);
    func f = (func)imp;
    f(nav,@selector(pushViewController:animated:),vc,animated);
}
+(UIViewController*)superPopViewControllerAnimated:(BOOL)animated fromNavigationController:(id)nav{
    IMP imp=class_getMethodImplementation([UINavigationController class],@selector(popViewControllerAnimated:));
    typedef UIViewController* (*func)(id,SEL,BOOL);
    func f = (func)imp;
    return f(nav,@selector(popViewControllerAnimated:),animated);
}
+(void)superSelectIndex:(NSUInteger)idx fromTabBarController:(id)tab{
    IMP imp=class_getMethodImplementation([UITabBarController class],@selector(setSelectedIndex:));
    typedef UIViewController* (*func)(id,SEL,NSUInteger);
    func f = (func)imp;
    f(tab,@selector(popViewControllerAnimated:),idx);
}

@end
#pragma markr - global methods
#pragma mark
Class gestureClassForType(enum PPJGestureType type){
    Class cl;
    switch (type) {
        case PPJGestureTypeEdgePan:
            cl=[UIScreenEdgePanGestureRecognizer class];
            break;
        case PPJGestureTypePan:
            cl=[UIPanGestureRecognizer class];
            break;
        case PPJGestureTypePinch:
            cl=[UIPinchGestureRecognizer class];
            break;
        case PPJGestureTypeRotation:
            cl=[UIRotationGestureRecognizer class];
            break;
        default:
            break;
            
    }
    return cl;
}
#pragma mark
enum PPJGestureType typeFromGesture(UIGestureRecognizer*gesture){
    if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
        if ([gesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            return PPJGestureTypeEdgePan;
        }else {
            
            return PPJGestureTypePan;
        }
        
        
    }else if ([gesture isKindOfClass:[UIRotationGestureRecognizer class]]){
        
        
        return PPJGestureTypeRotation;
    }else if ([gesture isKindOfClass:[UIPinchGestureRecognizer class]]){
        
        return PPJGestureTypePinch;
    }else{
        
        return PPJGestureTypeNone;
    }
}
#pragma mark - PPJTransactionRule
@interface PPJTransitionRule()


@end

@implementation PPJTransitionRule : NSObject
+(instancetype)ruleWithGesture:(enum PPJGestureType)gestureType{
    
    return [[self alloc] initWithGesture:gestureType];
}
-(instancetype)initWithGesture:(enum PPJGestureType)gestureType{
    if (self == [super init]) {
        _gestureType=gestureType;
    }
    return self;
}
-(instancetype)setupGesture:(void(^)(UIGestureRecognizer*gesture))setupGestureBlock{
    self.setupGestureBlock=setupGestureBlock;
    return self;
}
-(instancetype)valueCalculationBlock:(ValueCallBlock)valueCalculationBlock{
    self.valueCallBlock=valueCalculationBlock;
    return self;
}
-(instancetype)gestureShouldBeginBlock:(BOOL (^)(UIGestureRecognizer *))gestureShouldBegin{
    self.gestureShouldBeginBlock=gestureShouldBegin;
    return self;
}
-(instancetype)actionBlockForValue:(ActionBlockForValue)valueBlock{
    _actionBlockForValue=valueBlock;
    return self;
}
-(instancetype)setDuration:(float)duration andComplitPercent:(float)percentToComplite{
    self.duration=duration;
    self.percentToComplite=percentToComplite;
    return self;
}
-(void)dealloc{
    NSLog(@"DEALLOC: %@",self.description );
}

@end

#pragma mark - PPJTransitions Categorys

#pragma mark  UIViewController
@implementation UIViewController(PPJTransitions)
-(void)PPJTransactionPresentViewController:(UIViewController*)viewController{
    PPJTransitionDirector * a=[[PPJTransitionDirector alloc]init];
    if ([self conformsToProtocol:@protocol(PPJTransitionProtocol)]) {
        id <PPJTransitionProtocol> obj = (NSObject<PPJTransitionProtocol> *)self;
        [a setDelegate:obj];
        [viewController setTransitioningDelegate:a];
        
    }
   [RuntimeHelper superPresentViewController:viewController animated:YES fromViewController:self];
   viewController.transitioningDelegate = nil;
}
-(void)PPJTransactionPresentViewController:(UIViewController*)viewController withTransitionProtocol:(id<PPJTransitionProtocol>)transitionProtocol{
    PPJTransitionDirector * a=[[PPJTransitionDirector alloc]init];
    [a setDelegate:transitionProtocol];
    [viewController setTransitioningDelegate:a];
    [RuntimeHelper superPresentViewController:viewController animated:YES fromViewController:self];
    viewController.transitioningDelegate = nil;
}
-(void)PPJTransactionDismissViewController{
    PPJTransitionDirector * a=[[PPJTransitionDirector alloc]init];
    if ([self conformsToProtocol:@protocol(PPJTransitionProtocol)]) {
        id <PPJTransitionProtocol> obj = (NSObject<PPJTransitionProtocol> *)self;
        [a setDelegate:obj];
        [self setTransitioningDelegate:a];
    }
    [RuntimeHelper superDismissViewControllerAnimated:YES fromViewController:self];
    self.transitioningDelegate = nil;
}
-(void)PPJTransactionDismissViewControllerWithTransitionProtocol:(id<PPJTransitionProtocol>)transitionProtocol{
    PPJTransitionDirector * a=[[PPJTransitionDirector alloc]init];
    [a setDelegate:transitionProtocol];
    [self setTransitioningDelegate:a];
    [RuntimeHelper superDismissViewControllerAnimated:YES fromViewController:self];
    self.transitioningDelegate = nil;
}
@end
#pragma mark  UINavigationController
@implementation UINavigationController (PPJTransitions)
-(void)PPJTransactionPushViewController:(UIViewController*)viewController{
    PPJTransitionDirector * a=[[PPJTransitionDirector alloc]init];
    if ([self conformsToProtocol:@protocol(PPJTransitionProtocol)]) {
        id <PPJTransitionProtocol> obj = (NSObject<PPJTransitionProtocol> *)self;
        [a setDelegate:obj];
        [self setDelegate:a];
    }
    [RuntimeHelper superPushViewController:viewController animated:YES fromNavigationController:self];
    self.delegate = nil;
}
-(void)PPJTransactionPushViewController:(UIViewController*)viewController withTransitionProtocol:(id<PPJTransitionProtocol>)transitionProtocol{
    PPJTransitionDirector * a=[[PPJTransitionDirector alloc]init];
    [a setDelegate:transitionProtocol];
    [self setDelegate:a];
    [RuntimeHelper superPushViewController:viewController animated:YES fromNavigationController:self];
    self.delegate = nil;
}
-(UIViewController*)PPJTransactionPopViewController{
    PPJTransitionDirector * a=[[PPJTransitionDirector alloc]init];
    
    if ([self conformsToProtocol:@protocol(PPJTransitionProtocol)]) {
        id <PPJTransitionProtocol> obj = (NSObject<PPJTransitionProtocol> *)self;
        [a setDelegate:obj];
        [self setDelegate:a];
    }
    UIViewController * vc= [RuntimeHelper superPopViewControllerAnimated:YES fromNavigationController:self];
    
    
    self.delegate=nil;
    
    return vc;
}
-(UIViewController*)PPJTransactionPopViewControllerWithTransitionProtocol:(id<PPJTransitionProtocol>)transitionProtocol{
    PPJTransitionDirector * a=[[PPJTransitionDirector alloc]init];
    [a setDelegate:transitionProtocol];
    [self setDelegate:a];
    UIViewController * vc= [RuntimeHelper superPopViewControllerAnimated:YES fromNavigationController:self];
    self.delegate=nil;
    return vc;
}
@end

#pragma mark  UITabBarController

@implementation UITabBarController (PPJTransitions)
/**
 * simple switch to index, sender(UITabBarController) will be asked for conform PPJTransitionProtocol
 *
 */
-(void)PPJTransactionSelectIndex:(NSUInteger)idx{
    PPJTransitionDirector * a=[[PPJTransitionDirector alloc]init];
    if ([self conformsToProtocol:@protocol(PPJTransitionProtocol)]) {
        id <PPJTransitionProtocol> obj = (NSObject<PPJTransitionProtocol> *)self;
        [a setDelegate:obj];
        [self setDelegate:a];
        
    }
    [RuntimeHelper superSelectIndex:idx fromTabBarController:self];
    self.delegate = nil;
}
-(void)PPJTransactionSelectIndex:(NSUInteger)idx withTransitionProtocol:(id<PPJTransitionProtocol>)transitionProtocol{
    PPJTransitionDirector * a=[[PPJTransitionDirector alloc]init];
    [a setDelegate:transitionProtocol];
    [self setDelegate:a];
    [RuntimeHelper superSelectIndex:idx fromTabBarController:self];
    self.delegate = nil;
}

@end
#pragma mark -


#pragma mark - PPJRuleInteractiveTransitions Categorys


@implementation  UIViewController (PPJRuleInteractiveTransitions)
static NSMutableDictionary * gestureDict=nil;

-(void)baseInteractiveGestureSetup{
    if (!gestureDict) {
        gestureDict=[[NSMutableDictionary alloc]init];
    }
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        [(UINavigationController*) self interactivePopGestureRecognizer].enabled = NO;
    }
}
-(void)registerInteractiveTransactionWithRule:(PPJTransitionRule *)rule andTransitionProtocol:(id<PPJTransitionProtocol>)transitionProtocol{
    enum PPJGestureType type=rule.gestureType;
    UIGestureRecognizer * panGesture =[[gestureClassForType(type) alloc] initWithTarget:self action:@selector(recognizerMethod:)];
    NSMutableDictionary * inDict=[gestureDict valueForKey:self.description];
    if (!inDict) {
        inDict=[[NSMutableDictionary alloc] init];
    }
    inDict[@(type)]=[NSDictionary dictionaryWithObjectsAndKeys:panGesture,@"gesture",rule,@"rule",transitionProtocol,@"prot", nil];
    [gestureDict setValue:inDict forKey:self.description];
    [self.view addGestureRecognizer:panGesture];
    [panGesture setDelegate:self];
    
}
-(void)registerInteractiveTransactionWithRule:(PPJTransitionRule *)rule withAnimationBlockForValueAndGesture:(AnimationBlock (^)(float, UIGestureRecognizer *))animationBlockForValue{
    
    [self registerInteractiveTransactionWithRule:rule withAnimationBlockForValueAndGesture:animationBlockForValue andUpdateBlockForValueAndGesture:nil];
}
-(void)registerInteractiveTransactionWithRule:(PPJTransitionRule *)rule withAnimationBlockForValueAndGesture:(AnimationBlock (^)(float, UIGestureRecognizer *))animationBlockForValue andUpdateBlockForValueAndGesture:(void (^)(PPJTransitionDirector * , float, UIGestureRecognizer *))updateBlockForValue{
    [self baseInteractiveGestureSetup];
    enum PPJGestureType type=rule.gestureType;
    UIGestureRecognizer * panGesture =[[gestureClassForType(type) alloc] initWithTarget:self action:@selector(recognizerMethod:)];
    NSMutableDictionary * inDict=[gestureDict valueForKey:self.description];
    if (!inDict) {
        inDict=[[NSMutableDictionary alloc] init];
    }
    inDict[@(type)]=[NSDictionary dictionaryWithObjectsAndKeys:panGesture,@"gesture",rule,@"rule",animationBlockForValue,@"anim",updateBlockForValue,@"update", nil];
    [gestureDict setValue:inDict forKey:self.description];
    [self.view addGestureRecognizer:panGesture];
    [panGesture setDelegate:self];
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    enum PPJGestureType type=typeFromGesture(gestureRecognizer);
    NSDictionary * inDict=[gestureDict valueForKey:self.description][@(type)];
    if ([self isKindOfClass:[UITabBarController class]]) {
        
        if (CGRectContainsPoint([(UITabBarController*)self tabBar].frame, [gestureRecognizer locationInView:self.view])) {
            return NO;
        }
        
    }
   PPJTransitionRule * rule=[inDict valueForKey:@"rule"];
    if (rule.gestureShouldBeginBlock) {
        return rule.gestureShouldBeginBlock(gestureRecognizer);
    }
    return YES;
}
- (void)recognizerMethod:(UIGestureRecognizer*)sender {
    static CGPoint firstTouch;
    static PPJTransitionDirector * animDirector=nil;
    static AnimationBlock (^animBlockForValue)(float,UIGestureRecognizer*);
    static void (^updateBlockForValue)(PPJTransitionDirector*,float,UIGestureRecognizer*);
    static PPJTransitionRule * rule=nil;
    static float complPercent=0.5;
    static id<PPJTransitionProtocol> transitionProtocol;
    if (!rule) {
        firstTouch=[sender locationInView:self.view];
        enum PPJGestureType type=typeFromGesture(sender);
        NSDictionary * inDict=[gestureDict valueForKey:self.description][@(type)];
        animBlockForValue=[inDict valueForKey:@"anim"];
        updateBlockForValue=[inDict valueForKey:@"update"];
        rule=[inDict valueForKey:@"rule"];
        
        transitionProtocol=[inDict valueForKey:@"prot"];
    }
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        case  UIGestureRecognizerStateChanged:
        {
            rule.valueCallBlock(sender,firstTouch,^(float value,float maxValue){
                BOOL isInitial=sender.state == UIGestureRecognizerStateBegan?YES :NO;
                ActionBlock  ab=rule.actionBlockForValue(value,isInitial);
                if (ab) {
                    [animDirector fastCancel];
                    animDirector=[[PPJTransitionDirector alloc] init];
                    animDirector.interactive=YES;
                    animDirector.animBlock=animBlockForValue(value,sender);
                    animDirector.animDuration=rule.duration;
                    complPercent=rule.percentToComplite;
                    if ([self isKindOfClass:[UITabBarController class]]) {
                        UITabBarController * tb=(UITabBarController*)self;
                        [tb setDelegate:animDirector];
                    }
                    ab();
                    if ([self isKindOfClass:[UITabBarController class]]) {
                        
                        UITabBarController * tb=(UITabBarController*)self;
                        [tb setDelegate:nil];
                    }
                }
                if (!isInitial) {
                       [animDirector setPercent:MIN(0.99, fabsf(value)/maxValue)];
                            animDirector.interactiveUpdateBlock=^(PPJTransitionDirector * director){
                                if (updateBlockForValue) {
                                        updateBlockForValue(director,value,sender);
                                }
                            };
                }
             
            });
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            BOOL canceled=YES;
            if (animDirector.percent > complPercent && sender.state==UIGestureRecognizerStateEnded) {
                canceled=NO;
            }
            [animDirector endInteractiveTranscation:canceled complition:^(PPJTransitionDirector*director){
            }];
            rule=nil;
            animDirector=nil;
            break;
        }
        default: {
            break;
            
        }
    }
}

@end
#pragma mark -
#pragma mark - PPJnteractiveTransitions Categorys
@implementation UIViewController (PPJInteractiveTransitions)

-(PPJTransitionRule*)registerDissmisInteractiveTrasactionWithGesture:(enum PPJGestureType)gesture{
    

     PPJTransitionRule * rule = [[PPJTransitionRule ruleWithGesture:gesture] actionBlockForValue:^ActionBlock(float value, BOOL initial) {
        
        
        if (initial) {
            ActionBlock ab=^{
                
              [self dismissViewControllerAnimated:YES completion:^{
                  
              }];
            };
            
            return ab;
        }
        
        return nil;
        
    }];
    
    
    [self registerInteractiveTransactionWithRule:rule withAnimationBlockForValueAndGesture:nil];
    
    
    return rule;

}


@end
#pragma mark -


#pragma mark - APPJTransitionDirector
@interface PPJTransitionDirector(){
    
     id<UIViewControllerContextTransitioning> _context;
     CADisplayLink *_displayLink;
}
@end
@implementation PPJTransitionDirector



-(instancetype)init{
    if (self=[super init]) {
        _animDuration=0.5;
        _interactive=NO;
        _interactiveState=NO;
    }
    return self;
}

#pragma mark - time offset
- (void)setTimeOffset:(NSTimeInterval)timeOffset {
    [self setPercent:timeOffset/self.animDuration];
}
#pragma mark - update percent
-(void)setPercent:(float)percent{
    _percent=percent;
    [self updateInteractiveTransition:percent];
    _timeOffset=_percent*self.animDuration;
    if (self.interactiveUpdateBlock) {
        self.interactiveUpdateBlock(self);
    }
}


#pragma mark - interactiveTransaction ending
-(void)fastCancel{
    
  //

    [[_context containerView].layer removeAllAnimations];
    for (CALayer *l in [_context containerView].layer.sublayers)
    {
        [l removeAllAnimations];
    }
    
 //   [[self toView] removeFromSuperview];
   [_context updateInteractiveTransition:0];
   [[self fromView] setFrame:[_context initialFrameForViewController:[self fromViewController]]];
    [self cancelInteractiveTransition];
    [_context completeTransition:NO];
    [_context containerView].layer.speed=1;
//  
//    [_context cancelInteractiveTransition];
//   
//
//  [_context containerView].layer.speed=1;
//
    

}
-(void)endInteractiveTranscation:(BOOL)didComplete complition:(void (^)(PPJTransitionDirector * director))complitBlock {
    if (complitBlock) {
       self.interactiveComplitionBlock=complitBlock;
    }
    
    if (!didComplete) {
     
            _interactiveState=PPJDirectorInteractiveStateCanceling;
      
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateCancelAnimation)];
      //  [self cancelInteractiveTransition];

    } else {
        
        _interactiveState=PPJDirectorInteractiveStateFinishing;
       _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateFinishAnimation)];
       // [self finishInteractiveTransition];
    }
       [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}


-(void)_transactionFinishFinishing{
    [_displayLink invalidate];
    _percent=1.0;
    if (self.interactiveUpdateBlock) {
        self.interactiveUpdateBlock(self);
    }
[self finishInteractiveTransition];
    
    [_context containerView].layer.speed=1;
    [_context completeTransition:YES];
   // [self performSelector:@selector(zz) withObject:nil afterDelay:0.1];
      //[[self fromView] removeFromSuperview];

//    if (self.interactiveComplitionBlock) {
//        
//        self.interactiveComplitionBlock(self);
//    }
}

-(void)zz{
    
    [_context containerView].layer.speed=1;
    [_context completeTransition:YES];
}

- (void)_transitionFinishedCanceling {
    [_displayLink invalidate];
      _percent=0.0;
    if (self.interactiveUpdateBlock) {
            self.interactiveUpdateBlock(self);
    }

    [self cancelInteractiveTransition];
    [_context completeTransition:NO];
    [_context containerView].layer.speed=1;
    
    [[self toView] removeFromSuperview];
//    if (self.interactiveComplitionBlock) {
//        self.interactiveComplitionBlock(self);
//    }
}
- (void)updateCancelAnimation {
    NSTimeInterval timeOffset = [self timeOffset]-[_displayLink duration];
    if (timeOffset<= 0) {
           //  [self setTimeOffset:0];
        [self _transitionFinishedCanceling];
    } else {
   
        [self setTimeOffset:timeOffset];
    }
}

- (void)updateFinishAnimation {
    NSTimeInterval timeOffset = [self timeOffset]+[_displayLink duration];
    if (timeOffset >=self.animDuration) {
        //[self setTimeOffset:self.animDuration];
        [self performSelector:@selector(_transactionFinishFinishing) withObject:nil afterDelay:0];
    } else {
        [self setTimeOffset:timeOffset];
    }
} 
-(void)animationEnded:(BOOL)transitionCompleted{
    
    
    if (self.interactive) {
        if (self.interactiveComplitionBlock) {
    
        }
    }


}
#pragma mark - transaction delegate
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
//    if (_context) {
//        ;
//  
//     UIViewController * vc1=   [_context viewControllerForKey:UITransitionContextToViewControllerKey];
//        UIViewController * vc2=    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//        [vc2.view removeFromSuperview];
//        [[_context containerView].layer removeAllAnimations];
//        for (CALayer *l in [_context containerView].layer.sublayers)
//        {
//            [l removeAllAnimations];
//        }
//  
//       // [_context cancelInteractiveTransition];
//        
//       //[_context completeTransition:NO];
//    }
//
    _context=transitionContext;
    BOOL failed=YES;
    
    if (self.isInteractive) {
        _interactiveState=PPJDirectorInteractiveStateInProgress;
    }
    if (self.animBlock) {
        failed=NO;
        
             __weak typeof(self) weakSelf = self;
        
        self.animBlock(self,^{
           
            
            if (!self.isInteractive) {
                    [transitionContext completeTransition:YES];
            }else{
                
                self.interactiveComplitionBlock(weakSelf);
            }
       
        });
    }
    if (self.delegate) {
        failed=NO;
        __weak typeof(self) weakSelf = self;
        [self.delegate animationTransition:self andComplitionBlock:^{
            
                        if (!self.isInteractive) {
            [transitionContext finishInteractiveTransition];
            [transitionContext completeTransition:YES];
                        }else{
                            
                            self.interactiveComplitionBlock(weakSelf);
                        }
        }];
    }
    if (failed) {
          //    if (!self.isInteractive) {
        [transitionContext finishInteractiveTransition];
        [transitionContext completeTransition:YES];
           //   }
    }
}
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    if ([self.delegate respondsToSelector:@selector(animationDurationFor:)]) {
       _animDuration = [self.delegate animationDurationFor:self];
    }
    return _animDuration;
}
#pragma mark - navigation controller delegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation==UINavigationControllerOperationPush) {
        _transitionOperation=PPJDirectorOperationPush;
    }else if (operation==UINavigationControllerOperationPop){
        _transitionOperation=PPJDirectorOperationPop;
    }
    
    return self;
}


-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.isInteractive?self:nil;
}
#pragma mark - uitabbarController transaction

- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC {
    
    _transitionOperation=PPJDirectorOperationSelectIndex;
    
    return self;
}

-(id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
   return self.isInteractive?self:nil;
}

#pragma mark - uiviewcontroller transactioning delegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    _transitionOperation=PPJDirectorOperationPresent;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    _transitionOperation=PPJDirectorOperationDismiss;
    return self;
}
- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return self.isInteractive?self:nil;
}
- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
         return self.isInteractive?self:nil;
}
#pragma mark - fastAccess
-(UIView *)containerView{
    return [_context containerView];
}

-(UIView *)fromView{
       if (    [_context respondsToSelector:@selector(viewForKey:)])
    return [_context viewForKey:UITransitionContextFromViewKey];
    else
            return [[_context viewControllerForKey:UITransitionContextFromViewControllerKey] view];
}

-(UIView *)toView{
    
    if (    [_context respondsToSelector:@selector(viewForKey:)])
       return [_context viewForKey:UITransitionContextToViewKey];   
    else
        return [[_context viewControllerForKey:UITransitionContextToViewControllerKey] view];

}

-(UIViewController *)fromViewController{
    return [_context viewControllerForKey:UITransitionContextFromViewControllerKey];
}

-(UIViewController *)toViewController{
    return [_context viewControllerForKey:UITransitionContextToViewControllerKey];
}

#pragma mark - dealloc
-(void)dealloc{
    NSLog(@"DEALLOC: %@",self.description);
}



@end

