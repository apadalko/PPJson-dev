//
//  PPJViewControllerConfigurationsManager.m
//  Gabbermap
//
//  Created by Alex Padalko on 3/16/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPJViewControllerConfigurationsManager.h"
#import "PPJViewControllerConfigurator.h"
#import "PPJOptionListDefaultHandler.h"
@interface PPJViewControllerConfigurationsManager ()

@property (nonatomic,retain)NSString * defaultConfiguratorClassName;

@property (nonatomic,retain)NSMutableDictionary * configuratorClasses;

@property (nonatomic,retain)NSMutableDictionary * chachedConfigurators;


@property (nonatomic,retain)NSString * defaultOptionListHandlerClassName;
@property (nonatomic,retain)NSMutableDictionary * optionListHandlerClasses;

@property (nonatomic,retain)id<PPJViewControllerConfiguratorProt>defaultConfigurator;
@end

@implementation PPJViewControllerConfigurationsManager

static PPJViewControllerConfigurationsManager * instance;

+(instancetype)sharedInstance{
    
    if (!instance) {
        instance=[[PPJViewControllerConfigurationsManager alloc] init];
    }
    return instance;
}

-(instancetype)init{
    if (self=[super init]) {
        
        [self registerDefaultConfiguratorClass:[PPJViewControllerConfigurator class]];
        [self registerDefaultOptionListHandler:[PPJOptionListDefaultHandler class]];
        
    }
    return self;
}
#pragma mark - registreation
-(void)registerDefaultConfiguratorClass:(Class<PPJViewControllerConfiguratorProt>)configuratorClass{
    _defaultConfigurator=nil;
    self.defaultConfiguratorClassName=NSStringFromClass(configuratorClass);
}
-(void)registerConfiguratorClass:(Class<PPJViewControllerConfiguratorProt>)configuratorClass forViewControllerClass:(Class<PPJViewControllerProt>)viewControllerClass{
    
    NSString * vcClassName=NSStringFromClass(viewControllerClass);
    NSString * confClassName=NSStringFromClass(configuratorClass);
    
    [self.configuratorClasses setValue:confClassName forKey:vcClassName];
    
}

-(void)registerDefaultOptionListHandler:(Class<PPJOptionListHandler>)handlerClass{
    self.defaultOptionListHandlerClassName=NSStringFromClass(handlerClass);
}
-(void)registerOptionListHandler:(Class<PPJOptionListHandler>)handlerClass forViewControllerClass:(Class<PPJViewControllerProt>)viewControllerClass{
    
    [self.optionListHandlerClasses setValue:NSStringFromClass(handlerClass) forKey:NSStringFromClass(viewControllerClass)];
    
}
#pragma mark - reciving

#pragma mark hanlders

-(id<PPJOptionListHandler>)optionListHanderForViewController:(UIViewController<PPJViewControllerProt> *)viewController{
    
    
    Class <PPJViewControllerProt> cl = [viewController class];
    
    return [self _optionListHanderForViewController:cl];
    
}
-(id<PPJOptionListHandler>)_optionListHanderForViewController:(Class)viewControllerClass{
    
    NSString * vcClassName=NSStringFromClass(viewControllerClass);
    NSString * confClassName=[self.optionListHandlerClasses valueForKey:vcClassName];
    
        if (confClassName) {
            
            
            return [NSClassFromString(confClassName)  createHandler];
            
        }else{
                 if ([vcClassName isEqualToString:@"UIViewController"]) {
            return [NSClassFromString(self.defaultOptionListHandlerClassName)  createHandler ];
                 }else{
                     return [self _optionListHanderForViewController:[viewControllerClass superclass]];
                 }
        }

    
    
}

#pragma mark configurators
-(id<PPJViewControllerConfiguratorProt>)configratorForViewController:(UIViewController<PPJViewControllerProt>*)viewController{
    
    
    id<PPJViewControllerConfiguratorProt> c =  [self _configuratorForViewControllerClass:[viewController class]];
    
    [c setControllerRefirence:viewController];
    return c;
}
-(id<PPJViewControllerConfiguratorProt>)_configuratorForViewControllerClass:(Class)viewControllerClass{
    
     NSString * vcClassName=NSStringFromClass(viewControllerClass);
    id <PPJViewControllerConfiguratorProt> conf = [self.chachedConfigurators valueForKey:vcClassName];
    if (!conf) {
        NSString * confClassName=[self.configuratorClasses valueForKey:vcClassName];
        if (!confClassName) {
            
            if ([vcClassName isEqualToString:@"UIViewController"]) {
                return self.defaultConfigurator;
            }else{
                return [self _configuratorForViewControllerClass:[viewControllerClass superclass]];
            }
            
        }else{
           
          conf = [[NSClassFromString(confClassName) alloc] init];
        
            [self.chachedConfigurators setValue:conf forKey:vcClassName];
        }
    }
    
    return conf;
    
    
}
-(id<PPJViewControllerNavBarConfigurationProt>)barConfigratorForViewController:(UIViewController<PPJViewControllerProt>*)viewController{
    return [self configratorForViewController:viewController];
}
-(id<PPJViewControllerMainConfigurationProt>)mainConfigratorForViewController:(UIViewController<PPJViewControllerProt>*)viewController{
    return [self configratorForViewController:viewController];
}

-(id<PPJViewControllerConfiguratorProt>)defaultConfigurator{
    if (!_defaultConfigurator) {
        _defaultConfigurator=[[NSClassFromString(self.defaultConfiguratorClassName) alloc] init];
    }
    return _defaultConfigurator;
    
}
-(NSMutableDictionary *)chachedConfigurators{
    
    if (!_chachedConfigurators) {
        _chachedConfigurators=[[NSMutableDictionary alloc] init];
    }
    return _chachedConfigurators;
    
}
-(NSMutableDictionary *)configuratorClasses{
    
    if (!_configuratorClasses) {
        _configuratorClasses=[[NSMutableDictionary alloc] init];
    }
    return _configuratorClasses;
}
-(NSMutableDictionary *)optionListHandlerClasses{
    if (!_optionListHandlerClasses) {
        _optionListHandlerClasses=[[NSMutableDictionary alloc] init];
    }
    return _optionListHandlerClasses;
}
@end
