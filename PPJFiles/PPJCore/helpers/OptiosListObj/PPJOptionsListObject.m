//
//  PPJOptionsListObject.m
//  Gabbermap
//
//  Created by Alex Padalko on 2/17/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPJOptionsListObject.h"

@interface PPJOptionsListOption ()



@end
@implementation PPJOptionsListOption

+(instancetype)createOptionWithAction:(PPJAction *)action andName:(NSString *)name {
    return [[self alloc] initOptionWithAction:action andName:name];
}
-(instancetype)initOptionWithAction:(PPJAction *)action andName:(NSString *)name{
    
    if (self=[super init]) {
        _action=action;
        _name=name;
        _destructive=NO;
    }
    return self;
    
}
-(instancetype)setOptionDestructive:(BOOL)destructive{
    
    _destructive=destructive;
    return self;
}
@end


@interface PPJOptionsListObject ()

@end
@implementation PPJOptionsListObject
+(instancetype)createListWithOptions:(NSArray<PPJOptionsListOption*>*)options andTitle:(NSString *)title andCancelButtonTitle:(NSString *)cancelButtonTitle{
    return [[self alloc] initListWithOptions:options andTitle:title andCancelButtonTitle:cancelButtonTitle];
}
-(instancetype)initListWithOptions:(NSArray<PPJOptionsListOption*>*)options andTitle:(NSString *)title andCancelButtonTitle:(NSString *)cancelButtonTitle{
    if (self=[super init]) {
        _options=options;
        _title=title;

        _cancelButtonTitle=cancelButtonTitle;
    }
    return self;
}
-(NSArray *)allButtonsTitles{
    NSMutableArray * arr =[[NSMutableArray alloc] init];
    
    
    for (PPJOptionsListOption * ob in self.options) {
        [arr addObject:ob.name];
    }
    
    return arr;
    
}

@end

