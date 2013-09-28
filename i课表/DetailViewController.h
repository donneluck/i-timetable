//
//  DetailViewController.h
//  CurriSchedule
//
//  Created by piner on 5/2/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleViewController.h"

@interface DetailViewController : UIViewController<UIActionSheetDelegate,MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}

-(IBAction)dismissView:(id)sender;
- (IBAction)deleteAction:(id)sender;

@property(nonatomic,strong)NSDictionary *oneCourse;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

#pragma mark -UILabel Item
@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UILabel *courseTeacher;
@property (weak, nonatomic) IBOutlet UILabel *coursePlace;
@property (weak, nonatomic) IBOutlet UILabel *courseTime;
//@property (weak, nonatomic) IBOutlet UILabel *courseWeek;
@property (weak, nonatomic) IBOutlet UILabel *courseCycle;
@property (weak, nonatomic) IBOutlet UILabel *isChooseOwn;
@property (weak, nonatomic) IBOutlet UILabel *courseDetail;

#pragma mark - previewcontroller

- (id)initWithDictionary:(NSDictionary*)dictionary;
@end
