//
//  PPJOptionListDefaultHandler.h
//  Gabbermap
//
//  Created by Alex Padalko on 3/17/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPJOptionListHandler.h"
@interface PPJOptionListDefaultHandler : NSObject <PPJOptionListHandler>
@property (weak,nonatomic)UIViewController<PPJViewControllerProt>* vc;
@property (nonatomic,retain)PPJOptionsListObject  * optionList;
@end
