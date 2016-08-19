//
//  PPJOptionListHandeler.h
//  Gabbermap
//
//  Created by Alex Padalko on 3/17/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PPJViewControllerProt.h"
@protocol PPJOptionListHandler <NSObject>
+(instancetype)createHandler;
-(void)clean;
-(void)ppjvc_didReciveOptionList:(PPJOptionsListObject*)optionList onViewController:(UIViewController<PPJViewControllerProt>*)viewController;
@end
