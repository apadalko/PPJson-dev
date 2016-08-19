//
//  PPJSDMultipleContentPageProt.h
//  Blok
//
//  Created by Alex Padalko on 10/9/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPJSDMultipleContentPageProt.h"
#import "PPJSDControllerViewProtocol.h"
@protocol PPJSDMultipleContentPageProt <NSObject>
@property (nonatomic,retain)UIScrollView <PPJSDControllerViewProtocol>  * innerListView;

@property (nonatomic)UIEdgeInsets innerListInsets;
@end
