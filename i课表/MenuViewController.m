//
//  MenuViewController.m
//  CurriSchedule
//
//  Created by piner on 4/29/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()
@property (nonatomic,strong) NSArray *menuItems;
@property (nonatomic,strong) NSArray *identifier;
@end

@implementation MenuViewController
@synthesize menuItems;


-(void)awakeFromNib{
    self.menuItems = [NSArray arrayWithObjects:@"我的课表",@"添加课程",@"课程管理", @"关注", @"消息中心",@"个人资料", @"设置", nil];
    self.identifier=[NSArray arrayWithObjects:@"WeekSchedule",@"AddCourse",@"CourseManager",@"MyFriend",@"MessagesCenter",@"UserInfo",@"Setting", nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.slidingViewController setAnchorRightRevealAmount:280.0f];
    self.slidingViewController.underLeftWidthLayout=ECFullWidth;
    self.tableView.backgroundColor = [UIColor colorWithRed:(50.0f/255.0f) green:(57.0f/255.0f) blue:(74.0f/255.0f) alpha:1.0f];
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;//2
            break;
        case 2:
            return 1;//2
            break;
        case 3:
            return 2;//2
            break;
        default:
            break;
    }
    return [self.menuItems count];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"i课表";
        case 1:
            return @"";
        default:
            return @"";
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    if (section==0) {
//        headerView.backgroundColor=[UIColor redColor];
        //set color and image in here:
    }
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row==0) {
                cell.textLabel.text=[self.menuItems objectAtIndex:0];
            }
            break;
        case 1:
            if (indexPath.row==0) {
                cell.textLabel.text=[self.menuItems objectAtIndex:2];
            }
            break;
        case 2:
            if (indexPath.row==0) {
                cell.textLabel.text=[self.menuItems objectAtIndex:3];
            }
            break;
        case 3:
            if (indexPath.row==0) {
                cell.textLabel.text=[self.menuItems objectAtIndex:5];
            }
            if (indexPath.row==1) {
                cell.textLabel.text=[self.menuItems objectAtIndex:6];
            }
            break;
        default:
            break;
    }
    
    //v0.1 color style following:
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor colorWithRed:(38.0f/255.0f) green:(44.0f/255.0f) blue:(58.0f/255.0f) alpha:1.0f];
    cell.selectedBackgroundView = bgView;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:([UIFont systemFontSize] * 1.2f)];
    cell.textLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    cell.textLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.25f];
    cell.textLabel.textColor = [UIColor colorWithRed:(196.0f/255.0f) green:(204.0f/255.0f) blue:(218.0f/255.0f) alpha:1.0f];
    
//    cell.textLabel.text = [self.menuItems objectAtIndex:indexPath.row];
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.height, 1.0f)];
    topLine.backgroundColor = [UIColor colorWithRed:(54.0f/255.0f) green:(61.0f/255.0f) blue:(76.0f/255.0f) alpha:1.0f];
    [cell.textLabel.superview addSubview:topLine];
    
    UIView *topLine2 = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 1.0f, [UIScreen mainScreen].bounds.size.height, 1.0f)];
    topLine2.backgroundColor = [UIColor colorWithRed:(54.0f/255.0f) green:(61.0f/255.0f) blue:(77.0f/255.0f) alpha:1.0f];
    [cell.textLabel.superview addSubview:topLine2];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 43.0f, [UIScreen mainScreen].bounds.size.height, 1.0f)];
    bottomLine.backgroundColor = [UIColor colorWithRed:(40.0f/255.0f) green:(47.0f/255.0f) blue:(61.0f/255.0f) alpha:1.0f];
    [cell.textLabel.superview addSubview:bottomLine];
    
    
    return cell;
}

- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition {
	[self.tableView selectRowAtIndexPath:indexPath animated:animated scrollPosition:scrollPosition];
	if (scrollPosition == UITableViewScrollPositionNone) {
		[self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
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
    
//    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:[self.identifier objectAtIndex:indexPath.row]];
    
    UIViewController *newTopViewController;
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row==0) {
                newTopViewController=[self.storyboard instantiateViewControllerWithIdentifier:[self.identifier objectAtIndex:0]];
            }
            break;
        case 1:
//            if (indexPath.row==0) {
//                newTopViewController=[self.storyboard instantiateViewControllerWithIdentifier:[self.identifier objectAtIndex:1]];
//            }
            if (indexPath.row==0) {
                newTopViewController=[self.storyboard instantiateViewControllerWithIdentifier:[self.identifier objectAtIndex:2]];
            }
            break;
        case 2:
            if (indexPath.row==0) {
                newTopViewController=[self.storyboard instantiateViewControllerWithIdentifier:[self.identifier objectAtIndex:3]];
            }
//            if (indexPath.row==1) {
//                newTopViewController=[self.storyboard instantiateViewControllerWithIdentifier:[self.identifier objectAtIndex:4]];
//            }
            break;
        case 3:
            if (indexPath.row==0) {
                newTopViewController=[self.storyboard instantiateViewControllerWithIdentifier:[self.identifier objectAtIndex:5]];
            }
            if (indexPath.row==1) {
                newTopViewController=[self.storyboard instantiateViewControllerWithIdentifier:[self.identifier objectAtIndex:6]];
            }
            break;
        default:
            break;
    }
    
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];

}

@end
