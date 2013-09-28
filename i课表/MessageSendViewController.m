//
//  MessageSendViewController.m
//  CurriSchedule
//
//  Created by piner on 5/11/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "MessageSendViewController.h"

@interface MessageSendViewController ()

@end

@implementation MessageSendViewController

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

- (IBAction)cancelTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendTap:(id)sender {
    //send method in here:
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
