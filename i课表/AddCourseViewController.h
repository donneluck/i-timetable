//
//  AddCourseViewController.h
//  CurriSchedule
//
//  Created by piner on 5/9/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "SecondLevelViewController.h"

@interface AddCourseViewController : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate>

@property(nonatomic,strong)NSArray *courseList;

- (IBAction)RevealMenu:(id)sender;

- (IBAction)segmentControl:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

#pragma mark - search

@property(nonatomic,strong)NSMutableArray *filteredList;


//if a memory warning ?
@property(nonatomic,strong)NSString *savedSearchTerm;
@property(nonatomic)NSInteger savedScopeButtonIndex;
@property(nonatomic)BOOL searchWasActive;

@end
