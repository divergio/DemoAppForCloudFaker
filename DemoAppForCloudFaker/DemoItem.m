//
//  DemoItem.m
//  DemoAppForCloudFaker
//
//  Created by Tyler Barth on 2013-04-07.
//  Copyright (c) 2013年 Tyler Barth. All rights reserved.
//

#import "DemoItem.h"

@implementation DemoItem

+ (DemoItem*) itemFromDictionary:(NSDictionary*) dict {
    DemoItem* item = [[DemoItem alloc] init];
    
    item.itemId = dict[@"id"];
    item.itemURL = [NSURL URLWithString:dict[@"image"]];
    item.price = dict[@"price"];
    item.description = dict[@"description"];
    item.category = dict[@"category"];
    item.ownerId = dict[@"owner_id"];
    
    return item;
}

@end
