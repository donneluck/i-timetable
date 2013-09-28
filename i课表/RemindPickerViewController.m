//
//  RemindPickerViewController.m
//  CurriSchedule
//
//  Created by piner on 5/13/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "RemindPickerViewController.h"

@interface RemindPickerViewController ()

@end

@implementation RemindPickerViewController

@synthesize dataList;
@synthesize timeArray;

@synthesize preViewController;

@synthesize customValue;

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
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    self.navItem.rightBarButtonItem.tintColor=[Data buttonColor];

	// Do any additional setup after loading the view.
    self.dataList=[[NSDictionary alloc]initWithObjectsAndKeys:@"5分钟之前",@"5",@"10分钟之前",@"10",@"15分钟之前",@"15",@"30分钟之前",@"30", nil];
    self.timeArray=[[NSArray alloc]initWithObjects:@"5",@"10",@"15",@"30", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PickerView
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.timeArray count];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *key=[self.timeArray objectAtIndex:row];
    return [self.dataList valueForKey:key];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [Data notificationList:[[self.timeArray objectAtIndex:row]intValue]];
    [Data saveRemindTime:[[self.timeArray objectAtIndex:row]intValue]];
}

//ths method not work
-(NSInteger)selectedRowInComponent:(NSInteger)component{
    int remind=[Data getRemindTime];
    for (int iList=0; iList<[self.timeArray count]; iList++) {
        if (remind==[[self.timeArray objectAtIndex:iList]intValue]) {
            return iList;
        }
    }
}

- (IBAction)donePicker:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
