//
//  DemoAPI.m
//  DemoAppForCloudFaker
//
//  Created by Tyler Barth on 2013-04-07.
//  Copyright (c) 2013年 Tyler Barth. All rights reserved.
//

#import "DemoAPI.h"
#import <AFNetworking/AFNetworking.h>
#import "DemoItem.h"
#import "DemoAuthor.h"

#ifdef DEBUG
    #define kServerURL @"http://localhost:8080"
    #define kStaticServer @"http://dummyserver.com:2000/api/"
#else
    #define kServerURL @"http://realserver.com/api/"
    #define kStaticServer @"http://realserver.com/api/"
#endif

#pragma Response Key
#define kResKeySuccess @"success"
#define kResKeyError @"error"
#define kResKeyItems @"items"
#define kResKeyAuthor @"author"

#pragma Request Parameters
#define kParamAccountId @"account_id"
#define kParamAppSecret @"app_secret"


@interface DemoAPI ()

@property (nonatomic, strong) AFHTTPClient* httpClient;
@property (nonatomic, strong) AFHTTPClient* staticClient;
@property (nonatomic, strong) AFHTTPClient* fancyClient;

@end

@implementation DemoAPI

typedef enum {
    HTTP_REQUEST_TYPE_PUT,
    HTTP_REQUEST_TYPE_GET,
    HTTP_REQUEST_TYPE_POST,
    HTTP_REQUEST_TYPE_DELETE
} HTTP_REQUEST_TYPE ;

static char const * const successKey = "blockSuccess";
static char const * const failureKey = "blockFailure";

- (id) init
{
    self = [super init];
    if (self) {
        _fancyClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kServerURL]];
        _staticClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kStaticServer]];
        [self configureClient:_fancyClient];
        [self configureClient:_staticClient];
        _httpClient = _fancyClient;
    }
    return self;
}

- (void) configureClient: (AFHTTPClient*) client
{
    [client setDefaultHeader:@"Accept" value:@"application/json"];
    [client setDefaultHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
}

+ (DemoAPI*) sharedAPI
{
    static DemoAPI *shared = nil;
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        shared = [[self alloc] init];
        });
    return shared;
}

- (void) feedItemsForAccountId: (NSString*) accountId
                       success:(void(^)(NSArray* items))successBlock
                       failure:(void(^)())failureBlock
{
    NSDictionary *p = @{kParamAccountId: accountId};
    [self sendRequestWithPath:@"/api/items/" type:HTTP_REQUEST_TYPE_GET param:p success:^(NSDictionary *res) {
        NSArray *items = res[kResKeyItems];
        NSMutableArray *itemObjects = [NSMutableArray arrayWithCapacity:[items count]];
        for (NSDictionary *item in items) {
            [itemObjects addObject:[DemoItem itemFromDictionary:item]];
        }
        successBlock(itemObjects);
    } failure:^(){
        failureBlock();
    }];
}

- (void) authorForAuthorId: (NSString*) authorId
                   success:(void(^)(DemoAuthor* author))successBlock
                   failure:(void(^)())failureBlock;
{
    NSDictionary *p = @{kParamAppSecret: [self appSecret]};
    NSString *requestPath = [NSString stringWithFormat:@"/api/author/%@/",authorId];
    [self sendRequestWithPath:requestPath type:HTTP_REQUEST_TYPE_GET param:p success:^(NSDictionary *res) {
        NSDictionary *authorDict = res[kResKeyAuthor];
    
        successBlock([DemoAuthor authorFromDict:authorDict]);
    } failure:^(){
        failureBlock();
    }];
    
}


- (void)sendRequestWithPath:(NSString *)path
                       type:(HTTP_REQUEST_TYPE)type
                      param:(NSDictionary *)params
                    success:(void(^)(NSDictionary *res))successBlock
                    failure:(void(^)())failureBlock
{
    switch (type) {
        case HTTP_REQUEST_TYPE_PUT: {
            [self.httpClient putPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if ([responseObject objectForKey:kResKeyError] == nil) {
                    successBlock((NSDictionary *)[responseObject objectForKey:kResKeySuccess]);
                } else {
                    failureBlock();
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                failureBlock();
            }];
        }
            break;
        case HTTP_REQUEST_TYPE_GET: {
            [self.httpClient getPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if ([responseObject objectForKey:kResKeyError] == nil) {
                    successBlock((NSDictionary *)[responseObject objectForKey:kResKeySuccess]);
                } else {
                    failureBlock();
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                failureBlock();
            }];
        }
            break;
        case HTTP_REQUEST_TYPE_POST: {
            [self.httpClient postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"response data: %@", [(NSDictionary *)responseObject description]);
                if ([responseObject objectForKey:kResKeyError] == nil) {
                    successBlock((NSDictionary *)[responseObject objectForKey:kResKeySuccess]);
                } else {
                    failureBlock();
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                failureBlock();
            }];
        }
            break;
        case HTTP_REQUEST_TYPE_DELETE: {
            [self.httpClient deletePath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if ([responseObject objectForKey:kResKeyError] == nil) {
                    successBlock((NSDictionary *)[responseObject objectForKey:kResKeySuccess]);
                } else {
                    failureBlock();
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                failureBlock();
            }];
        }
            break;
        default:
            break;
    }
}


- (void) changeServer
{
    if (self.httpClient == self.fancyClient) {
        self.httpClient = self.staticClient;
    }
    else {
        self.httpClient = self.fancyClient;
    }
}

- (NSString*) currentUserId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
}

- (NSString*) appSecret
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"appSecret"];
}




@end
