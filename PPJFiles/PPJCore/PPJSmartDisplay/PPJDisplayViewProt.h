//
//  PPJDisplayObjectDelegate.h
//  Blok
//
//  Created by Alex Padalko on 9/27/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PPJSDObjectDelegate.h"
#import <UIKit/UIKit.h>
@protocol PPJDisplayViewProt <NSObject>


@property (weak,nonatomic)id<PPJSDObjectDelegate> baseViewDelegate;
@property (weak,nonatomic)id parentView;

@property (nonatomic)UIEdgeInsets contentInset;

@end
