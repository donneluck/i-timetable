//
//  WelcomeViewController.m
//  CurriSchedule
//
//  Created by piner on 5/20/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

@synthesize welcomeText;
@synthesize username;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.welcomeText.text=[NSString stringWithFormat:@"%@,i课表欢迎您",self.username];
    self.entryButton.tintColor=[UIColor colorWithRed:46.0/255.0 green:204.0/255.0 blue:113.0/255.0 alpha:1.0];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterButtonTap:(id)sender {
    
}
@end
