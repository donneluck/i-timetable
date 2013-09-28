//
//  FriendListCell.m
//  CurriSchedule
//
//  Created by piner on 5/11/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "FriendListCell.h"

@implementation FriendListCell
@synthesize friendName;
@synthesize friendSex;
@synthesize friendImage;
@synthesize friendNo;

@synthesize fno;

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

- (IBAction)deleteFollow:(id)sender {
    SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"确认删除该好友"];
    [alertView addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
        
    }];
    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
        HUD = [[MBProgressHUD alloc] initWithView:self.preViewController.view];
        [self.preViewController.view addSubview:HUD];
        
        // Regiser for HUD callbacks so we can remove it from the window at the right time
        HUD.delegate = self.preViewController;
        HUD.labelText=@"删除中";
        
        // Show the HUD while the provided method executes in a new thread
        [HUD show:YES];
        NSString *path=[NSString stringWithFormat:@"%@/deletefollow?fno=%@",_BaseURLString,self.fno];
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
            NSLog(@"delete friend sttus:%d",status);
            if (status==1) {
                //success
                NSString *nextPath=[NSString stringWithFormat:@"%@/follow?username=%@",_BaseURLString,[Data getUsername]];
                [[NetworkClient sharedClient]getPath:nextPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSDictionary *root;
                    if ([responseObject respondsToSelector:@selector(objectForKey:)]) {
                        root=(NSDictionary*)responseObject;
                    }
                    else{
                        root=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                    }
                    [HUD hide:YES];
                    //                NSLog(@"friend root%@",[root description]);
                    [NSDictionary writeFriend:root];
                    self.preViewController.friendList=[Data followsList];
                    [self.preViewController.tableView reloadData];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"更新失败"];
                    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                        
                    }];
                    alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
                    [alertView show];
                }];
                
            }
            else{
                //            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"删除失败" message:@"服务器异常" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                //            [alertView show];
                SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"删除失败"];
                [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                    
                }];
                alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
                [alertView show];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"删除失败" message:@"请检查您的网络设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            //        [alertView show];
            //        return ;
            SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"网络异常"];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                
            }];
            alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
            [alertView show];
        }];

    }];
    alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
    [alertView show];

}



@end
