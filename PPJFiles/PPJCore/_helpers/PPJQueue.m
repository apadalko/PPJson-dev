//
//  PPJQueue.m
//  PPJson
//
//  Created by Alex Padalko on 8/18/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPJQueue.h"

@implementation PPJQueue
+(void)switch_to_main_queue:(void(^)())queueBlock{
    dispatch_async(dispatch_get_main_queue(), queueBlock);
}
+(void)switch_to_BKGR_queue:(void(^)())queueBlock{
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), queueBlock);
}
+(void)switch_to_queue:(dispatch_queue_t)queue queueBlock:(void(^)())queueBlock{
          dispatch_async(queue, queueBlock);
    
}
@end
