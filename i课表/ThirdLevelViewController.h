//
//  ThirdLevelViewController.h
//  CurriSchedule
//
//  Created by piner on 5/15/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdLevelViewController : UIViewController<UIActionSheetDelegate>

@property(nonatomic,strong)NSDictionary *oneCourse;

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UILabel *courseRoom;
@property (weak, nonatomic) IBOutlet UILabel *courseTeacher;
@property (weak, nonatomic) IBOutlet UILabel *courseTime;
@property (weak, nonatomic) IBOutlet UILabel *courseCycle;
@property (weak, nonatomic) IBOutlet UILabel *courseProp;
@property (weak, nonatomic) IBOutlet UILabel *courseComment;

- (IBAction)AddButtonTap:(id)sender;
@end
