//
//  DetailViewController.m
//  CurriSchedule
//
//  Created by piner on 5/2/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


@synthesize oneCourse;
@synthesize navigationItem;
@synthesize navigationBar;

@synthesize courseName;
@synthesize courseTeacher;
@synthesize coursePlace;
@synthesize courseTime;
//@synthesize courseWeek;
@synthesize courseCycle;
@synthesize isChooseOwn;
@synthesize courseDetail;

-(IBAction)dismissView:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)deleteAction:(id)sender {
//    UIActionSheet *deleteAction=[[UIActionSheet alloc]initWithTitle:@"确认删除该课程" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确认" otherButtonTitles:nil, nil];
//    [deleteAction showInView:self.view];
    SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"确认删除此课程"];
    [alertView addButtonWithTitle:@"取消"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              
                          }];
    [alertView addButtonWithTitle:@"删除"
                             type:SIAlertViewButtonTypeDestructive
                          handler:^(SIAlertView *alertView) {
                              HUD = [[MBProgressHUD alloc] initWithView:self.view];
                              [self.view addSubview:HUD];
                              
                              // Regiser for HUD callbacks so we can remove it from the window at the right time
                              HUD.delegate = self;
                              HUD.labelText=@"删除中";
                              
                              [HUD show:YES];
                              if ([self.oneCourse isOwn]==1){
                                  NSString *username=[Data getUsername];
                                  NSString *path=[[NSString alloc]initWithFormat:@"%@/delete?username=%@&courseNo=%@",_BaseURLString,username,[self.oneCourse classNo]];
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
                                          [Data deleteByDictionary:self.oneCourse];
                                          [self.presentingViewController viewDidLoad];
                                          [self dismissViewControllerAnimated:YES completion:nil];
                                          
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
                                      SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"网络异常"];
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
                                  SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil
                                        andMessage:@"必修课程无法删除"];
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


- (id)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        self.oneCourse=[[NSDictionary alloc]initWithDictionary:dictionary copyItems:YES];
        NSLog(@"the selected course name is:%@",[self.oneCourse valueForKey:@"cname"]);
        self.navigationItem.title=[oneCourse valueForKey:@"cname"];
        
    }
    return self;
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
    self.toolBar.tintColor=[Data buttonColor];
    
    NSLog(@"self.onecourse:%@",[self.oneCourse description]);
    // Do any additional setup after loading the view from its nib.
    self.courseName.text=[self.oneCourse courseName];
    self.courseTeacher.text=[self.oneCourse teacherName];
    self.coursePlace.text=[self.oneCourse classRoom];

    self.courseTime.numberOfLines=0;
    self.courseTime.lineBreakMode=NSLineBreakByWordWrapping;
    for (NSDictionary *dict in [Data courseList]) {
        if ([[dict classNo]isEqualToString:[self.oneCourse classNo]]) {
            self.courseTime.text=[dict combinedClassInWeek];
        }
    }

    self.courseCycle.text=[self.oneCourse combinedClassWeek];
    NSString *string=[[NSString alloc]init];
    if ([self.oneCourse isOwn]==0) {
        string=@"必修";
    }
    else{
        string=@"自选";
    }
    self.isChooseOwn.text=string;
    
    if ([[self.oneCourse classDescription]isEqual:[NSNull null]]) {
        self.courseDetail.text=@"暂无";
    }
    else{
        self.courseDetail.text=[self.oneCourse classDescription];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
