//
//  PPUserProt.h
//  Blok
//
//  Created by Alex Padalko on 12/7/15.
//  Copyright © 2015 com.placepixel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPObjectProt.h"

typedef NS_ENUM(NSInteger, PPUserFollowingState) {
    PPUserFollowingStateNo=0,
    PPUserFollowingStateFollwing=1,
};

typedef NS_ENUM(NSInteger,PPUserGender) {
    
    PPUserGenderNone=0,
    PPUserGenderMale=1,
    PPUserGenderFemale=2
    
};
typedef NS_ENUM(NSInteger,PPUserType) {
    
    PPUserTypeDefault=0,
    PPUserTypePersona=1,
    PPUserTypeModer=2,
    
};
@protocol PPUserProt <PPObjectProt>
-(NSString*)username;
-(NSString*)profilePictureUrlStr;
-(NSString*)profilePictureThumbUrlStr;
-(NSString*)fullName;
-(NSString*)bio;
-(BOOL)isSocialUser;
-(NSInteger)karmaIntgr;

-(BOOL)isCurrentUser;
-(PPUserGender)userGender;

-(PPUserType)userTypeIntgr;


-(NSInteger)followingsCountIntgr;
-(NSInteger)followersCountIntgr;

-(PPUserFollowingState)followingStateIntgr;
@property (nonatomic,retain)NSNumber * nextFollowingState;
@property (nonatomic,retain)NSNumber * processingFollowingState;
@property (nonatomic,retain)NSNumber * followingState;
-(PPUserFollowingState)invertedFollowingStateFromState:(PPUserFollowingState)state;

@end
