//
//  RegisterViewController.h
//  CurriSchedule
//
//  Created by piner on 5/9/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

-(IBAction)textFiledReturnEditing:(id)sender;
-(IBAction)backgroundTap:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;

- (IBAction)CommitButtonTap:(id)sender;
- (IBAction)CancelButtonTap:(id)sender;



@end
