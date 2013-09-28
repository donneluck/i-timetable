//
//  SecondLevelViewController.h
//  CurriSchedule
//
//  Created by piner on 5/15/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondLevelCell.h"
#import "ThirdLevelViewController.h"

@interface SecondLevelViewController : UITableViewController

@property(nonatomic,strong)NSArray *courseList;


@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@end
