//
//  OnesCourseViewController.h
//  CurriSchedule
//
//  Created by Donne on 5/27/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnesCourseCell.h"

@interface OnesCourseViewController : UITableViewController<MBProgressHUDDelegate>

@property(nonatomic,strong)NSArray *courseList;
@property(nonatomic,strong)NSString *friendNo;
@property(nonatomic,strong)NSString *friendPassword;
@property(nonatomic,strong)NSString *friendName;

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@end
