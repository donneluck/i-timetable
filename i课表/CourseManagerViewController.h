//
//  CourseManagerViewController.h
//  CurriSchedule
//
//  Created by piner on 5/1/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "MyCourseCell.h"
#import "MyCourseDetailViewController.h"

@interface CourseManagerViewController : UITableViewController

@property(nonatomic,strong)NSArray *courseList;

- (IBAction)RevealMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@end
