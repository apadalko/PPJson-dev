//
//  PPGMAuthViewModel.h
//  Gabbermap
//
//  Created by Alex Padalko on 2/17/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGMStartScreenViewModel.h"
//#import "PPAuthMasterProt.h"
@interface PPGMAuthViewModel : PPGMStartScreenViewModel

@property (nonatomic,retain)RACCommand * facebookAuthCommand;

//-(instancetype)initWithAuthMaster:(id<PPAuthMasterProt>)authMaster;
//@property (nonatomic,retain)id<PPAuthMasterProt>authMaster;
@end
