//
//  NSDictionary+Course.h
//  CurriSchedule
//
//  Created by piner on 5/11/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(Course)

+(NSMutableDictionary*)getData;
+(void)writeData:(NSDictionary*)dictionary;
+(NSString*)getPath;
+(NSString*)getFriendPath;
+(BOOL)writeFriend:(NSDictionary*)root;
+(NSMutableDictionary*)getFriend;

+(NSArray*)course;
+(NSArray*)follows;


-(NSString*)courseName;
-(NSString*)studentName;
-(NSString*)teacherName;
-(int)isOwn;
-(NSString*)tcdno;
-(NSString*)classNo;
-(NSUInteger)startWeek;
-(NSUInteger)endWeek;
-(NSUInteger)weekday;
-(NSUInteger)classSerial;//1 5 6
-(NSString*)classTime;//1-2 5-6
-(NSString*)classRoom;
-(NSUInteger)weekProp;//0 1 2
-(NSString*)classDescription;
-(NSString*)combinedClassWeek;
-(NSString*)combinedClassInWeek;


//relation
-(NSString*)friendName;
-(NSString*)friendId;
-(NSString*)friendSex;
-(NSString*)friendDescription;
-(NSString*)fno;
-(NSString*)friendPassword;

@end
