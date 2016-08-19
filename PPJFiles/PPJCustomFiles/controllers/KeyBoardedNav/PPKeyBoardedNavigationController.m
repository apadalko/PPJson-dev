//
//  PPKeyBoardedNavigationController.m
//  Gabbermap
//
//  Created by Alex Padalko on 2/18/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPKeyBoardedNavigationController.h"
#import "PPKeyBoardedViewControllerProt.h"
#import "UIColor+HEX.h"
@interface PPKeyBoardedNavigationController ()<UINavigationControllerDelegate>
@property (nonatomic,retain)UINavigationBar * bottomBarr;
@property (nonatomic)float keyBoardHeight;
@property (nonatomic)BOOL blockLayout;
@end
@implementation PPKeyBoardedNavigationController

@dynamic topViewController;


-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorFromHexString:@"10d6d2"]];
    [self setNavigationBarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
//    [self setDelegate:self];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    
    [super dismissViewControllerAnimated:flag completion:^(){
        
        if (completion) {
               completion();
                     }
     
        [[self.topViewController currentTextField] resignFirstResponder];

    }];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
  
}



@end
