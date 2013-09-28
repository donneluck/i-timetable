//
//  UserInformationViewController.h
//  CurriSchedule
//
//  Created by piner on 5/2/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInformationViewController : UITableViewController

- (IBAction)RevealMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;

@end
