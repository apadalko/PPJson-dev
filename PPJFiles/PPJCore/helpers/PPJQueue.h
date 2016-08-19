//
//  PPJQueue.h
//  PPJson
//
//  Created by Alex Padalko on 8/18/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPJQueue : NSObject
+(void)switch_to_main_queue:(void(^)())queueBlock;
+(void)switch_to_BKGR_queue:(void(^)())queueBlock;
+(void)switch_to_queue:(dispatch_queue_t)queue queueBlock:(void(^)())queueBlock;
@end
