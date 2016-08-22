//
//  PPKeyBoardedNavigationController.h
//  Gabbermap
//
//  Created by Alex Padalko on 2/18/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PPKeyBoardedViewControllerProt;
@interface PPKeyBoardedNavigationController : UINavigationController
@property(nullable, nonatomic,readonly,strong) UIViewController< PPKeyBoardedViewControllerProt> *topViewController;
@end
