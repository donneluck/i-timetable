//
//  OnesCourseCell.m
//  CurriSchedule
//
//  Created by Donne on 5/27/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "OnesCourseCell.h"

@implementation OnesCourseCell

@synthesize courseName;
@synthesize courseOwn;
@synthesize courseRoom;
@synthesize courseTeacher;
@synthesize courseTime;

@synthesize classNo;

@synthesize preViewController;

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

- (IBAction)addCourse:(id)sender {
    NSArray *myCourseList=[Data courseList];
    for (NSDictionary *dict in myCourseList) {
        if ([self.classNo isEqualToString:[dict classNo]]) {
//            UIAlertView *repeatAlert=[[UIAlertView alloc]initWithTitle:@"课程重复" message:@"您已有这门课程，不可重复添加" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [repeatAlert show];
//            return;
            SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"您已有这门课程"];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                
            }];
            alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
            [alertView show];
        }
    }
    HUD = [[MBProgressHUD alloc] initWithView:self.preViewController.view];
    [self.preViewController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self.preViewController;
    HUD.labelText=@"添加中";
    
    // Show the HUD while the provided method executes in a new thread
    [HUD show:YES];
    NSString *path=[NSString stringWithFormat:@"%@/add?courseNo=%@&username=%@",_BaseURLString,self.classNo,[Data getUsername]];
    
    [[NetworkClient sharedClient]getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // add course
        NSDictionary *root;
        if ([responseObject respondsToSelector:@selector(objectForKey:)]) {
            root=(NSDictionary*)responseObject;
        }
        else{
            root=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        }        int status=[[root objectForKey:@"status"]intValue];
        NSLog(@"add friend course status:%d",status);
        if (status==1){
            [HUD hide:YES];
            [Data refetchData];
            //这里逻辑有问题
            //            self.addButton.enabled=NO;
        }
        else{
            [HUD hide:YES];
//            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"添加失败" message:@"服务器未允许" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//            [alertView show];
//            return ;
            SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"添加失败"];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                
            }];
            alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
            [alertView show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [HUD hide:YES];
//        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"添加失败" message:@"请检查您的网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//        [alertView show];
        SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"网络异常"];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
            
        }];
        alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
        [alertView show];
    }];
}


@end
