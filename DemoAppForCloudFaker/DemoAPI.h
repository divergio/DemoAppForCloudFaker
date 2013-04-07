//
//  DemoAPI.h
//  DemoAppForCloudFaker
//
//  Created by Tyler Barth on 2013-04-07.
//  Copyright (c) 2013年 Tyler Barth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoAPI : NSObject

- (void) feedItemsForAccountId: (NSString*) accountId
                       success:(void(^)(NSArray* items))successBlock
                       failure:(void(^)())failureBlock;

- (void) commentsForItemId: (NSString*) itemId
                   success:(void(^)(NSArray* comments))successBlock
                   failure:(void(^)())failureBlock;
    
- (void) authorInfoForAuthorId: (NSString*) authorId
                       success:(void(^)(NSDictionary* authorInfoDict))successBlock
                       failure:(void(^)())failureBlock;

@end
