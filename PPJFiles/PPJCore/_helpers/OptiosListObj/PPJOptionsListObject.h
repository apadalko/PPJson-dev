//
//  PPJOptionsListObject.h
//  Gabbermap
//
//  Created by Alex Padalko on 2/17/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPJAction.h"
@interface PPJOptionsListOption : NSObject

+(instancetype)createOptionWithAction:(PPJAction*)action andName:(NSString*)name;
-(instancetype)initOptionWithAction:(PPJAction*)action andName:(NSString*)name;
@property (nonatomic,readonly)PPJAction * action;
@property (nonatomic,readonly)NSString * name;
@property (nonatomic)BOOL destructive;

-(instancetype)setOptionDestructive:(BOOL)destructive;

@end
@interface PPJOptionsListObject : NSObject
+(instancetype)createListWithOptions:(NSArray<PPJOptionsListOption*>*)options  andTitle:(NSString*)title andCancelButtonTitle:(NSString*)cancelButtonTitle;
-(instancetype)initListWithOptions:(NSArray<PPJOptionsListOption*>*)options  andTitle:(NSString*)title andCancelButtonTitle:(NSString*)cancelButtonTitle;
@property (nonatomic,retain,readonly)NSArray * options;
@property (nonatomic,retain,readonly)NSString * title;
@property (nonatomic,retain,readonly)NSString * cancelButtonTitle;



-(NSArray*)allButtonsTitles;
@end
