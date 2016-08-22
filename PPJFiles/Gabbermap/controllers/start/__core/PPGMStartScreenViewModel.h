//
//  PPGMStartScreenViewModel.h
//  Gabbermap
//
//  Created by Alex Padalko on 2/17/16.
//  Copyright © 2016 com.placepixel. All rights reserved.
//

#import "PPJViewModel.h"
@interface PPGMStartScreenViewModel : PPJViewModel

@property (nonatomic,retain)RACCommand * continueCommand;

@property (nonatomic,retain)RACSignal * loadingSignal;
@property (nonatomic,retain)RACSignal * stopLoadingSignal;

@property (nonatomic)BOOL internetConnectionAvailable;

-(void)startLoad;
-(void)stopLoad:(NSError*)error;
@end
