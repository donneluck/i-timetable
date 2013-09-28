//
//  AppDelegate.m
//  CurriSchedule
//
//  Created by piner on 4/29/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled=YES;
    [NSThread sleepForTimeInterval:1.0]; 

    return YES;
}

- (void) startupAnimationDone:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    UIImageView *welcomeView;
    welcomeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    welcomeView.image = [UIImage imageNamed:@"Default.png"];
    [self.window addSubview:welcomeView];
    [self.window bringSubviewToFront:welcomeView];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.window cache:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(startupAnimationDone:finished:context:)];
    welcomeView.alpha = 0.0;
    welcomeView.frame = CGRectMake(-60, -85, 440, 635);
    [UIView commitAnimations];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}

@end
