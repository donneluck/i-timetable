//
//  WelcomeViewController.h
//  CurriSchedule
//
//  Created by piner on 5/20/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *welcomeText;
@property(nonatomic,strong)NSString *username;
@property (weak, nonatomic) IBOutlet UIButton *entryButton;

- (IBAction)enterButtonTap:(id)sender;
@end
