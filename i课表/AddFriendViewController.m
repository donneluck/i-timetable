//
//  AddFriendViewController.m
//  CurriSchedule
//
//  Created by Donne on 5/27/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "AddFriendViewController.h"

@interface AddFriendViewController ()

@end

@implementation AddFriendViewController

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
    self.navigationController.navigationBar.tintColor=[Data buttonColor];
    self.searchBar.tintColor=[Data buttonColor];
    self.navItem.backBarButtonItem.tintColor=[Data buttonColor];


	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"AddFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    
    
    
    return cell;
}

#pragma mark -search bar

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.labelText=@"添加中";
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(addOperation) onTarget:self withObject:nil animated:YES];

}

-(void)addOperation{
    NSString *friendNo=self.searchBar.text;
    NSLog(@"search text:%@",friendNo);
    NSString *path=[NSString stringWithFormat:@"%@/addfollow?username=%@&followname=%@",_BaseURLString,[Data getUsername],friendNo];
    [[NetworkClient sharedClient]getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //reload data
        NSDictionary *root;
        if ([responseObject respondsToSelector:@selector(objectForKey:)]) {
            root=(NSDictionary*)responseObject;
        }
        else{
            root=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        }        int status=[[root objectForKey:@"status"]intValue];
        NSLog(@"add friend status:%d",status);
        if(status==0){
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"添加失败" message:@"指定用户ID不存在或您已添加该好友" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
            SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"添加失败"];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                
            }];
            alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
            [alertView show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"添加失败" message:@"请检查您的网络设置" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
//        return ;
        SIAlertView *alertView=[[SIAlertView alloc]initWithTitle:nil andMessage:@"网络异常"];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
            
        }];
        alertView.transitionStyle=SIAlertViewTransitionStyleDropDown;
        [alertView show];
    }];
}



@end
