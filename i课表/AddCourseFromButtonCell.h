//
//  AddCourseFromButtonCell.h
//  CurriSchedule
//
//  Created by Donne on 5/24/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCourseFromButtonViewController.h"

@class AddCourseFromButtonViewController;

@interface AddCourseFromButtonCell : UITableViewCell<UIActionSheetDelegate,UIAlertViewDelegate,MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseTeacherLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseCycelLabel;
- (IBAction)addButtonTap:(id)sender;

@property(nonatomic,strong)NSString *courseNo;

@property(weak)AddCourseFromButtonViewController *preViewController;

@end
