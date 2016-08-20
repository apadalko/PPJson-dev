//
// Created by Alex Padalko on 8/18/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import "PPJObject.h"


@interface PPJObject()
@property (nonatomic,retain)NSMutableDictionary * observersScopes;
@end
@implementation PPJObject {

}

+ (instancetype)mj_objectWithKeyValues:(id)keyValues {

    NSString * customClassString = [keyValues valueForKey:@"$custom_class"];
    if (customClassString){
        NSString *  selfClasStr = NSStringFromClass([self class]);
        if ([selfClasStr isEqualToString:customClassString]){
            return [self _mj_objectWithKeyValues:keyValues];
        } else{
          Class clazz = NSClassFromString(customClassString);
          if (clazz){
              NSArray * subclasses = [self getClassSuperClasses:clazz];
              if ([subclasses containsObject:selfClasStr]){
                  NSMutableDictionary * mKeyValues = [[NSMutableDictionary alloc] initWithDictionary:keyValues];
                  [keyValues removeObjectForKey:@"$custom_class"];
                  return [clazz mj_objectWithKeyValues:keyValues];
              } else{
                  return [self _mj_objectWithKeyValues:keyValues];
              }
              return nil;

          } else{
              return [self _mj_objectWithKeyValues:keyValues];
          }


        }

    } else{
        return [super mj_objectWithKeyValues:keyValues];
    }

}

+ (instancetype)_mj_objectWithKeyValues:(id)keyValues {


    NSMutableDictionary * mKeyValues = [[NSMutableDictionary alloc] initWithDictionary:keyValues];

    [keyValues removeObjectForKey:@"$custom_class"];
    return [super mj_objectWithKeyValues:keyValues];

}

-(instancetype)init{
    if (self=[super init]) {

        [self observersScopes];

    }
    return self;
}
- (dispatch_queue_t)workQuene {

    if (!_workQuene){
        NSString * quineName =[NSString stringWithFormat:@"com.ppj.object.%@", self];
        _workQuene = dispatch_queue_create([quineName UTF8String],  0);
    }
    return _workQuene;
}

-(void)switchToWorkQueue:(void(^)())queueBlock{
    [PPJQueue switch_to_queue:self.workQuene queueBlock:queueBlock];
}
-(void)switchToMainQueue:(void(^)())queueBlock{
    [PPJQueue switch_to_main_queue:queueBlock];
}

-(void)notifyObserversWithEvent:(PPJEvent *)event{

    [PPJQueue switch_to_queue:self.workQuene queueBlock:^{

        NSHashTable * scopeObservers = [self.observersScopes valueForKey:[event eventName]];
        if (scopeObservers) {

            for (id<PPJEventObserverProt> eventObserver in scopeObservers) {
                [eventObserver ppj_didReceiveEvent:event];
            }

        }

    }];

}
-(void)addEventObserver:(id<PPJEventObserverProt>)eventObserver withScope:(NSArray *)scope{
    [PPJQueue switch_to_queue:self.workQuene queueBlock:^{


        for (NSString * scope_name in scope) {

            NSHashTable * scopeObservers = [self.observersScopes valueForKey:scope_name];
            if (!scopeObservers) {
                scopeObservers=[NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
                [self.observersScopes setObject:scopeObservers forKey:scope_name];
            }
            else  if ([scopeObservers containsObject:eventObserver]) {
                continue;
            }
            [scopeObservers addObject:eventObserver];
        }
    }];
}
-(void)removeEventObserver:(id<PPJEventObserverProt>)eventObserver{

    [PPJQueue switch_to_queue:self.workQuene queueBlock:^{


        for (NSString * key  in self.observersScopes) {
            NSHashTable * scopeObservers = [self.observersScopes valueForKey:key];

            if (scopeObservers) {

                while (      [scopeObservers containsObject:eventObserver]) {
                    [scopeObservers removeObject:eventObserver];
                }
            }
        }


    }];

}
#pragma mark - PPJEventObserverProt

- (void)ppj_didReceiveEvent:(PPJEvent *)event {

}

#pragma mark - lazy init
-(NSMutableDictionary *)observersScopes{
    if (!_observersScopes) {
        _observersScopes=[[NSMutableDictionary alloc] init];
    }
    return _observersScopes;
}

#pragma mark - supporting

//- (NSString *)description {
//
//    return [NSString stringWithFormat:@"%@:%@",self,[self mj_keyValues]];
//}
#pragma mark - helpers

+(NSArray*)getClassSuperClasses:(Class) _aClass{

    Class aClass = _aClass;
NSMutableArray * result = [[NSMutableArray alloc] init];
    while ([class_getSuperclass(aClass) isSubclassOfClass:[PPJObject class] ]){
        aClass=class_getSuperclass(aClass);
        [result addObject:NSStringFromClass(aClass)];
    }
    return result;
}

NSArray *ClassGetSubclasses(Class parentClass)
{
    int numClasses = objc_getClassList(NULL, 0);
    Class *classes = NULL;
    classes = (Class *)realloc(classes, sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);

    NSMutableArray *result = [NSMutableArray array];
    for (NSInteger i = 0; i < numClasses; i++)
    {
        Class superClass = classes[i];
        do
        {
            superClass = class_getSuperclass(superClass);
        } while(superClass && superClass != parentClass);

        if (superClass == nil)
        {
            continue;
        }

        [result addObject:classes[i]];
    }

    free(classes);

    return result;
}
+ (NSArray *)mj_ignoredPropertyNames {
    return @[@"workQuene"];
}
@end