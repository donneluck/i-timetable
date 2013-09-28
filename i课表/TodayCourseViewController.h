//
//  TodayCourseViewController.h
//  CurriSchedule
//
//  Created by piner on 5/1/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "CourseCell.h"

@interface TodayCourseViewController : UITableViewController

@property(nonatomic,strong)NSArray *todayList;
@property(nonatomic,strong)NSArray *imageList;

@end
