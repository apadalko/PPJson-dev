//
//  PPGridCellChatBubleView.h
//  Gabbermap
//
//  Created by Alex Padalko on 2/22/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPGridCellChatBubleView : UIView

-(instancetype)initWithText:(NSString*)text;

-(void)rotatebubble;
@property (nonatomic,retain)NSString * text;

@end
