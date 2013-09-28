//
//  RemindPickerViewController.h
//  CurriSchedule
//
//  Created by piner on 5/13/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingViewController.h"

@interface RemindPickerViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)NSDictionary *dataList;
@property(nonatomic,strong)NSArray *timeArray;

@property(nonatomic,strong)SettingViewController *preViewController;

@property(nonatomic)int customValue; //for KVO
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
- (IBAction)donePicker:(id)sender;

@end
