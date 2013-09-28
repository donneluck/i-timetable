//
//  ScheduleViewController.m
//  CurriSchedule
//
//  Created by piner on 4/29/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "ScheduleViewController.h"

#define _ButtonWidthWorkday 55 //44 in v0.1
#define _ButtonWidthWeekend 16.5
#define _ButtonHeightNormal 75 //67 in v0.1
#define _ButtonHeightBottom 33
#define _StartX 12
#define _StartY 60
#define _ButtonMargin 2

@interface ScheduleViewController (){
}


@end

@implementation ScheduleViewController
@synthesize buttonDictionary;
@synthesize navItem;
@synthesize emptyButtonDictionary;
@synthesize nowWeek;

-(IBAction)buttonClicked:(UIButton*)sender{

    NSDictionary *dictionary=[self.buttonDictionary valueForKey:sender.titleLabel.text];
    NSLog(@"dictionary:%@",[dictionary description]);
    DetailViewController *detailViewController=[[DetailViewController alloc]initWithDictionary:dictionary];
    NSLog(@"combinedclassinweek:%@",[dictionary combinedClassInWeek]);
    detailViewController.modalTransitionStyle=UIModalTransitionStylePartialCurl;
    [self presentViewController:detailViewController animated:YES completion:nil];
}

-(IBAction)emptyButtonClicked:(UIButton*)sender{

    AddCourseFromButtonNavViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"AddCourseFromButtonNav"]; 
    AddCourseFromButtonViewController *topViewController=(AddCourseFromButtonViewController*)viewController.topViewController;
    
    
    topViewController.searchDetail=[self.emptyButtonDictionary objectForKey:sender.titleLabel.text];
    [self presentViewController:viewController animated:YES completion:nil];
}


//get schedule

-(void)initialButton{
    self.buttonDictionary=[[NSMutableDictionary alloc]init];
    self.emptyButtonDictionary=[[NSMutableDictionary alloc]init];
    
    //initial course data for display on button
    [[QBFlatButton appearance] setFaceColor:[UIColor colorWithWhite:0.75 alpha:1.0] forState:UIControlStateDisabled];
    [[QBFlatButton appearance] setSideColor:[UIColor colorWithWhite:0.55 alpha:1.0] forState:UIControlStateDisabled];
    NSArray *array=[Data weekList:[Data nowWeekOfTerm]];

    for (NSInteger day=0; day<7; day++) {
        for (NSInteger course=0; course<6; course++) {
            NSDictionary *oneCourse=[[array objectAtIndex:day]objectAtIndex:course];

            if (day<5&&course<5) {                
                if ([oneCourse isEqual:[NSNull null]]) {
                    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];

                    button.frame=CGRectMake(_StartX+day*_ButtonWidthWorkday, _StartY+course*_ButtonHeightNormal, _ButtonWidthWorkday-_ButtonMargin, _ButtonHeightNormal-_ButtonMargin);
                    
                    [button addTarget:self action:@selector(emptyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    button.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
                    button.titleLabel.font=[UIFont systemFontOfSize:8];
                    button.backgroundColor=[UIColor clearColor];
                    button.titleLabel.text=[NSString stringWithFormat:@"%d+%d",day,course];
                    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",day],@"weekday",[NSString stringWithFormat:@"%d",course],@"coursetime", nil];
                    [self.emptyButtonDictionary setObject:dict forKey:button.titleLabel.text];

                    [self.view addSubview:button];
                }
                else{
                    QBFlatButton *button = [QBFlatButton buttonWithType:UIButtonTypeCustom];
                    
                    button.frame=CGRectMake(_StartX+day*_ButtonWidthWorkday, _StartY+course*_ButtonHeightNormal, _ButtonWidthWorkday-_ButtonMargin, _ButtonHeightNormal-_ButtonMargin);
                    if ([oneCourse isOwn]==1) {
                        button.faceColor = [UIColor colorWithRed:232.0/255.0 green:85.0/255.0 blue:69.0/255.0 alpha:1.0];
                        button.sideColor = [UIColor colorWithRed:180.0/255.0 green:85.0/255.0 blue:69.0/255.0 alpha:1.0];

                        [button setTitle:[NSString stringWithFormat:@"%@\n%@\n%@\n自选",[oneCourse courseName],[oneCourse classRoom],[oneCourse teacherName]] forState:UIControlStateNormal];
                    }
                    else{
                        button.faceColor = [UIColor colorWithRed:37.0/255.0 green:191.0/255.0 blue:161.0/255.0 alpha:1.0];
                        button.sideColor = [UIColor colorWithRed:37.0/255.0 green:160.0/255.0 blue:161.0/255.0 alpha:1.0];

                        [button setTitle:[NSString stringWithFormat:@"%@\n%@\n%@",[oneCourse courseName],[oneCourse classRoom],[oneCourse teacherName]] forState:UIControlStateNormal];
                    }

                    button.radius = 6.0;
                    button.margin = 7.0;
                    button.depth = 6.0;
                    
                    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    button.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
                    button.titleLabel.font=[UIFont systemFontOfSize:8];
                    button.backgroundColor=[UIColor clearColor];
                    
                    [self.buttonDictionary setObject:oneCourse forKey:button.titleLabel.text];
                    
                    [self.view addSubview:button];
                }
            }
            
            //in fact , follows is not necessary,because reach the bottom of screen
            //if it's iphone 5...
            
            if (day<5&&course==5) {
                if ([oneCourse isEqual:[NSNull null]]) {
                    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
                    
                    button.frame=CGRectMake(_StartX+day*_ButtonWidthWorkday, _StartY+course*_ButtonHeightNormal, _ButtonWidthWorkday, _ButtonHeightBottom);
                    
                    [button addTarget:self action:@selector(emptyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    button.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
                    button.titleLabel.font=[UIFont systemFontOfSize:8];
                    button.backgroundColor=[UIColor clearColor];
                    button.titleLabel.text=[NSString stringWithFormat:@"%d+%d",day,course];
                    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",day],@"weekday",[NSString stringWithFormat:@"%d",course],@"coursetime", nil];
                    [self.emptyButtonDictionary setObject:dict forKey:button.titleLabel.text];
                    
                    [self.view addSubview:button];
                }
                else{
                    QBFlatButton *button = [QBFlatButton buttonWithType:UIButtonTypeCustom];
                    
                    button.frame=CGRectMake(_StartX+day*_ButtonWidthWorkday, _StartY+course*_ButtonHeightNormal, _ButtonWidthWorkday, _ButtonHeightBottom);
                    //                button.frame=CGRectMake(_StartX+day*_ButtonWidthWorkday, _StartY+course*_ButtonHeightNormal, _ButtonWidthWorkday-_ButtonMargin, _ButtonHeightNormal-_ButtonMargin);
                    button.faceColor = [UIColor colorWithRed:243.0/255.0 green:152.0/255.0 blue:0 alpha:1.0];
                    button.sideColor = [UIColor colorWithRed:170.0/255.0 green:105.0/255.0 blue:0 alpha:1.0];
                    button.radius = 8.0;
                    button.margin = 4.0;
                    button.depth = 3.0;
                    
                    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    button.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
                    [button setTitle:[NSString stringWithFormat:@"%@\n%@\n%@",[oneCourse courseName],[oneCourse classRoom],[oneCourse teacherName]] forState:UIControlStateNormal];
                    //                NSLog(@"%@",button.titleLabel.text);
                    button.titleLabel.font=[UIFont systemFontOfSize:8];
                    button.backgroundColor=[UIColor clearColor];
                    
                    [self.buttonDictionary setObject:oneCourse forKey:button.titleLabel.text];
                    
                    [self.view addSubview:button];
                }
            }
            
            //follows is saturday course, it seems like a little thin:
            if (day==5&&course<5) {
                if ([oneCourse isEqual:[NSNull null]]) {
                    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
                    
                    button.frame=CGRectMake(_StartX+day*_ButtonWidthWorkday, _StartY+course*_ButtonHeightNormal, _ButtonWidthWeekend, _ButtonHeightNormal);
                    
                    [button addTarget:self action:@selector(emptyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    button.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
                    button.titleLabel.font=[UIFont systemFontOfSize:8];
                    button.backgroundColor=[UIColor clearColor];
                    button.titleLabel.text=[NSString stringWithFormat:@"%d+%d",day,course];
                    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",day],@"weekday",[NSString stringWithFormat:@"%d",course],@"coursetime", nil];
                    [self.emptyButtonDictionary setObject:dict forKey:button.titleLabel.text];
                    
                    [self.view addSubview:button];
                }
                else{
                    QBFlatButton *button = [QBFlatButton buttonWithType:UIButtonTypeCustom];
                    
                    button.frame=CGRectMake(_StartX+day*_ButtonWidthWorkday, _StartY+course*_ButtonHeightNormal, _ButtonWidthWeekend, _ButtonHeightNormal);
                    //                button.frame=CGRectMake(_StartX+day*_ButtonWidthWorkday, _StartY+course*_ButtonHeightNormal, _ButtonWidthWorkday-_ButtonMargin, _ButtonHeightNormal-_ButtonMargin);
                    button.faceColor = [UIColor colorWithRed:243.0/255.0 green:152.0/255.0 blue:0 alpha:1.0];
                    button.sideColor = [UIColor colorWithRed:170.0/255.0 green:105.0/255.0 blue:0 alpha:1.0];
                    button.radius = 8.0;
                    button.margin = 4.0;
                    button.depth = 3.0;
                    
                    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    button.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
                    [button setTitle:[NSString stringWithFormat:@"%@\n%@\n%@",[oneCourse courseName],[oneCourse classRoom],[oneCourse teacherName]] forState:UIControlStateNormal];
                    //                NSLog(@"%@",button.titleLabel.text);
                    button.titleLabel.font=[UIFont systemFontOfSize:8];
                    button.backgroundColor=[UIColor clearColor];
                    
                    [self.buttonDictionary setObject:oneCourse forKey:button.titleLabel.text];
                    
                    [self.view addSubview:button];
                }

            }
            
            //follows is sunday course:
            if (day==6&&course<5) {
                if ([oneCourse isEqual:[NSNull null]]) {
                    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
                    
                    button.frame=CGRectMake(_StartX+5*_ButtonWidthWorkday+_ButtonWidthWeekend, _StartY+course*_ButtonHeightNormal, _ButtonWidthWeekend, _ButtonHeightNormal);
                    
                    [button addTarget:self action:@selector(emptyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    button.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
                    button.titleLabel.font=[UIFont systemFontOfSize:8];
                    button.backgroundColor=[UIColor clearColor];
                    button.titleLabel.text=[NSString stringWithFormat:@"%d+%d",day,course];
                    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",day],@"weekday",[NSString stringWithFormat:@"%d",course],@"coursetime", nil];
                    [self.emptyButtonDictionary setObject:dict forKey:button.titleLabel.text];
                    
                    [self.view addSubview:button];
                }
                else{
                    QBFlatButton *button = [QBFlatButton buttonWithType:UIButtonTypeCustom];
                    
                    button.frame=CGRectMake(_StartX+5*_ButtonWidthWorkday+_ButtonWidthWeekend, _StartY+course*_ButtonHeightNormal, _ButtonWidthWeekend, _ButtonHeightNormal);
                    //                button.frame=CGRectMake(_StartX+day*_ButtonWidthWorkday, _StartY+course*_ButtonHeightNormal, _ButtonWidthWorkday-_ButtonMargin, _ButtonHeightNormal-_ButtonMargin);
                    button.faceColor = [UIColor colorWithRed:243.0/255.0 green:152.0/255.0 blue:0 alpha:1.0];
                    button.sideColor = [UIColor colorWithRed:170.0/255.0 green:105.0/255.0 blue:0 alpha:1.0];
                    button.radius = 8.0;
                    button.margin = 4.0;
                    button.depth = 3.0;
                    
                    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    button.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
                    [button setTitle:[NSString stringWithFormat:@"%@\n%@\n%@",[oneCourse courseName],[oneCourse classRoom],[oneCourse teacherName]] forState:UIControlStateNormal];
                    //                NSLog(@"%@",button.titleLabel.text);
                    button.titleLabel.font=[UIFont systemFontOfSize:8];
                    button.backgroundColor=[UIColor clearColor];
                    
                    [self.buttonDictionary setObject:oneCourse forKey:button.titleLabel.text];
                    
                    [self.view addSubview:button];
                }
            }
            
            if (day==5&&course==5) {
                if ([oneCourse isEqual:[NSNull null]]) {
                    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
                    
                    button.frame=CGRectMake(_StartX+day*_ButtonWidthWorkday, _StartY+course*_ButtonHeightNormal, _ButtonWidthWorkday, _ButtonHeightBottom);
                    
                    [button addTarget:self action:@selector(emptyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    button.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
                    button.titleLabel.font=[UIFont systemFontOfSize:8];
                    button.backgroundColor=[UIColor clearColor];
                    button.titleLabel.text=[NSString stringWithFormat:@"%d+%d",day,course];
                    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",day],@"weekday",[NSString stringWithFormat:@"%d",course],@"coursetime", nil];
                    [self.emptyButtonDictionary setObject:dict forKey:button.titleLabel.text];
                    
                    [self.view addSubview:button];
                }
                else{
                    QBFlatButton *button = [QBFlatButton buttonWithType:UIButtonTypeCustom];
                    
                    button.frame=CGRectMake(_StartX+day*_ButtonWidthWorkday, _StartY+course*_ButtonHeightNormal, _ButtonWidthWorkday, _ButtonHeightBottom);
                    //                button.frame=CGRectMake(_StartX+day*_ButtonWidthWorkday, _StartY+course*_ButtonHeightNormal, _ButtonWidthWorkday-_ButtonMargin, _ButtonHeightNormal-_ButtonMargin);
                    button.faceColor = [UIColor colorWithRed:243.0/255.0 green:152.0/255.0 blue:0 alpha:1.0];
                    button.sideColor = [UIColor colorWithRed:170.0/255.0 green:105.0/255.0 blue:0 alpha:1.0];
                    button.radius = 6.0;
                    button.margin = 7.0;
                    button.depth = 6.0;
                    
                    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    button.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
                    [button setTitle:[NSString stringWithFormat:@"%@\n%@\n%@",[oneCourse courseName],[oneCourse classRoom],[oneCourse teacherName]] forState:UIControlStateNormal];
                    //                NSLog(@"%@",button.titleLabel.text);
                    button.titleLabel.font=[UIFont systemFontOfSize:8];
                    button.backgroundColor=[UIColor clearColor];
                    
                    [self.buttonDictionary setObject:oneCourse forKey:button.titleLabel.text];
                    
                    [self.view addSubview:button];
                }
            }
            
            if (day==6&&course==5) {
                if ([oneCourse isEqual:[NSNull null]]) {
                    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
                    
                    button.frame=CGRectMake(_StartX+5*_ButtonWidthWorkday+_ButtonWidthWeekend, _StartY+course*_ButtonHeightNormal, _ButtonWidthWorkday, _ButtonHeightBottom);
                    
                    [button addTarget:self action:@selector(emptyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    button.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
                    button.titleLabel.font=[UIFont systemFontOfSize:8];
                    button.backgroundColor=[UIColor clearColor];
                    button.titleLabel.text=[NSString stringWithFormat:@"%d+%d",day,course];
                    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",day],@"weekday",[NSString stringWithFormat:@"%d",course],@"coursetime", nil];
                    [self.emptyButtonDictionary setObject:dict forKey:button.titleLabel.text];
                    
                    [self.view addSubview:button];
                }
                else{
                    QBFlatButton *button = [QBFlatButton buttonWithType:UIButtonTypeCustom];
                    
                    button.frame=CGRectMake(_StartX+5*_ButtonWidthWorkday+_ButtonWidthWeekend, _StartY+course*_ButtonHeightNormal, _ButtonWidthWorkday, _ButtonHeightBottom);
                    //                button.frame=CGRectMake(_StartX+day*_ButtonWidthWorkday, _StartY+course*_ButtonHeightNormal, _ButtonWidthWorkday-_ButtonMargin, _ButtonHeightNormal-_ButtonMargin);
                    button.faceColor = [UIColor colorWithRed:243.0/255.0 green:152.0/255.0 blue:0 alpha:1.0];
                    button.sideColor = [UIColor colorWithRed:170.0/255.0 green:105.0/255.0 blue:0 alpha:1.0];
                    button.radius = 8.0;
                    button.margin = 4.0;
                    button.depth = 3.0;
                    
                    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                    button.titleLabel.lineBreakMode=NSLineBreakByCharWrapping;
                    [button setTitle:[NSString stringWithFormat:@"%@\n%@\n%@",[oneCourse courseName],[oneCourse classRoom],[oneCourse teacherName]] forState:UIControlStateNormal];
                    //                NSLog(@"%@",button.titleLabel.text);
                    button.titleLabel.font=[UIFont systemFontOfSize:8];
                    button.backgroundColor=[UIColor clearColor];
                    
                    [self.buttonDictionary setObject:oneCourse forKey:button.titleLabel.text];
                    
                    [self.view addSubview:button];
                }
            }
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated{

}
 

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self viewDidLoad];

    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    if (![self.slidingViewController.underRightViewController isKindOfClass:[TodayCourseViewController class]]) {
        self.slidingViewController.underRightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TodayCourse"];
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init{
    self=[super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    self.navItem.rightBarButtonItem.tintColor=[Data buttonColor];
    self.navItem.leftBarButtonItem.tintColor=[Data buttonColor];
    self.navigationController.navigationItem.rightBarButtonItem.tintColor=[Data buttonColor];
    self.navigationController.navigationItem.leftBarButtonItem.tintColor=[Data buttonColor];
    self.navigationController.navigationItem.backBarButtonItem.tintColor=[Data buttonColor];
    
    self.menuButton.image=[Data menuButton];

    [self initialButton];
    
        self.navItem.title=[NSString stringWithFormat:@"第%d周",[Data nowWeekOfTerm]];
        self.nowWeek=[Data nowWeekOfTerm];
    self.navigationController.view.backgroundColor=[UIColor colorWithRed:(50.0f/255.0f) green:(57.0f/255.0f) blue:(74.0f/255.0f) alpha:1.0f];
    self.segmentControl.segmentedControlStyle=UISegmentedControlStyleBar;
    
    [self.segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
}


- (IBAction)segmentAction:(id)sender
{
	// The segmented control was clicked, handle it here
	UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
	if (segmentedControl.selectedSegmentIndex==0) {
        [self showPreWeek];
    }
    else{
        [self showNextWeek];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)RevealMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)RevealToday:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECLeft];
}

#pragma mark - dcpathbutton delegate
- (void)button_0_action{
    NSLog(@"Button Press Tag 0!!");
}

-(void)showNextWeek{
    self.nowWeek+=1;
    [Data weekList:self.nowWeek];
    [self viewDidLoad];
    [self.view setNeedsDisplay];
}

-(void)showPreWeek{
    self.nowWeek-=1;
    [Data weekList:self.nowWeek];
    [self viewDidLoad];
}


@end
