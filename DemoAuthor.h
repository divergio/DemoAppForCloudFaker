//
//  DemoAuthor.h
//  DemoAppForCloudFaker
//
//  Created by Tyler Barth on 2013-04-07.
//  Copyright (c) 2013年 Tyler Barth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoAuthor : NSObject

@property (nonatomic, strong) NSString* authorName;
@property (nonatomic, strong) NSString* authorHome;
@property (nonatomic, strong) NSString* authorBio;
@property (nonatomic, strong) NSURL* authorImageURL;

@end
