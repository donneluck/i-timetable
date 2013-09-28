//
//  AddCourseFromButtonCell.m
//  CurriSchedule
//
//  Created by Donne on 5/24/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "AddCourseFromButtonCell.h"

@implementation AddCourseFromButtonCell

@synthesize courseNo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addButtonTap:(id)sender {
//    NSString *detail=[NSString stringWithFormat:@"%@,%@",self.courseNameLabel.text,self.courseTeacherLabel.text];
//    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"确认添加课程" message:detail delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alertView show];
    SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"确认添加此课程"];
    [alertView addButtonWithTitle:@"取消"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              
                          }];
    [alertView addButtonWithTitle:@"添加"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              HUD = [[MBProgressHUD alloc] initWithView:self.preViewController.navigationController.view];
                              [self.preViewController.navigationController.view addSubview:HUD];
                              
                              // Regiser for HUD callbacks so we can remove it from the window at the right time
                              HUD.delegate = self.preViewController;
                              HUD.labelText=@"添加中";
                              
                              // Show the HUD while the provided method executes in a new thread
                              //
                              [HUD show:YES];
                              NSString *username=[Data getUsername];
                              NSString *path=[[NSString alloc]initWithFormat:@"%@/add?username=%@&courseNo=%@",_BaseURLString,username,self.courseNo];
                              
                              [[NetworkClient sharedClient]getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  NSDictionary *root;
                                  if ([responseObject respondsToSelector:@selector(objectForKey:)]) {
                                      root=(NSDictionary*)responseObject;
                                  }
                                  else{
                                      root=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                                  }                                  int status=[[root objectForKey:@"status"]intValue];
                                  NSLog(@"response:%d",status);
                                  
                                  if (status==1){
                                      [HUD hide:YES];
                                      [Data refetchData];
                                      NSLog(@"success");
                                  }
                                  if (status==0) {
                                      [HUD hide:YES];
//                                      UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"添加失败" message:@"操作无法完成" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//                                      [alertView show];
                                      SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"添加失败"];
                                      [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                                          
                                      }];
                                      alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
                                      [alertView show];
                                  }
                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  [HUD hide:YES];
//                                  UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"添加失败" message:@"请检查您的网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//                                  [alertView show];
                                  SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"网络异常"];
                                  [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                                      
                                  }];
                                  alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
                                  [alertView show];
                              }];
                          }];
    alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;
    alertView.backgroundStyle = SIAlertViewBackgroundStyleSolid;
    [alertView show];
}

@end
