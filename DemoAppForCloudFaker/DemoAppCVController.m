//
//  DemoAppCVController.m
//  DemoAppForCloudFaker
//
//  Created by Tyler Barth on 2013-04-07.
//  Copyright (c) 2013年 Tyler Barth. All rights reserved.
//

#import "DemoAppCVController.h"
#import "DemoAppCell.h"
#import "DemoItem.h"

@interface DemoAppCVController ()

@end

@implementation DemoAppCVController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (DemoAppCell*) configureItemCell: (DemoAppCell*) cell withDemoItem: (DemoItem*) item
{
    
    cell.cellImage 
    
    return cell;
}

@end
