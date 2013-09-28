//
//  CourseDetailViewController.h
//  CurriSchedule
//
//  Created by piner on 4/30/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseDetailViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableViewCell *courseName;
@property (weak, nonatomic) IBOutlet UITableViewCell *courseDetail;
@property (weak, nonatomic) IBOutlet UITableViewCell *courseFooter;

@end
