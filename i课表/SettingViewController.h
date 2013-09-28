//
//  SettingViewController.h
//  CurriSchedule
//
//  Created by piner on 4/30/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "RemindPickerViewController.h"

#import "LoginViewController.h"

@interface SettingViewController : UITableViewController<UIActionSheetDelegate>

- (IBAction)RevealMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;

@property (weak, nonatomic) IBOutlet UITableViewCell *userInformation;

@property (weak, nonatomic) IBOutlet UITableViewCell *userAccount;
@property (weak, nonatomic) IBOutlet UITableViewCell *changePassword;

@property (weak, nonatomic) IBOutlet UITableViewCell *courseRemind;
@property (weak, nonatomic) IBOutlet UITableViewCell *remindTime;

@property (weak, nonatomic) IBOutlet UITableViewCell *logoutUser;
@property (weak, nonatomic) IBOutlet UITableViewCell *about;

@property (weak, nonatomic) IBOutlet UISwitch *reminderSwitch;
- (IBAction)remindChange:(UISwitch*)sender;

@property(nonatomic,strong)NSDictionary *dataList;
@property(nonatomic,strong)NSArray *timeArray;
@end
