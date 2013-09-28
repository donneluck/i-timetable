//
//  TodayCourseViewController.m
//  CurriSchedule
//
//  Created by piner on 5/1/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "TodayCourseViewController.h"

@interface TodayCourseViewController ()
@property (nonatomic, assign) CGFloat peekLeftAmount;

@end

@implementation TodayCourseViewController
@synthesize peekLeftAmount;
@synthesize todayList,imageList;

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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.peekLeftAmount = 40.0f;
    [self.slidingViewController setAnchorLeftPeekAmount:self.peekLeftAmount];
    self.slidingViewController.underRightWidthLayout = ECVariableRevealWidth;
    
    self.todayList=[Data todayList];
    
    
    //gray background , if needed
    UIImage *image1=[UIImage imageNamed:@"course1.png"];

    UIImage *image2=[UIImage imageNamed:@"course2.png"];

    UIImage *image3=[UIImage imageNamed:@"course3.png"];

    UIImage *image4=[UIImage imageNamed:@"course4.png"];
    UIImage *image5=[UIImage imageNamed:@"course5.png"];
    UIImage *image6=[UIImage imageNamed:@"course6.png"];
    self.imageList=[[NSArray alloc]initWithObjects:image1,image2,image3,image4,image5,image6,nil];
}

-(void)viewWillAppear:(BOOL)animated{
    self.todayList=[Data todayList];
    [self.tableView reloadData];
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
    if ([self.todayList count]==0) {
        return 1;
    }
    return [self.todayList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.todayList count]==0) {
        return 548;
    }
    return 78;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.todayList count]==0) {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.userInteractionEnabled=NO;
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        UIImage *image=[UIImage imageNamed:@"notodaycourse.png"];
        cell.imageView.image=image;
        return cell;
    }
    
    static NSString *CellIdentifier = @"CourseCell";
    CourseCell *cell = (CourseCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSLog(@"todaylist count:%d",[self.todayList count]);
    
    // Configure the cell...
    /*
    cell.courseName=[[self.courseList objectAtIndex:indexPath.row]objectAtIndex:indexPath.row];
    cell.classroom=[[self.courseList objectAtIndex:indexPath.row]objectAtIndex:indexPath.row];
    cell.courseTeacher=[[self.courseList objectAtIndex:indexPath.row]objectAtIndex:indexPath.row];
     */
    
    if (self.todayList==nil) {
        cell.courseName.text=@"您今天没有任何课程";
        cell.courseTeacher.text=@"可以安心地玩啦";
        
        return cell;
    }
    cell.courseName.text=[[self.todayList objectAtIndex:indexPath.row]courseName];
    cell.courseTeacher.text=[[self.todayList objectAtIndex:indexPath.row]teacherName];
    cell.classroom.text=[[self.todayList objectAtIndex:indexPath.row]classRoom];
    cell.courseTime.text=[[self.todayList objectAtIndex:indexPath.row]classTime];
    cell.userInteractionEnabled=NO;
    
    for (int i=0; i<[self.imageList count]; i++) {
        if ([[self.todayList objectAtIndex:indexPath.row]classSerial]==i+1) {
            cell.imageView.image=[self.imageList objectAtIndex:i];
        }
    }
    
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
