//
//  FriendInfoViewController.m
//  CurriSchedule
//
//  Created by piner on 5/9/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "FriendInfoViewController.h"

//!!!
//deprecate in v0.6

@interface FriendInfoViewController ()

@end

@implementation FriendInfoViewController

@synthesize friendSex;
@synthesize friendMajor;
@synthesize friendName;
@synthesize friendDescription;
@synthesize friendId;
@synthesize selectedFriend;
@synthesize titleItem;

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
	// Do any additional setup after loading the view.
    self.titleItem.title=[self.selectedFriend friendName];
    self.friendSex.text=[self.selectedFriend friendSex];
//    self.friendMajor.text=[self.selectedFriend friendMajor];
    self.friendName.text=[self.selectedFriend friendName];
    self.friendId.text=[self.selectedFriend friendId];
    self.friendDescription.text=[self.selectedFriend friendDescription];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)deleteFriend:(id)sender {
    UIActionSheet *deleteAction=[[UIActionSheet alloc]initWithTitle:@"您将删除该好友" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定",nil];
    [deleteAction showFromBarButtonItem:sender animated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//send message
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}
@end
