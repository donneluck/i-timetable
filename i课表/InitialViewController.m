//
//  InitialViewController.m
//  CurriSchedule
//
//  Created by piner on 4/29/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "InitialViewController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.topViewController=[storyboard instantiateViewControllerWithIdentifier:@"WeekSchedule"];
}



@end
