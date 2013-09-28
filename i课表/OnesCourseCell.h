//
//  OnesCourseCell.h
//  CurriSchedule
//
//  Created by Donne on 5/27/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnesCourseViewController.h"

@class OnesCourseViewController;

@interface OnesCourseCell : UITableViewCell{
    MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UILabel *courseTeacher;
@property (weak, nonatomic) IBOutlet UILabel *courseRoom;
@property (weak, nonatomic) IBOutlet UILabel *courseTime;
@property (weak, nonatomic) IBOutlet UILabel *courseOwn;
@property(nonatomic,strong)NSString *classNo;
- (IBAction)addCourse:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property(nonatomic,strong)OnesCourseViewController *preViewController;
@end
