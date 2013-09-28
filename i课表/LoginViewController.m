//
//  LoginViewController.m
//  CurriSchedule
//
//  Created by piner on 4/30/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize usernameField;
@synthesize passwordField;

- (IBAction)LoginButtonTap:(id)sender {
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    
    if ([self.usernameField.text isEqualToString:@"testaccount"]&&[self.passwordField.text isEqualToString:@"testaccount"]) {
        WelcomeViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeView"];
//        viewController.username=[NSString stringWithFormat:@"%@同学",[[[root objectForKey:@"data"]objectAtIndex:0]objectForKey:@"sname"]];
        viewController.username=@"测试账户";
        [viewController viewDidLoad];
        viewController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:viewController animated:YES completion:nil];
        return;
    }
    
    if (self.usernameField.text.length==0&&self.passwordField.text.length==0) {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"用户名密码不能为空" message:@"请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
        SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"用户名密码不能为空"];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
            
        }];
        alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
        [alertView show];
    }
    else{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.labelText=@"登录中";
    
    // Show the HUD while the provided method executes in a new thread
//    [HUD showWhileExecuting:@selector(loginOperation) onTarget:self withObject:nil animated:YES];
    [HUD show:YES];
    NSString *path=[[NSString alloc]initWithFormat:@"%@/login?username=%@&password=%@",_BaseURLString,self.usernameField.text,self.passwordField.text];
        
        [Data saveUsername:self.usernameField.text];
        [Data savePassword:self.passwordField.text];

        [Data saveUsername:self.usernameField.text];
        [Data savePassword:self.passwordField.text];

    
    NSURL *url=[NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest: request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        NSData *data=[NSJSONSerialization dataWithJSONObject:JSON options:kNilOptions error:nil];
                                                        
                                                        NSDictionary *root=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                        NSLog(@"root :%@",[root description]);
 
                                                        int user=[[root objectForKey:@"role"]intValue];
                                                        if (user==0) {
                                                            [HUD hide:YES];
//                                                            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"用户名密码错误" message:@"请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                                                            [alertView show];
                                                            SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"用户名密码错误"];
                                                            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                                                                
                                                            }];
                                                            alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
                                                            [alertView show];
                                                        }
                                                        else if(user==1){
                                                            [HUD hide:YES];
                                                            [Data replaceData:data];
                                                            [Data saveRemindTime:15];//default
                                                            
                                                            [Data notificationList:15];
                                                            [Data saveFullname:[[[root objectForKey:@"data"]objectAtIndex:0]objectForKey:@"sname"]];
                                                            
                                                            WelcomeViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeView"];
                                                            viewController.username=[NSString stringWithFormat:@"%@同学",[[[root objectForKey:@"data"]objectAtIndex:0]objectForKey:@"sname"]];
                                                            [viewController viewDidLoad];
                                                            viewController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
                                                            [self presentViewController:viewController animated:YES completion:nil];
                                                        }
                                                        else if(user==2){
                                                            [HUD hide:YES];
                                                            [Data replaceData:data];
                                                            
                                                            [Data saveRemindTime:15];
                                                            [Data notificationList:15];
                                                            
                                                            [Data saveFullname:[[[root objectForKey:@"data"]objectAtIndex:0]objectForKey:@"sname"]];
                                                            
                                                            WelcomeViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeView"];
                                                            viewController.username=[NSString stringWithFormat:@"%@老师",[[[root objectForKey:@"data"]objectAtIndex:0]objectForKey:@"tname"]];
                                                            [viewController viewDidLoad];
                                                            [self presentViewController:viewController animated:YES completion:nil];
                                                        }
                                                        
                                                        
                                                    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        [HUD hide:YES];
                                                        NSLog(@"%@",error);
                                                        SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"网络异常"];
                                                        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                                                            
                                                        }];
                                                        alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
                                                        [alertView show];
                                                    }];
    
        [operation start];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    if ([Data getUsername]!=nil&&[Data getPassword]!=nil) {
        NSLog(@"already exits a user");
        InitialViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"Initial"];
        [self presentViewController:viewController animated:NO completion:nil];
    }
}



//deprecate in v0.6
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
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
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
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationItem.rightBarButtonItem.tintColor=[Data buttonColor];
    self.navigationController.navigationItem.leftBarButtonItem.tintColor=[Data buttonColor];
    self.navigationController.navigationItem.backBarButtonItem.tintColor=[Data buttonColor];
    self.navItem.rightBarButtonItem.tintColor=[Data buttonColor];
    self.navItem.title=@"登录";
    self.view.backgroundColor=[Data backgroundColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}


#define Move_Height 80
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + Move_Height - (self.view.frame.size.height - 206.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}

@end
