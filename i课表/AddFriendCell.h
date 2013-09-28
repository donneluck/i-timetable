//
//  AddFriendCell.h
//  CurriSchedule
//
//  Created by Donne on 5/27/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddFriendViewController.h"

@class AddFriendViewController;

@interface AddFriendCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *friendImage;
@property (weak, nonatomic) IBOutlet UILabel *friendName;
@property (weak, nonatomic) IBOutlet UILabel *friendSex;


@property(nonatomic,strong)AddFriendViewController *preViewController;

- (IBAction)addFollow:(id)sender;
@end
