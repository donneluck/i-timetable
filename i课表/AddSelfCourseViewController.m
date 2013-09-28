//
//  AddSelfCourseViewController.m
//  CurriSchedule
//
//  Created by piner on 5/12/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "AddSelfCourseViewController.h"

@interface AddSelfCourseViewController ()

@end

@implementation AddSelfCourseViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
