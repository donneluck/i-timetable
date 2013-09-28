//
//  SecondLevelCell.h
//  CurriSchedule
//
//  Created by piner on 5/15/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondLevelCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *className;
@property (weak, nonatomic) IBOutlet UILabel *classRoom;
@property (weak, nonatomic) IBOutlet UILabel *classTeacher;
@property (weak, nonatomic) IBOutlet UILabel *classTime;

@end
