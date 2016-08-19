//
//  PPJSDMultipleContentPageSelectorProt.h
//  Blok
//
//  Created by Alex Padalko on 10/9/15.
//  Copyright © 2015 Alex Padalko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol PPJSDMultipleContentPageSelectorProt <NSObject>
+(instancetype)create;
@property (nonatomic,weak)UIScrollView * pageView;
@property (nonatomic)NSInteger segmetsCount;
@property (nonatomic,retain)NSMutableArray * buttonsArray;
-(void)setTitile:(NSString*)title forIndex:(NSInteger)index;
-(void)didEndScrollWithOffset:(float)offset;
@end
