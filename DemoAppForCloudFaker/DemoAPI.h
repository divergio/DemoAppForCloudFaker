//
//  DemoAPI.h
//  DemoAppForCloudFaker
//
//  Created by Tyler Barth on 2013-04-07.
//  Copyright (c) 2013年 Tyler Barth. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DemoAuthor;

@interface DemoAPI : NSObject

+ (DemoAPI*) sharedAPI;

- (NSString*) currentUserId;

- (void) changeServer;

- (void) feedItemsForAccountId: (NSString*) accountId
                       success:(void(^)(NSArray* items))successBlock
                       failure:(void(^)())failureBlock;

- (void) authorForAuthorId: (NSString*) authorId
                       success:(void(^)(DemoAuthor* author))successBlock
                       failure:(void(^)())failureBlock;

/* TODO later
- (void) commentsForItemId: (NSString*) itemId
                  language: (NSString*) lang
                   success:(void(^)(NSArray* comments))successBlock
                   failure:(void(^)())failureBlock;
*/

@end
