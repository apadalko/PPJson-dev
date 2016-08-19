//
//  PPJEventObserverProt.h
//  PPJson
//
//  Created by Alex Padalko on 8/18/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PPJEvent;
@protocol PPJEventObserverProt <NSObject>
-(void)ppj_didReceiveEvent:(PPJEvent*)event;
@end
