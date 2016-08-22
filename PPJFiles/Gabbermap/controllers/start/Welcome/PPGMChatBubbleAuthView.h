//
//  PPGMChatBubbleAuthView.h
//  Gabbermap
//
//  Created by Alex Padalko on 6/2/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGMWelcomeChatBubbleView.h"

@protocol PPGMChatBubbleAuthViewDelegate <NSObject>

-(void)authBubble_didSelectFacebook;
-(void)authBubble_didSelectSkip;
-(void)authBubble_didSelectSignIn;
-(void)authBubble_didSelectSignUp;
@end


@interface PPGMChatBubbleAuthView : PPGMWelcomeChatBubbleView


@property (nonatomic,weak)id<PPGMChatBubbleAuthViewDelegate> delegate;

@end
