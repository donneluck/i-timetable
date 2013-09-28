//
//  FriendListViewController.m
//  CurriSchedule
//
//  Created by piner on 5/9/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "FriendListViewController.h"

@interface FriendListViewController ()

@end

@implementation FriendListViewController

@synthesize friendList;

- (IBAction)RevealMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}



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
    self.navItem.rightBarButtonItem.tintColor=[Data buttonColor];

    //v0.3 fetch data in everytime
    NSString *username=[Data getUsername];
    NSString *path=[NSString stringWithFormat:@"%@/follow?username=%@",_BaseURLString,username];
    
    
#warning comment for test
//    [[NetworkClient sharedClient]getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *root;
//        if ([responseObject respondsToSelector:@selector(objectForKey:)]) {
//            root=(NSDictionary*)responseObject;
//        }
//        else{
//            root=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
//        }
//        [NSDictionary writeFriend:root];
//        self.friendList=[Data followsList];
//        NSLog(@"friendlist:%@",[self.friendList description]);
//        [self.tableView reloadData];
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"获取失败" message:@"请检查您的网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
////        [alertView show];
//        SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"获取失败"];
//        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
//            
//        }];
//        alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
//        [alertView show];
//    }];
}

-(void)viewWillAppear:(BOOL)animated{
    NSString *nextPath=[NSString stringWithFormat:@"%@/follow?username=%@",_BaseURLString,[Data getUsername]];
#warning comment for test
//    [[NetworkClient sharedClient]getPath:nextPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *root;
//        if ([responseObject respondsToSelector:@selector(objectForKey:)]) {
//            root=(NSDictionary*)responseObject;
//        }
//        else{
//            root=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
//        }
//        [NSDictionary writeFriend:root];
//        self.friendList=[Data followsList];
//        [self.tableView reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"添加失败" message:@"请检查您的网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
////        [alertView show];
//        SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"获取失败"];
//        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
//            
//        }];
//        alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
//        [alertView show];
//    }];
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
    return [self.friendList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FriendCell";
    FriendListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.friendName.text=[[self.friendList objectAtIndex:indexPath.row]friendName];
    cell.friendSex.text=[[self.friendList objectAtIndex:indexPath.row]friendSex];
    cell.friendNo.text=[[self.friendList objectAtIndex:indexPath.row]friendId];
    
    //image
    if ([[[self.friendList objectAtIndex:indexPath.row]friendSex]isEqualToString:@"男"]) {
        cell.friendImage.image=[UIImage imageNamed:@"male.png"];
    }
    else{
        cell.friendImage.image=[UIImage imageNamed:@"female.png"];
    }
    cell.preViewController=self;
    cell.fno=[[self.friendList objectAtIndex:indexPath.row]fno];
    
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

#pragma mark - segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"OnesCourse"]) {
//        FriendInfoViewController *infoViewController=(FriendInfoViewController*)segue.destinationViewController;
//        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
//        infoViewController.selectedFriend=[self.friendList objectAtIndex:indexPath.row];
        OnesCourseViewController *viewController=(OnesCourseViewController*)segue.destinationViewController;
        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        viewController.friendNo=[[self.friendList objectAtIndex:indexPath.row]friendId];
        viewController.friendPassword=[[self.friendList objectAtIndex:indexPath.row]friendPassword];
        viewController.friendName=[[self.friendList objectAtIndex:indexPath.row]friendName];
        NSLog(@"[self.friendList objectAtIndex:indexPath.row]:%@",[self.friendList objectAtIndex:indexPath.row]);
        NSLog(@"[self.friendList objectAtIndex:indexPath.row]:%@",[self.friendList objectAtIndex:indexPath.row]);
    }
}

//deprecate in v0.6

#pragma mark - actionsheet delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"确认删除该好友"];
        [alertView addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
            
        }];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            
            // Regiser for HUD callbacks so we can remove it from the window at the right time
            HUD.delegate = self;
            HUD.labelText=@"删除中";
            
            // Show the HUD while the provided method executes in a new thread
            [HUD show:YES];
            NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
            NSDictionary *follow=[self.friendList objectAtIndex:indexPath.row];
            NSString *followNo=[follow fno];
            NSString *path=[NSString stringWithFormat:@"%@/deletefollow?fno=%@",_BaseURLString,followNo];
            // delete operation
            [[NetworkClient sharedClient]getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //response delete status
                // and reload table view
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
                }
                else{
                    [HUD hide:YES];
                    //                UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"删除失败" message:@"请检查您的网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                    //                [alertView show];
                    SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"删除失败"];
                    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                        
                    }];
                    alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
                    [alertView show];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [HUD hide:YES];
                //            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"删除失败" message:@"请检查您的网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                //            [alertView show];
                SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"网络异常"];
                [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                    
                }];
                alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
                [alertView show];
            }];
        }];
    }
}


@end
