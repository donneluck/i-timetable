//
//  ChangePasswordViewController.h
//  CurriSchedule
//
//  Created by piner on 5/2/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController<MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}

- (IBAction)textFiledReturnEditing:(id)sender;
-(IBAction)backgroundTap:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UITextField *theNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;

- (IBAction)commitButtonTap:(id)sender;

@end
