//
//  PPJSDTableViewCell.h
//  Blok
//
//  Created by Alex Padalko on 9/27/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPJDisplayViewProt.h"
@interface PPJSDTableViewCell : UITableViewCell
@property (weak,nonatomic)UIView <PPJDisplayViewProt>* displayView;
@end
