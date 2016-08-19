//
//  PPJSDEmptyView.m
//  Gabbermap
//
//  Created by Alex Padalko on 2/25/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPJSDEmptyView.h"
@interface PPJSDEmptyView()
@property (nonatomic,retain)UILabel * label;

@end

@implementation PPJSDEmptyView
-(UILabel *)label{
    if (!_label) {
        _label=[[UILabel alloc] init];
        [_label setFont:[UIFont systemFontOfSize:18]];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setText:@"EMPTY:("];
        [self addSubview:_label];
    }
    return _label;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.label setFrame:CGRectMake(16, 16, self.frame.size.width-32, self.frame.size.height-32)];
}
@end
