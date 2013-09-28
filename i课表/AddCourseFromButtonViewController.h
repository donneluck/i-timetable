//
//  AddCourseFromButtonViewController.h
//  CurriSchedule
//
//  Created by Donne on 5/23/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCourseFromButtonCell.h"
#import "ScheduleViewController.h"

@interface AddCourseFromButtonViewController : UITableViewController<UIAlertViewDelegate,MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}

@property(nonatomic,strong)NSDictionary *searchDetail;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
- (IBAction)backButtonTap:(id)sender;

@property(nonatomic,strong)NSMutableArray *receiveArray;
@property(nonatomic,strong)NSArray *praseArray;

@property(nonatomic)int totalPages;
@property(nonatomic)int totalRecords;
@property(nonatomic)int currentPage;

@end
