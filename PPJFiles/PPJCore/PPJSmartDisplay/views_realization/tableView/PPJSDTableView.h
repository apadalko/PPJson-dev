//
//  PPJSDTableView.h
//  PPJSmartDisplay
//
//  Created by Alex Padalko on 4/13/15.
//  Copyright (c) 2015 Alex Padalko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPJSDController.h"

typedef NS_ENUM(NSInteger, PPJSDTableViewDisplayType) {
    
    PPJSDTableViewDisplayTypeOneObejectOneSection,
    PPJSDTableViewDisplayTypeOneObejectOneRow
    
};
@interface PPJSDTableView : UITableView<PPJSDControllerViewProtocol,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic)PPJSDTableViewDisplayType displayType; //default PPJSDTableViewDisplayTypeOneObejectOneSection

@property (nonatomic)BOOL shouldCopyTransform;

-(id<PPJSDObjectProtocol>)objectForIndex:(NSInteger)index;




@property (nonatomic)BOOL resignResponderOnScroll;

@end
