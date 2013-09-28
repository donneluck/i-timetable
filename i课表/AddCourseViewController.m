//
//  AddCourseViewController.m
//  CurriSchedule
//
//  Created by piner on 5/9/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "AddCourseViewController.h"

@interface AddCourseViewController ()

@end

@implementation AddCourseViewController
@synthesize courseList;
@synthesize filteredList;
@synthesize savedScopeButtonIndex,savedSearchTerm,searchWasActive;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)RevealMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

//comment in version 0.6
/*
- (IBAction)segmentControl:(id)sender {
    UISegmentedControl *segment=(UISegmentedControl*)sender;
    if (segment.selectedSegmentIndex==0) {
        self.courseList=[Data courseTable];
        [self.tableView reloadData];
    }else if (segment.selectedSegmentIndex==1){
        self.courseList=[Data teacherTable];
        [self.tableView reloadData];
    }else if (segment.selectedSegmentIndex==2){
        
    }
}
 */


- (void)viewDidLoad
{
    [super viewDidLoad];

    //comment in v0.6
//    self.courseList=[Data courseTable];
//    self.filteredList=[[NSMutableArray alloc]initWithCapacity:[self.courseList count]];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    NSLog(@"courselist: %@",[self.courseList description]);
//    NSLog(@"filteredList %d",[self.filteredList count]);
    
//    if (self.savedSearchTerm)
//	{
//        [self.searchDisplayController setActive:self.searchWasActive];
//        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
//        [self.searchDisplayController.searchBar setText:savedSearchTerm];
//        
//        self.savedSearchTerm = nil;
//    }
//	
//	[self.tableView reloadData];
//	self.tableView.scrollEnabled = YES;

    
}

-(void)viewDidDisappear:(BOOL)animated{
//    self.searchWasActive = [self.searchDisplayController isActive];
//    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
//    self.savedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
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
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        return [self.filteredList count];
    }
    else{
        return [self.courseList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AddCourseCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (self.segment.selectedSegmentIndex==0) {
        if (tableView==self.searchDisplayController.searchResultsTableView) {
            cell.textLabel.text=[[self.filteredList objectAtIndex:indexPath.row]objectForKey:@"cname"];
            cell.detailTextLabel.text=[[self.filteredList objectAtIndex:indexPath.row]objectForKey:@"tname"];
        }
        else{
            cell.textLabel.text=[[self.courseList objectAtIndex:indexPath.row]objectForKey:@"cname"];
            cell.detailTextLabel.text=[[self.courseList objectAtIndex:indexPath.row]objectForKey:@"tname"];
        }
    }
    else if(self.segment.selectedSegmentIndex==1){
        if (tableView==self.searchDisplayController.searchResultsTableView) {
            cell.textLabel.text=[[self.filteredList objectAtIndex:indexPath.row]objectForKey:@"tname"];
            cell.detailTextLabel.text=nil;
        }
        else{
            cell.textLabel.text=[[self.courseList objectAtIndex:indexPath.row]objectForKey:@"tname"];
            cell.detailTextLabel.text=nil;
        }
    }
    else if(self.segment.selectedSegmentIndex==2){
        
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

#pragma mark -segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"FirstLevelPush"]) {
        if (self.segment.selectedSegmentIndex==0) {
            if (self.searchDisplayController.searchResultsTableView==self.tableView) {
                SecondLevelViewController *viewController=(SecondLevelViewController*)segue.destinationViewController;
                NSIndexPath *indexPath=[self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
                NSString *courseName=[[self.filteredList objectAtIndex:indexPath.row]objectForKey:@"cname"];
                
                viewController.courseList=[Data oneCourseTable:courseName];
                viewController.navItem.title=[[self.filteredList objectAtIndex:indexPath.row] objectForKey:@"cname"];
            }
            else{
                SecondLevelViewController *viewController=(SecondLevelViewController*)segue.destinationViewController;
                NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
                NSString *courseName=[[self.courseList objectAtIndex:indexPath.row]objectForKey:@"cname"];
                
                viewController.courseList=[Data oneCourseTable:courseName];
                viewController.navItem.title=[[self.courseList objectAtIndex:indexPath.row] objectForKey:@"cname"];
            }
        }
        else if(self.segment.selectedSegmentIndex==1){
            if (self.tableView==self.searchDisplayController.searchResultsTableView) {
                SecondLevelViewController *viewController=(SecondLevelViewController*)segue.destinationViewController;
                NSIndexPath *indexPath=[self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
                NSString *teacherName=[[self.filteredList objectAtIndex:indexPath.row]objectForKey:@"tname"];
                viewController.courseList=[Data oneTeacherTable:teacherName];
                viewController.navItem.title=[[self.filteredList objectAtIndex:indexPath.row]objectForKey:@"tname"];
            }
            else{
                SecondLevelViewController *viewController=(SecondLevelViewController*)segue.destinationViewController;
                NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
                NSString *teacherName=[[self.courseList objectAtIndex:indexPath.row]objectForKey:@"tname"];
                viewController.courseList=[Data oneTeacherTable:teacherName];
                viewController.navItem.title=[[self.courseList objectAtIndex:indexPath.row]objectForKey:@"tname"];

            }
        }
        else if(self.segment.selectedSegmentIndex==2){
            
        }
        
    }
}

#pragma mark - content filtering

-(void)filterContentForSearchText:(NSString*)searchText{
    [self.filteredList removeAllObjects];
    for (NSDictionary *dict in self.courseList) {
        NSComparisonResult result=[[dict courseName] compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result==NSOrderedSame) {
            [self.filteredList addObject:dict];
        }
    }
//    NSLog(@"3st:%@",self.filteredList);

}

#pragma mark - searchdisplay delegate

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString];
//    NSLog(@"1st:%@",self.filteredList);
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]];
//    NSLog(@"2st:%@",self.filteredList);
    return YES;
}



@end
