//
//  MyCourseDetailViewController.m
//  CurriSchedule
//
//  Created by piner on 5/13/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "MyCourseDetailViewController.h"

@interface MyCourseDetailViewController ()

@end

@implementation MyCourseDetailViewController

@synthesize navItem;


@synthesize selectRow;
@synthesize courseName;
@synthesize courseTeacher;
@synthesize coursePlace;
@synthesize courseTime;
//@synthesize courseWeek;
@synthesize courseCycle;
@synthesize isChooseOwn;
@synthesize courseDetail;


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
    self.navItem.rightBarButtonItem.tintColor=[Data buttonColor];
    self.navItem.backBarButtonItem.tintColor=[Data buttonColor];
    
    self.navigationController.navigationBar.tintColor=[Data buttonColor];

	// Do any additional setup after loading the view.
    self.courseName.text=[self.course courseName];
    self.courseTeacher.text=[self.course teacherName];
    self.coursePlace.text=[self.course classRoom];
    
    self.courseTime.numberOfLines=0;
    self.courseTime.lineBreakMode=NSLineBreakByWordWrapping;
    self.courseTime.text=[self.course combinedClassInWeek];

    
    self.courseCycle.text=[self.course combinedClassWeek];

    NSString *string=[[NSString alloc]init];
    if ([self.course isOwn]==0) {
        string=@"必修";
    }
    else{
        string=@"自选";
    }
    self.isChooseOwn.text=string;
    
    if ([[self.course classDescription]isEqual:[NSNull null]]) {
        self.courseDetail.text=@"暂无";
    }
    else{
        self.courseDetail.text=[self.course classDescription];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deleteAction:(id)sender {
//    UIActionSheet *deleteAction=[[UIActionSheet alloc]initWithTitle:@"确认删除该课程" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确认" otherButtonTitles:nil, nil];
//    [deleteAction showInView:self.view];
    SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"确认删除此课程"];
    [alertView addButtonWithTitle:@"取消"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              
                          }];
    [alertView addButtonWithTitle:@"确定"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              HUD = [[MBProgressHUD alloc] initWithView:self.view];
                              [self.view addSubview:HUD];
                              
                              // Regiser for HUD callbacks so we can remove it from the window at the right time
                              HUD.delegate = self;
                              HUD.labelText=@"删除中";
                              
                              [HUD show:YES];
                              
                              // Show the HUD while the provided method executes in a new thread
                              if ([self.course isOwn]==1){
                                  NSString *username=[Data getUsername];
                                  NSString *path=[[NSString alloc]initWithFormat:@"%@/delete?username=%@&courseNo=%@",_BaseURLString,username,[self.course classNo]];
                                  [[NetworkClient sharedClient]getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                                          [Data deleteByDictionary:self.course];
                                          self.preViewController.courseList=[Data courseList];
                                          [self.preViewController.tableView reloadData];
                                          [self.navigationController popToRootViewControllerAnimated:YES];
                                          
                                      }
                                      else{
                                          [HUD hide:YES];
                                          
//                                          UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"删除失败" message:@"未能完成操作" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                                          [alertView show];
                                          SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"删除失败"];
                                          [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                                              
                                          }];
                                          alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
                                          [alertView show];
                                      }
                                      
                                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      [HUD hide:YES];
                                      
//                                      UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"删除失败" message:@"请检查您的网络连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                                      [alertView show];
                                      SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:@"删除失败" andMessage:@"网络异常"];
                                      [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                                          
                                      }];
                                      alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
                                      [alertView show];
                                      
                                  }];
                              }
                              else{
                                  [HUD hide:YES];
                                  
//                                  UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"删除失败" message:@"必修课程无法删除" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                                  [alertView show];
                                  SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"必修课程无法删除"];
                                  [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                                      
                                  }];
                                  alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
                                  [alertView show];
                              }
                          }];
    alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;
    alertView.backgroundStyle = SIAlertViewBackgroundStyleSolid;
    [alertView show];
}


@end
