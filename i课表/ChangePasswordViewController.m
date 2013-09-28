//
//  ChangePasswordViewController.m
//  CurriSchedule
//
//  Created by piner on 5/2/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

@synthesize oldPassword;
@synthesize theNewPassword;
@synthesize confirmPassword;

-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
}

-(IBAction)backgroundTap:(id)sender{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [self.oldPassword resignFirstResponder];
    [self.theNewPassword resignFirstResponder];
    [self.confirmPassword resignFirstResponder];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationItem.rightBarButtonItem.tintColor=[Data buttonColor];
    self.navigationController.navigationItem.leftBarButtonItem.tintColor=[Data buttonColor];
    self.navigationController.navigationItem.backBarButtonItem.tintColor=[Data buttonColor];
    self.navigationController.navigationBar.tintColor=[Data buttonColor];


	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)commitButtonTap:(id)sender {
    [self.confirmPassword resignFirstResponder];
    
    if ([self.theNewPassword.text isEqualToString:self.confirmPassword.text]) {
        if ([self.oldPassword.text isEqualToString:[Data getPassword]]) {
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            
            // Regiser for HUD callbacks so we can remove it from the window at the right time
            HUD.delegate = self;
            HUD.labelText=@"修改中";
            
            // Show the HUD while the provided method executes in a new thread
            [HUD show:YES];
            NSString *path=[NSString stringWithFormat:@"%@/changepsw?username=%@&password=%@&newpassword=%@",_BaseURLString,[Data getUsername],[Data getPassword],self.confirmPassword.text];
            [[NetworkClient sharedClient]getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //突然不能用了！！！！！
                //原因不明
                //            NSDictionary *root=(NSDictionary*)responseObject;
                //暂时解决
                NSDictionary *root;
                if ([responseObject respondsToSelector:@selector(objectForKey:)]) {
                    root=(NSDictionary*)responseObject;
                }
                else{
                    root=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                }
                int status=[[root objectForKey:@"status"]intValue];
                if (status==1) {
                    [HUD hide:YES];
                    NSLog(@"change success");
                    [Data savePassword:self.confirmPassword.text];
                    SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"修改成功，请牢记新密码"];
                    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                        
                    }];
                    alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
                    [alertView show];
                }
                else{
                    [HUD hide:YES];
                    
                    SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"修改失败"];
                    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                        
                    }];
                    alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
                    [alertView show];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [HUD hide:YES];
                
                SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"网络异常"];
                [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                    
                }];
                alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
                [alertView show];
            }];
        }
        else{
            SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"当前密码不正确"];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                
            }];
            alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
            [alertView show];
        }
    }
    else{
//        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"更改失败" message:@"两次输入新密码不相同，请修正" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
        SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"两次输入新密码不相同，请更正"];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
            
        }];
        alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
        [alertView show];
    }
}


@end
