//
//  PPKeyBoardedViewControllerProt.h
//  Gabbermap
//
//  Created by Alex Padalko on 2/18/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPKeyBoardedNavigationController.h"
@protocol PPKeyBoardedViewControllerProt <NSObject>
@property(nullable, nonatomic,readonly,strong) PPKeyBoardedNavigationController * navigationController;
@property(nonatomic,retain)NSMutableArray * displayItemsArray;
@property (nonatomic,retain)NSMutableArray * textFieldsArray;
@property (nonatomic,retain)UITextField * currentTextField;
@end
