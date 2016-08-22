//
//  PPGMWelcomeScreenViewModel.h
//  Gabbermap
//
//  Created by Alex Padalko on 2/17/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPGMStartScreenViewModel.h"
#import "PPGMAuthViewModel.h"
#import "PPGridCellUserObject.h"
//#import "PPCurrentUserMasterProt.h"
@protocol PPDeepLinkMasterProt;

@interface PPGMWelcomeScreenViewModel : PPGMAuthViewModel

//-(instancetype)initWithAuthMaster:(id<PPAuthMasterProt>)authMaster currentUserMaster:(id<PPCurrentUserMasterProt>)currentUserMaster andDeepLinkMasterProt:(id<PPDeepLinkMasterProt>)deepLinkMaster animatedAppereance:(BOOL)animatedAppeareance;

@property (nonatomic,retain)RACCommand * skipCommand;
@property (nonatomic,retain)RACCommand * signInCommand;
@property (nonatomic,retain)RACCommand * singUpCommad;

//@property (nonatomic,retain)id<PPCurrentUserMasterProt>currentUserMaster;

@end
