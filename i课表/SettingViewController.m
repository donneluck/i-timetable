//
//  SettingViewController.m
//  CurriSchedule
//
//  Created by piner on 4/30/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()



@end

@implementation SettingViewController

@synthesize dataList;
@synthesize timeArray;

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
    self.menuButton.image=[Data menuButton];
    
    if (self.reminderSwitch.isOn==YES) {
        self.remindTime.userInteractionEnabled=YES;
        self.remindTime.detailTextLabel.text=[NSString stringWithFormat:@"提前%d分钟",[Data getRemindTime]];
    }else{
        self.remindTime.userInteractionEnabled=NO;
        self.remindTime.detailTextLabel.text=@"无提醒";
    }
    
    self.changePassword.selectionStyle=UITableViewCellSelectionStyleNone;
    self.courseRemind.selectionStyle=UITableViewCellSelectionStyleNone;
    self.remindTime.selectionStyle=UITableViewCellSelectionStyleNone;
    self.logoutUser.selectionStyle=UITableViewCellSelectionStyleNone;
    self.about.selectionStyle=UITableViewCellSelectionStyleNone;

    self.dataList=[[NSDictionary alloc]initWithObjectsAndKeys:@"5分钟之前",@"5",@"10分钟之前",@"10",@"15分钟之前",@"15",@"30分钟之前",@"30", nil];
    self.timeArray=[[NSArray alloc]initWithObjects:@"5",@"10",@"15",@"30", nil];

}

-(void)viewWillAppear:(BOOL)animated{
    [self viewDidLoad];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 3;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    if (section==0) {
//        return 3;
//    }
//    else if (section==1){
//        return 2;
//    }
//    else{
//        return 1;
//    }
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"SettingCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    if (indexPath.section==0&&indexPath.row==0) {
//    }
//    
//    return cell;
//}

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
    if (indexPath.section==2&&indexPath.row==0) {
        SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:@"是否确认退出" andMessage:@"退出将清除您所有本地数据"];
        [alertView addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
            
        }];
        [alertView addButtonWithTitle:@"确认" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
            LoginViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"Start"];
            viewController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
            if ([Data deleteData]) {
                NSLog(@"local data remove success");
            }
            [self presentViewController:viewController animated:YES completion:nil];
        }];
        alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
        [alertView show];
    }
    
    if (indexPath.section==1&&indexPath.row==1) {
    }
    
    /*

     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)RevealMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];

}
- (IBAction)remindChange:(UISwitch*)sender {
    if (!sender.on) {
        [[UIApplication sharedApplication]cancelAllLocalNotifications];
        self.remindTime.detailTextLabel.text=@"无提醒";
    }else{
        [Data notificationList:[Data getRemindTime]];
        self.remindTime.detailTextLabel.text=[NSString stringWithFormat:@"提前%d分钟",[Data getRemindTime]];

    }
    [self viewDidLoad];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"PickerReminder"]) {
        RemindPickerViewController *viewController=(RemindPickerViewController*)segue.destinationViewController;
        viewController.preViewController=self;
    }
}

@end
