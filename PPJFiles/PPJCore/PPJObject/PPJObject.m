//
// Created by Alex Padalko on 8/18/16.
// Copyright (c) 2016 PlacePixel. All rights reserved.
//

#import "PPJObject.h"
#import "PPJFabricPool.h"
NSString *kPPJEventScopeAny = @"!any";
@interface PPJObject()
@property (nonatomic,retain)NSMutableDictionary * observersScopes;
@property (nonatomic, retain)NSMutableDictionary * _data;
@end
@implementation PPJObject {

}


#pragma mark - parenting
-(void)removeChild:(PPJObject *)object{
    [self switchToWorkQueue:^{
        [self.children removeObject:object];
    }];

}
-(void)removeFromParentObject{
    [self.parent removeChild:self];
    self.parent=nil;

}
-(void)addChildSubObject:(PPJObject *)object{
    object.parent=self;
    [self switchToWorkQueue:^{
        if ([self.children containsObject:object]){
            [self.children addObject:object];
        }

    }];


}
- (NSMutableArray *)children {
    if (!_children){
        _children=[[NSMutableArray alloc] init];
    }
    return _children;
}

#pragma  mark - core ppjobject

-(id)valueForUndefinedKey:(NSString *)key{


    return [self._data valueForKey:key];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{


    [self._data setValue:[self __processValue:value] forKey:key];

    NSLog(@"??%@",key);
}

-(id)__processValue:(id)value{

    return value;
//    if ([value isKindOfClass:[NSArray class]]) {
//        NSMutableArray * res = [[NSMutableArray alloc] init];
//        for (id val in value){
//
//            [res addObject:[self processValue:val]];
//        }
//        return res;
//    }else if ([value isKindOfClass:[NSDictionary class]]){
//        return [PPJObject createWithData:value];
//    }else return value;
}

-(NSMutableDictionary *)_data{
    if (!__data) {
        __data=[[NSMutableDictionary alloc] init];
    }
    return __data;
}

#pragma mark -

+ (instancetype)mj_objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context {


    NSString * customClassString = [keyValues valueForKey:@"$custom_class"];
    if (customClassString){
        NSString *  selfClasStr = NSStringFromClass([self class]);
        if ([selfClasStr isEqualToString:customClassString]){
            return [self _mj_objectWithKeyValues:keyValues context:context];
        } else{
          Class clazz = NSClassFromString(customClassString);
          if (clazz){
              NSArray * subclasses = [self getClassSuperClasses:clazz];
              if ([subclasses containsObject:selfClasStr]){
                  NSMutableDictionary * mKeyValues = [[NSMutableDictionary alloc] initWithDictionary:keyValues];
                  [keyValues removeObjectForKey:@"$custom_class"];
                  return [clazz mj_objectWithKeyValues:mKeyValues context:context];
              } else{
                  return [self _mj_objectWithKeyValues:keyValues context:context];
              }
              return nil;

          } else{
              return [self _mj_objectWithKeyValues:keyValues context:context];
          }


        }

    } else{
        return [self _mj_objectWithKeyValues:keyValues context:context];
    }

}

+ (instancetype)_mj_objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context  {
    NSMutableDictionary * mKeyValues = [[NSMutableDictionary alloc] initWithDictionary:keyValues];
    [keyValues removeObjectForKey:@"$custom_class"];
    if ([keyValues valueForKey:@"$import"]) {
        for (NSString *importFile in [keyValues valueForKey:@"$import"]) {

            NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:importFile ofType:@"json"]];

            NSError *readError;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&readError];
            [mKeyValues setValuesForKeysWithDictionary:dict];
        }
    }

    ///services
    PPJObject * obj = [super mj_objectWithKeyValues:mKeyValues context:context];
    {
        NSDictionary * services = [mKeyValues valueForKey:@"$services"];
        for (NSString * key in services){
            id service = [[PPJFabricPool sharedInstance] getObjectForRequestType:PPJFabricPoolRequestTypeService className:[services valueForKey:key] ];
            if (service){

                [obj setValue:service forKey:key];
            }
        }
    }
    {
        NSDictionary * services = [mKeyValues valueForKey:@"$clients"];
        for (NSString * key in services){
            id service = [[PPJFabricPool sharedInstance] getObjectForRequestType:PPJFabricPoolRequestTypeClient className:[services valueForKey:key] ];
            if (service){

                [obj setValue:service forKey:key];
            }
        }
    }
//    {
//        NSDictionary * services = [mKeyValues valueForKey:@"managers"];
//        for (NSString * key in services){
//            id service = [[PPJFabricPool sharedInstance] getObjectForRequestType:PPJFabricPoolRequestTypeService className:[services valueForKey:key] ];
//            if (service){
//
//                [obj setValue:service forKey:key];
//            }
//        }
//    }


    return obj;
}



//- (instancetype)mj_setKeyValues:(id)keyValues {
//    if ([keyValues valueForKey:@"$import"]){
//        NSMutableDictionary * mKeyValues = [[NSMutableDictionary alloc] initWithDictionary:keyValues];
//        [keyValues removeObjectForKey:@"$custom_class"];
//        for(NSString * importFile in [keyValues valueForKey:@"$import"]){
//
//            NSData * data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:importFile ofType:@"json"]];
//
//            NSError * readError;
//            NSDictionary *  dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&readError];
//            [mKeyValues setValuesForKeysWithDictionary:data];
//        }
//        return   [super mj_setKeyValues:mKeyValues];
//    } else{
//        return   [super mj_setKeyValues:keyValues];
//    }
//
//
//}
-(instancetype)init{
    if (self=[super init]) {

        [self observersScopes];

    }
    return self;
}
- (dispatch_queue_t)workQuene {

    if (!_workQuene){
        NSString * quineName =[NSString stringWithFormat:@"com.ppj.object.type.%@", NSStringFromClass([self class])];
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

-(void)__notifyScopeByKey:(NSString *)key withEvent:(PPJEvent *)event{
    NSHashTable * scopeObservers = [self.observersScopes valueForKey:key];
    if (scopeObservers) {

        for (PPJObject<PPJEventObserverProt>* eventObserver in scopeObservers) {
            if ([eventObserver isKindOfClass:[PPJObject class]]){
                [eventObserver switchToWorkQueue:^{
                    [eventObserver ppj_didReceiveEvent:event];
                }];
            } else{
                [PPJQueue switch_to_main_queue:^{
                    [eventObserver ppj_didReceiveEvent:event];
                }];

            }

        }

    }
}
-(void)notifyObserversWithEvent:(PPJEvent *)event{

    [PPJQueue switch_to_queue:self.workQuene queueBlock:^{
        [self __notifyScopeByKey:[event eventName] withEvent:event];
        [self __notifyScopeByKey:kPPJEventScopeAny withEvent:event];
    }];

}
- (void)addEventObserver:(id <PPJEventObserverProt>)eventObserver {

    [self addEventObserver:eventObserver withScope:@[kPPJEventScopeAny]];
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