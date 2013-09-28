//
//  UserData.h
//  CurriSchedule
//
//  Created by piner on 5/2/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

#pragma mark --UserData v0.2
//new design

+(NSArray*)weekList;
+(NSArray*)todayList;
+(NSArray*)notificationList;


#pragma mark --UserData v0.1
//week course view
@property(nonatomic,strong)NSArray *weekCourse;
@property(nonatomic,strong)NSArray *dayCourse;
@property(nonatomic,strong)NSMutableDictionary *courseDetail;
@property(nonatomic,strong)NSArray *detailKeyArray;
@property(nonatomic,strong)NSArray *detailValueArray;
//data from server
@property(nonatomic,strong)NSArray *dataArray;
//today view array
@property(nonatomic,strong)NSMutableArray *todayList;
//date and week calculating
//but not use
@property(nonatomic,strong)NSDate *startDate;
@property(nonatomic,strong)NSDate *nowDate;
@property(nonatomic,strong)NSCalendar *calendar;

@property int nowWeek;

//specific course time point
@property(nonatomic,strong)NSString *firstCourse;
@property(nonatomic,strong)NSString *secondCourse;
@property(nonatomic,strong)NSString *thirdCourse;
@property(nonatomic,strong)NSString *fourthCourse;
@property(nonatomic,strong)NSString *fifthCourse;
@property(nonatomic,strong)NSString *sixthCourse;

//6 course array of hours and minutes
@property(nonatomic,strong)NSArray *hoursArray;
@property(nonatomic,strong)NSArray *minutesArray;


//specific course time complete
@property(nonatomic,strong)NSDate *firstDate;
@property(nonatomic,strong)NSDate *secondDate;
@property(nonatomic,strong)NSDate *thirdDate;
@property(nonatomic,strong)NSDate *fourthDate;
@property(nonatomic,strong)NSDate *fifthDate;
@property(nonatomic,strong)NSDate *sixthDate;

@property(nonatomic,strong)NSMutableArray *timeList;

//today notificaiton queue
@property(nonatomic,strong)NSMutableArray *todayNotificationList;


//method:

@end
