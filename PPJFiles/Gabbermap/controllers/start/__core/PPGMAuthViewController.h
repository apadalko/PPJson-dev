//
//  PPGMAuthViewController.h
//  Gabbermap
//
//  Created by Alex Padalko on 2/17/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGMStartScreenViewController.h"
#import "PPGMAuthViewModel.h"

@interface PPGMAuthViewController : PPGMStartScreenViewController
@property (nonatomic,retain)PPGMAuthViewModel* viewModel;
@property (nonatomic,retain)PP3dButton * faceBookButton;
@property (nonatomic,retain)UILabel * orLabel;







@end
