//
//  MessageCell.h
//  CurriSchedule
//
//  Created by piner on 5/1/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *messageTitle;
@property (weak, nonatomic) IBOutlet UILabel *messageContent;
@property (weak, nonatomic) IBOutlet UILabel *messageDate;
@end
