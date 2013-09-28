//
//  AddCourseFromButtonViewController.m
//  CurriSchedule
//
//  Created by Donne on 5/23/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "AddCourseFromButtonViewController.h"

@interface AddCourseFromButtonViewController (){

}

@end

#define _PageRecords 10

@implementation AddCourseFromButtonViewController

@synthesize searchDetail;
@synthesize receiveArray;
@synthesize praseArray;
@synthesize totalPages,totalRecords,currentPage;


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
    self.navItem.rightBarButtonItem.tintColor=[Data buttonColor];
    self.navItem.leftBarButtonItem.tintColor=[Data buttonColor];
    self.navItem.backBarButtonItem.tintColor=[Data buttonColor];
    self.navigationController.navigationBar.tintColor=[Data buttonColor];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.praseArray=[[NSArray alloc]initWithObjects:@"1-2",@"3-4",@"5-6",@"7-8",@"9-10",@"11-12", nil];
    
    NSString *serial=[self.praseArray objectAtIndex:[[self.searchDetail objectForKey:@"coursetime"]intValue]];

    self.navItem.title=[NSString stringWithFormat:@"周%d 第%@节",[[self.searchDetail objectForKey:@"weekday"]intValue]+1,serial];
    
    self.receiveArray=[[NSMutableArray alloc]init];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.labelText=@"加载中";
    
    // Show the HUD while the provided method executes in a new thread
    //
    [HUD show:YES];
    [self fetchData];
}

-(void)fetchData{
    int index=[[self.searchDetail objectForKey:@"coursetime"]intValue];
    NSString *path=[[NSString alloc]initWithFormat:@"%@/search?&week=%d&weekday=%d&class=%@&page=%d",_BaseURLString,[Data nowWeekOfTerm],[[self.searchDetail objectForKey:@"weekday"]intValue]+1,[self.praseArray objectAtIndex:index],self.currentPage];
    [[NetworkClient sharedClient]getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *root;
        if ([responseObject respondsToSelector:@selector(objectForKey:)]) {
            root=(NSDictionary*)responseObject;
        }
        else{
            root=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        }
        NSArray *searchList=[root objectForKey:@"list"];
        
        NSDictionary *info=[root objectForKey:@"pageInfo"];
        self.currentPage=[[info objectForKey:@"currentPage"]intValue];
        self.totalRecords=[[info objectForKey:@"total"]intValue];
        self.totalPages=[[info objectForKey:@"pages"]intValue];
        
        for (NSDictionary *dict in searchList) {
            [self.receiveArray addObject:dict];
        }
        [HUD hide:YES];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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
    if ([self.receiveArray count]==0) {
        return 1;
    }
    else if([self.receiveArray count]<self.totalRecords){
        return [self.receiveArray count]+1;
    }
    return [self.receiveArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.receiveArray count]==0) {
        return 504;
    }
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.receiveArray count]==0) {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.userInteractionEnabled=NO;
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        UIImage *image=[UIImage imageNamed:@"nocourse.png"];
        cell.imageView.image=image;
        return cell;
    }
    else if(indexPath.row==[self.receiveArray count]){
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.userInteractionEnabled=NO;
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.text=@"正在加载更多课程";
        return cell;
    }
    
    static NSString *CellIdentifier = @"AddCourseFromButtonCell";
    AddCourseFromButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    

    cell.preViewController=self;
    NSDictionary *dict=[self.receiveArray objectAtIndex:indexPath.row];
    cell.courseNameLabel.text=[dict courseName];
    cell.courseTeacherLabel.text=[dict teacherName];
    cell.courseCycelLabel.text=[dict combinedClassWeek];
    cell.courseNo=[dict classNo];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==[self.receiveArray count]) {
        self.currentPage+=1;
        [self fetchData];
    }
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

- (IBAction)backButtonTap:(id)sender {
    [self.presentingViewController viewWillAppear:YES];
    [self.presentedViewController viewWillAppear:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}


@end
