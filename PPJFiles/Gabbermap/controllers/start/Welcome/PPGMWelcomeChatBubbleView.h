//
//  PPGMChatBubbleView.h
//  Gabbermap
//
//  Created by Alex Padalko on 6/2/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPJView.h"
typedef NS_ENUM(NSInteger,PPGMChatBubbleDirection) {
    PPGMChatBubbleDirectionLeft,
    PPGMChatBubbleDirectionRight,
    PPGMChatBubbleDirectionTop,
    PPGMChatBubbleDirectionBottom
    
};

@interface PPGMWelcomeChatBubbleView : PPJView
-(void)showFromPoint:(CGPoint)point withDirection:(PPGMChatBubbleDirection)direction removeAfter:(float)removeAfter;
@property (nonatomic,retain)UIView * contentView;
@property (nonatomic)UIEdgeInsets contentViewInsets;
@end
