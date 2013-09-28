//
//  FriendListViewController.h
//  CurriSchedule
//
//  Created by piner on 5/9/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "FriendListCell.h"
#import "FriendInfoViewController.h"
#import "OnesCourseViewController.h"

@interface FriendListViewController : UITableViewController<UIActionSheetDelegate,MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}

- (IBAction)RevealMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property(nonatomic,strong)NSArray *friendList;

@end
