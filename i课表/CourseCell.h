//
//  CourseCell.h
//  CurriSchedule
//
//  Created by piner on 5/1/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UILabel *classroom;
@property (weak, nonatomic) IBOutlet UILabel *courseTeacher;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *courseTime;
@end
