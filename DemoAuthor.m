//
//  DemoAuthor.m
//  DemoAppForCloudFaker
//
//  Created by Tyler Barth on 2013-04-07.
//  Copyright (c) 2013年 Tyler Barth. All rights reserved.
//

#import "DemoAuthor.h"

@implementation DemoAuthor


+ (DemoAuthor*) authorFromDict: (NSDictionary*) dict
{
    DemoAuthor* author = [[DemoAuthor alloc] init];

    author.authorId = dict[@"id"];
    author.authorName = dict[@"name"];
    author.authorHome = dict[@"home"];
    author.authorBio = dict[@"biography"];
    author.authorImageURL = [NSURL URLWithString:dict[@"image"]];
    
    return author;
}

@end
