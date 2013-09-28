//
//  MyCourseCell.m
//  CurriSchedule
//
//  Created by piner on 5/12/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "MyCourseCell.h"

@implementation MyCourseCell
@synthesize className;
@synthesize classRoom;
@synthesize classTeacher;
@synthesize classTime;
@synthesize isOwnChoose;

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

@end
