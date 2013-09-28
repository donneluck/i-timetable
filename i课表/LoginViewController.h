//
//  LoginViewController.h
//  CurriSchedule
//
//  Created by piner on 4/30/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InitialViewController.h"
#import "WelcomeViewController.h"
#import "MBProgressHUD.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}

-(IBAction)textFiledReturnEditing:(id)sender;
-(IBAction)backgroundTap:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)LoginButtonTap:(id)sender;

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@end
