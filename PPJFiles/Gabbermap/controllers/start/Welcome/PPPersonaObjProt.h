//
//  PPPersonaObjProt.h
//  Blok
//
//  Created by Alex Padalko on 12/22/15.
//  Copyright © 2015 com.placepixel. All rights reserved.
//

#import "PPUserProt.h"

@protocol PPPersonaObjProt <PPUserProt>
-(NSString*) personaCoverImage;
-(NSString*) personaName;
-(NSArray *) personaTagsArray;



-(NSString*)tagsText;

-(NSString*)localAnimationGifName;
-(NSString*)animationGifUrlStr;

@end
