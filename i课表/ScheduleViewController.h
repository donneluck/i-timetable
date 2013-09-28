//
//  ScheduleViewController.h
//  CurriSchedule
//
//  Created by piner on 4/29/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "TodayCourseViewController.h"

#import "CourseDetailViewController.h"
#import "DetailViewController.h"
#import "AddCourseFromButtonViewController.h"
#import "AddCourseFromButtonNavViewController.h"

#import "QBFlatButton.h"

@interface ScheduleViewController : UIViewController

//@property CourseDetailViewController *courseDetailViewController;
@property(nonatomic,strong)NSDictionary *theCourse;
//@property(nonatomic,strong)UIStoryboardSegue *segue;
@property(nonatomic,strong)NSMutableDictionary *buttonDictionary;
@property(nonatomic,strong)NSMutableDictionary *emptyButtonDictionary;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

- (IBAction)RevealMenu:(id)sender;
- (IBAction)RevealToday:(id)sender;

@property(nonatomic)int nowWeek;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;


-(IBAction)showNextWeek;
-(IBAction)showPreWeek;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@end
