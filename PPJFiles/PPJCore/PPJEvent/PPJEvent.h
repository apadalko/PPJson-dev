//
//  PPJEvent.h
//  PPJson
//
//  Created by Alex Padalko on 8/18/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPJEvent : NSObject
+(instancetype)createWithName:(NSString*)name andValue:(id)value;
@property (nonatomic,retain)NSString * eventName;
@property (nonatomic)id value;
-(void)kill;

@property  (nonatomic)BOOL alive;
@end
