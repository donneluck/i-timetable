//
//  AddFriendCell.m
//  CurriSchedule
//
//  Created by Donne on 5/27/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "AddFriendCell.h"

@implementation AddFriendCell

@synthesize preViewController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addFollow:(id)sender {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.preViewController.view];
    [self.preViewController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self.preViewController;
    HUD.labelText=@"添加中";
    
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(addOperation) onTarget:self withObject:nil animated:YES];

}

-(void)addOperation{
    NSString *path=[NSString stringWithFormat:@"%@",_BaseURLString];
    [[NetworkClient sharedClient]getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //add follow status in here:
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
@end
