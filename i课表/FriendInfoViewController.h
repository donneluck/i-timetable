//
//  FriendInfoViewController.h
//  CurriSchedule
//
//  Created by piner on 5/9/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>

//!!!
//deprecate in v0.6

@interface FriendInfoViewController : UIViewController<UIActionSheetDelegate>

@property(nonatomic,strong)NSDictionary *selectedFriend;

@property (weak, nonatomic) IBOutlet UILabel *friendName;
@property (weak, nonatomic) IBOutlet UILabel *friendSex;
@property (weak, nonatomic) IBOutlet UILabel *friendMajor;
@property (weak, nonatomic) IBOutlet UILabel *friendId;
@property (weak, nonatomic) IBOutlet UILabel *friendDescription;

@property (weak, nonatomic) IBOutlet UINavigationItem *titleItem;

- (IBAction)deleteFriend:(id)sender;



@end
