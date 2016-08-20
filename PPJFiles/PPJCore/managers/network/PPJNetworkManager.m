//
//  PPJNetworkManager.m
//  PPJson
//
//  Created by Alex Padalko on 8/18/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//
#import "Reachability.h"
#import "PPJNetworkManager.h"
NSString *kPPJEventNetworkManagerNeworkAvilable = @"network_available";
@interface PPJNetworkManager () {
    BOOL _firstStatus;
}
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) NetworkStatus lastReachabilityStatus;
@end
@implementation PPJNetworkManager


- (BOOL)networkAvailable {

    return self.lastReachabilityStatus==NotReachable?NO:YES;
}

- (id)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        
        self.internetReachability = [Reachability reachabilityForInternetConnection];
        [self.internetReachability startNotifier];
        [self updateInterfaceWithReachability:self.internetReachability];
    }
    return self;
}
- (void) reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    //    [self updateInterfaceWithReachability:curReach];
    self.lastReachabilityStatus=[curReach currentReachabilityStatus];
    BOOL reacheable = self.lastReachabilityStatus==NotReachable?NO:YES;
    [self notifyObserversWithEvent:[PPJEvent createWithName:kPPJEventNetworkManagerNeworkAvilable andValue:@(reacheable)]];
    
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability {
    if (_firstStatus && reachability == self.internetReachability) {
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        self.lastReachabilityStatus = netStatus;
        
        
        
        
        
        switch (netStatus) {
            case ReachableViaWWAN:
            case ReachableViaWiFi: {
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                BOOL uploadStatus = [defaults boolForKey:@"uploadFailed"];
                if (uploadStatus)
                {
                    
                    
                    
                    
                }
                
                break;
            }
            case NotReachable:
                break;
        }
    } else {
        _firstStatus = true;
    }
}

@end
