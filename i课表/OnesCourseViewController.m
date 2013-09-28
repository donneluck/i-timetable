//
//  OnesCourseViewController.m
//  CurriSchedule
//
//  Created by Donne on 5/27/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "OnesCourseViewController.h"

@interface OnesCourseViewController ()

@end

@implementation OnesCourseViewController
@synthesize friendNo,friendPassword,friendName;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    
    self.navItem.backBarButtonItem.tintColor=[Data buttonColor];
    self.navigationController.navigationBar.tintColor=[Data buttonColor];

    
    self.navItem.title=[NSString stringWithFormat:@"%@的课程",self.friendName];
    
    


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSString *path=[NSString stringWithFormat:@"%@/login?username=%@&password=%@",_BaseURLString,self.friendNo,self.friendPassword];
    NSLog(@"path:%@",path);
    [[NetworkClient sharedClient]getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *root;
        if ([responseObject respondsToSelector:@selector(objectForKey:)]) {
            root=(NSDictionary*)responseObject;
        }
        else{
            root=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        }//        NSLog(@"friend course list root:%@",[root description]);
        int status=[[root objectForKey:@"status"]intValue];
        if (status==1) {
            self.courseList=[Data convertFriendData:root];
            NSLog(@"ones courselist:%@",[self.courseList description]);
            [self.tableView reloadData];
        }
        else{
//            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"获取失败" message:@"该好友在短时间内信息有变动，请刷新后重试" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//            [alertView show];
            SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"获取失败"];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                
            }];
            alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
            [alertView show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"获取失败" message:@"请检查您的网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//        [alertView show];
        SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"网络异常"];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
            
        }];
        alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
        [alertView show];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.courseList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OnesCourseCell";
    OnesCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *oneCourse=[self.courseList objectAtIndex:indexPath.row];
    cell.courseName.text=[oneCourse courseName];
    cell.courseTeacher.text=[oneCourse teacherName];
    cell.courseRoom.text=[oneCourse classRoom];
    cell.courseTime.text=[oneCourse combinedClassInWeek];
    
    cell.classNo=[oneCourse classNo];
    
    if ([oneCourse isOwn]==0) {
        cell.courseOwn.text=@"必修";
    }else{
        cell.courseOwn.text=@"自选";
    }
    
    cell.preViewController=self;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
