//
//  MyCourseDetailViewController.h
//  CurriSchedule
//
//  Created by piner on 5/13/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseManagerViewController.h"

@class CourseManagerViewController;

@interface MyCourseDetailViewController : UIViewController<UIActionSheetDelegate,MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}

@property(nonatomic)int selectRow;

@property(nonatomic,strong) NSDictionary *course;
@property CourseManagerViewController *preViewController;

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UILabel *courseTeacher;
@property (weak, nonatomic) IBOutlet UILabel *coursePlace;
@property (weak, nonatomic) IBOutlet UILabel *courseTime;
//@property (weak, nonatomic) IBOutlet UILabel *courseWeek;
@property (weak, nonatomic) IBOutlet UILabel *courseCycle;
@property (weak, nonatomic) IBOutlet UILabel *isChooseOwn;
@property (weak, nonatomic) IBOutlet UILabel *courseDetail;

- (IBAction)deleteAction:(id)sender;
@end
