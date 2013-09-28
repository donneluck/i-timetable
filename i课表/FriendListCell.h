//
//  FriendListCell.h
//  CurriSchedule
//
//  Created by piner on 5/11/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendListViewController.h"

@class FriendListViewController;

@interface FriendListCell : UITableViewCell<UIActionSheetDelegate>{
    MBProgressHUD *HUD;
}

@property(nonatomic,strong)IBOutlet UILabel *friendName;
@property(nonatomic,strong)IBOutlet UILabel *friendSex;
@property (weak, nonatomic) IBOutlet UIImageView *friendImage;
@property (weak, nonatomic) IBOutlet UILabel *friendNo;

@property(nonatomic,strong)NSString *fno;

@property(nonatomic,strong)FriendListViewController *preViewController;

- (IBAction)deleteFollow:(id)sender;
@end
