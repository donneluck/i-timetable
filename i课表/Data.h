//
//  Data.h
//  CurriSchedule
//
//  Created by piner on 5/11/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemindPickerViewController.h"
#import "SIAlertView.h"

@interface Data : NSObject
//data model version 0.6
//no any plist file in documents

+(UIColor*)backgroundColor;
+(UIColor*)buttonColor;
+(UIImage*)menuButton;

//week 
+(NSArray*)weekList:(NSUInteger)nowWeek;
+(NSArray*)todayList;
+(void)notificationList:(int)timeInterval;

#pragma mark - search
+(NSArray*)searchCourse:(NSString*)courseName;
+(NSArray*)searchCourse:(NSString *)courseName withWeek:(int)week;
+(NSArray*)searchCoursewithWeek:(int)week andWeekday:(int)weekday andCourseTime:(NSString*)coursetime;

//convert data from receive friend'data
+(NSArray*)convertFriendData:(NSDictionary*)dictionary;

//update
+(void)deleteByDictionary:(NSDictionary*)dictionary;//rename by deleteFromPlistByDictionary

+(BOOL)replaceData:(NSData*)data;
+(BOOL)deleteData;

+(NSArray*)courseList;
+(NSArray*)followsList;

+(BOOL)deleteFollowFromFile:(NSDictionary*)dictionary;
+(BOOL)addFollowToFile:(NSDictionary*)dictionary;


//date and week
+(NSCalendar*)calendar;
+(NSUInteger)nowWeekOfTerm;
+(NSUInteger)weekdayOfToday;

+(BOOL)isEmpty;

#pragma mark - update plist

+(void)deleteFromPlist:(int)index;//this method not use in current version (v0.6)

+(int)addCourse:(NSDictionary*)dictionary;

//refetchdata
+(BOOL)refetchData;

#pragma mark -alert view


#pragma mark - user infomation operation
+(void)saveUsername:(NSString*)username;
+(NSString*)getUsername;
+(void)savePassword:(NSString*)password;
+(NSString*)getPassword;
+(void)saveRemindTime:(int)remindTime;
+(int)getRemindTime;
+(void)saveFullname:(NSString*)fullname;
+(NSString*)getFullname;

@end
