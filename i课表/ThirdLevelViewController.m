//
//  ThirdLevelViewController.m
//  CurriSchedule
//
//  Created by piner on 5/15/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "ThirdLevelViewController.h"

@interface ThirdLevelViewController ()

@end

@implementation ThirdLevelViewController

@synthesize courseName;
@synthesize courseComment;
@synthesize courseCycle;
@synthesize courseProp;
@synthesize courseRoom;
@synthesize courseTeacher;
@synthesize courseTime;
@synthesize oneCourse;
@synthesize navItem;

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
    self.navItem.title=[self.oneCourse objectForKey:@"cname"];
    self.courseName.text=[self.oneCourse objectForKey:@"cname"];
    self.courseTeacher.text=[self.oneCourse objectForKey:@"tname"];
    self.courseRoom.text=[self.oneCourse objectForKey:@"tcdroom"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AddButtonTap:(id)sender {
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"本课程将出现在您的课程表" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定添加", nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        //add course here:
        [Data addToPlist:self.oneCourse];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
