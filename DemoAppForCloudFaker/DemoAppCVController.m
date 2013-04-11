//
//  DemoAppCVController.m
//  DemoAppForCloudFaker
//
//  Created by Tyler Barth on 2013-04-07.
//  Copyright (c) 2013年 Tyler Barth. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "DemoAppCVController.h"
#import "DemoAppCell.h"
#import "DemoItem.h"
#import "DemoAPI.h"
#import "DemoAppAuthorViewController.h"


@interface DemoAppCVController ()

@property (nonatomic, strong) NSMutableArray* feedItems;

@end

@implementation DemoAppCVController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _feedItems = [NSMutableArray new];
}

- (void) appendFeedItems:(NSArray*)itemsToAppend
{
    [self.feedItems addObjectsFromArray:itemsToAppend];
    [self.collectionView reloadData];
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.feedItems count];
}


- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Get cell
    DemoAppCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Demo App Cell" forIndexPath:indexPath];
    //Get associated item
    DemoItem* item = [self.feedItems objectAtIndex:[indexPath item]];
    //Return configured item
    return [self configureItemCell:cell withDemoItem:item];
}

- (DemoAppCell*) configureItemCell: (DemoAppCell*) cell withDemoItem: (DemoItem*) item
{
    [cell.cellImage setImageWithURL:[item itemURL] placeholderImage:[UIImage imageNamed:@"placeholder_100_square"]];
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Select Item"]) {
        NSIndexPath *selected = [[self.collectionView indexPathsForSelectedItems] lastObject];
        DemoItem* selectedItem = [self.feedItems objectAtIndex:[selected item]];
        NSString* authorId = selectedItem.ownerId;
        [segue.destinationViewController setAuthorId:authorId];
    }
}

#pragma mark - Top Button actions
- (IBAction)refresh:(id)sender;
{
    [[DemoAPI sharedAPI] feedItemsForAccountId:[[DemoAPI sharedAPI] currentUserId] success:^(NSArray *items) {
        [self appendFeedItems:items];
    } failure:^{
        NSLog(@"WARNING: Some problem getting feed items");
    }];
}

- (IBAction)changeServer:(id)sender
{
    _feedItems = [NSMutableArray new];
    [[DemoAPI sharedAPI] changeServer];
    [self refresh:self];
}


@end
