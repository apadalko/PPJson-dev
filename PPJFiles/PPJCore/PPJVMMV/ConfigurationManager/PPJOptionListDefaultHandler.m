//
//  PPJOptionListDefaultHandler.m
//  Gabbermap
//
//  Created by Alex Padalko on 3/17/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPJOptionListDefaultHandler.h"

@interface PPJOptionListDefaultHandler () <UIActionSheetDelegate>

@end

@implementation PPJOptionListDefaultHandler
static PPJOptionListDefaultHandler * inst;
+(instancetype)createHandler{
    
    inst=[[self alloc] init];
    
    return inst;
    
}

-(void)ppjvc_didReciveOptionList:(PPJOptionsListObject*)optionList onViewController:(UIViewController<PPJViewControllerProt>*)viewController{
    
    self.vc=viewController;
    self.optionList=optionList;
    
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:optionList.title delegate:self cancelButtonTitle:optionList.cancelButtonTitle destructiveButtonTitle:nil otherButtonTitles:nil];
        
        for (NSInteger a = 0 ; a<optionList.options.count; a++) {
            PPJOptionsListOption * option = [optionList.options objectAtIndex:a];
            
            [actionsheet addButtonWithTitle:[option name]];
            
            if ([option destructive]) {
                
                [actionsheet setDestructiveButtonIndex:a+1];
            }
            
        }
        
        actionsheet.frame = CGRectMake(0, 150.0f, self.vc.view.frame.size.width, 100.0f);
        actionsheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionsheet showInView:[UIApplication sharedApplication].keyWindow];
        
        
    
    

}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex>0) {
        
        NSInteger realIdx = buttonIndex-1;
        
        if (realIdx<self.optionList.options.count) {
            
            PPJOptionsListOption * option = [[self.optionList options] objectAtIndex:realIdx];
            [self.vc.viewModel didReciveAction:[option action]];
        }
        
    }
    self.optionList=nil;
    [self clean];
    
}
-(void)clean{
    inst=nil;
}
@end
