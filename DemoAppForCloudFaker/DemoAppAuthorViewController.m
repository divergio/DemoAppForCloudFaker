//
//  DemoAppAuthorViewController.m
//  DemoAppForCloudFaker
//
//  Created by Tyler Barth on 2013-04-11.
//  Copyright (c) 2013年 Tyler Barth. All rights reserved.
//

#import "DemoAppAuthorViewController.h"
#import "DemoAuthor.h"
#import "DemoAPI.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DemoAppAuthorViewController ()

@property (nonatomic, weak) IBOutlet UITextView* descriptionText;
@property (nonatomic, weak) IBOutlet UILabel* homeLabel;
@property (nonatomic, weak) IBOutlet UILabel* nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView* authorImage;

@property (nonatomic, strong) DemoAuthor* author;

@end

@implementation DemoAppAuthorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[DemoAPI sharedAPI] authorForAuthorId:self.authorId success:^(DemoAuthor *author) {
        self.author = author;
    } failure:^{
#ifdef DEBUG
        NSLog(@"Problem getting author info.");
#endif
    }];
    
}

- (void) setAuthor:(DemoAuthor *)author
{
    if (!_author && _author != author)
    {
        _author = author;
        [self displayAuthor:author];
    }
}

- (void) displayAuthor: (DemoAuthor*) author
{
    [self.authorImage setImageWithURL:author.authorImageURL placeholderImage:[UIImage imageNamed:@"placeholder_100_square@2x.png"]];
    [self.nameLabel setText:author.authorName];
    [self.homeLabel setText:author.authorHome];
    [self.descriptionText setText:author.authorBio];
}


@end
