//
//  DemoItem.h
//  DemoAppForCloudFaker
//
//  Created by Tyler Barth on 2013-04-07.
//  Copyright (c) 2013年 Tyler Barth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoItem : NSObject

@property (nonatomic, strong) NSString* itemId;
@property (nonatomic, strong) NSURL* itemURL;
@property (nonatomic, strong) NSNumber* price;
@property (nonatomic, strong) NSString* description;
@property (nonatomic, strong) NSString* category;
@property (nonatomic, strong) NSString* ownerId;

+ (DemoItem*) itemFromDictionary:(NSDictionary*) dict;

@end
