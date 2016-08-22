//
//  PPGridCellChatBubleView.h
//  Gabbermap
//
//  Created by Alex Padalko on 2/22/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPJView.h"

@interface PPGridCellChatBubleView : PPJView

-(instancetype)initWithText:(NSString*)text;

-(void)rotatebubble;
@property (nonatomic,retain)NSString * text;

@end
