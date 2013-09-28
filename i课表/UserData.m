//
//  UserData.m
//  CurriSchedule
//
//  Created by piner on 5/2/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "UserData.h"

@implementation UserData
@synthesize weekCourse;
@synthesize dayCourse;
@synthesize courseDetail;
@synthesize detailKeyArray;
@synthesize detailValueArray;

@synthesize dataArray;

@synthesize calendar;

@synthesize nowWeek;

@synthesize todayList;

//specific course time point
@synthesize firstCourse;
@synthesize secondCourse;
@synthesize thirdCourse;
@synthesize fourthCourse;
@synthesize fifthCourse;
@synthesize sixthCourse;

@synthesize hoursArray;
@synthesize minutesArray;

@synthesize firstDate;
@synthesize secondDate;
@synthesize thirdDate;
@synthesize fourthDate;
@synthesize fifthDate;
@synthesize sixthDate;

@synthesize timeList;

@synthesize todayNotificationList;


- (id)init
{
    self = [super init];
    if (self) {
        //for week course view
        [self getweekCourse];
        [self getData];
        [self getDataArray];
        //for today list
        [self getTodayList];
        
//        [self getTimeList];
        [self getTodayNotificationList];
    }
    return self;
}

#pragma mark - week course table view

//it's a method to make sure all initial


-(NSMutableDictionary*)getCourseDetail{
    self.detailKeyArray=[[NSArray alloc]initWithObjects:@"cname",@"sname",@"tname",@"own",@"tcdno",@"classno",@"tcdstartweek",@"tcdendweek",@"tcdweekday",@"tcdclassserial",@"tcdclass",@"tcdroom",@"tcdweekprop",@"tcddescription", nil];
    
    self.detailValueArray=[[NSArray alloc]initWithObjects:[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null] ,nil];

    return [[NSMutableDictionary alloc]initWithObjects:detailValueArray forKeys:detailKeyArray];
}

-(NSArray*)getDayCourse{
    return [[NSArray alloc]initWithObjects:[self getCourseDetail],[self getCourseDetail],[self getCourseDetail],[self getCourseDetail],[self getCourseDetail],[self getCourseDetail], nil];
}

//get data table
-(NSArray*)getweekCourse{
    self.weekCourse= [[NSArray alloc]initWithObjects:[self getDayCourse],[self getDayCourse],[self getDayCourse],[self getDayCourse],[self getDayCourse],[self getDayCourse],[self getDayCourse], nil];
    return self.weekCourse;
}

//read sample data 1.0
-(NSArray*)getData{
    self.dataArray=[UserFile getCourseArray];
    return self.dataArray;
}

//initialize data table from sample data
-(NSArray*)getDataArray{
    self.dataArray=[self getData];
    for (int course=0; course<[self.dataArray count]; course++) {
        
        //here need something about nsdate
        //no judge single or double
        //no judge startweek and endweek
        //no judge is own or not
        
//        [self initialCalendar];
        
        //now week
        self.nowWeek=[self getNowWeek];
        //startweek and endweek
        
        //!weekday and courseSerial index begin 1
        //!need to min 1
        
        int weekday=[[[self.dataArray objectAtIndex:course] valueForKey:@"tcdweekday"] intValue]-1;
        int courseSerial=[[[self.dataArray objectAtIndex:course] valueForKey:@"tcdclassserial"] intValue]-1;
        NSLog(@"weekday:%d",weekday);
        NSLog(@"courseSerial:%d",courseSerial);
        //course detail from plist to table
        NSMutableDictionary *toCourse=[[self.weekCourse objectAtIndex:weekday] objectAtIndex:courseSerial];
        NSDictionary *fromCourse=[self.dataArray objectAtIndex:course];
        
        
        NSLog(@"fromcourse:%@",[fromCourse valueForKey:@"cname"]);
        NSLog(@"pre_tocourse:%@",[toCourse valueForKey:@"cname"]);
        
        NSLog(@"detailKeyArray count:%d",[self.detailKeyArray count]);
        NSLog(@"detailValueArray count:%d",[self.detailValueArray count]);
        
        //now week
        self.nowWeek=[self getNowWeek];
        //startweek and endweek
        int startWeek=[[fromCourse valueForKey:@"tcdstartweek"]intValue];
        int endWeek=[[fromCourse valueForKey:@"tcdendweek"]intValue];
        //single or double week course
        int weekprop=[[fromCourse valueForKey:@"tcdweekprop"]intValue];

        if ((self.nowWeek<=endWeek)&&(self.nowWeek>=startWeek)) {
            if ((weekprop==0)||(self.nowWeek%2==weekprop)||(self.nowWeek%2+2==weekprop)) {
                for (int key=0; key<[self.detailKeyArray count]; key++) {
                    NSString *value=[self.detailKeyArray objectAtIndex:key];
                    [toCourse setValue:[fromCourse valueForKey:value] forKey:value];
                }
            }
        }
        
        NSLog(@"after_toCourse:%@",[toCourse valueForKey:@"cname"]);
        NSLog(@"after_weekCourse:%@",[[[self.weekCourse objectAtIndex:weekday]objectAtIndex:courseSerial]valueForKey:@"sname"]);
    }
    return self.weekCourse;
}

#pragma mark -today course list

-(int)getWeekdayOfToday{
//    NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *comps=[calendar components:NSWeekCalendarUnit fromDate:[NSDate date]];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"c"];
    
    
    
    NSLog(@"the current day of weekday is %@",[dateFormatter stringFromDate:[NSDate date]]);

//    NSLog(@"the current day of weekday is %d",[comps weekday]);

//    return [comps weekday];
    return [[dateFormatter stringFromDate:[NSDate date]]intValue];
}

-(NSMutableArray*)getTodayList{
    self.todayList=[[NSMutableArray alloc]init];
    int todayWeekday=[self getWeekdayOfToday];
    self.dataArray=[self getData];
    for (int course=0; course<[self.dataArray count]; course++) {
        
        int weekday=[[[self.dataArray objectAtIndex:course] valueForKey:@"tcdweekday"] intValue];
        //weekday: 1=monday and 7=sunday
        //but todayWeekday 2=monday and 1=sunday
        if (todayWeekday==weekday+1) {
            [self.todayList addObject:[self.dataArray objectAtIndex:course]];
        }
        if (todayWeekday==1&&weekday==7) {
            [self.todayList addObject:[self.dataArray objectAtIndex:course]];
        }
    }
//    [self.todayList sort]
    return self.todayList;
}

#pragma mark -Date and week


-(int)getNowWeek{
    NSUInteger week=[self.calendar ordinalityOfUnit:NSCalendarCalendarUnit inUnit:NSCalendarCalendarUnit forDate:[NSDate date]];
    NSLog(@"this week is %d 's week",week);
    
    //another method
    NSDateFormatter *weekFormatter=[[NSDateFormatter alloc]init];
    [weekFormatter setDateFormat:@"w"];
    int weekCount=[[weekFormatter stringFromDate:[NSDate date]]intValue]-8;
    NSLog(@"the week is %d",weekCount);
    
    return weekCount;
}

#pragma mark -specific time 

//specific time

-(void)getTimeString{
    self.firstCourse=@"8:00 am";
    self.secondCourse=@"10:05 am";
    self.thirdCourse=@"2:00 pm";
    self.fourthCourse=@"4:05 pm";
    self.fifthCourse=@"7:00 pm";
    self.sixthCourse=@"8:50 pm";
}

-(void)getHoursAndMinutesArray{
    self.hoursArray=[[NSArray alloc]initWithObjects:@"8",@"10",@"14",@"16",@"19",@"20", nil];
    self.minutesArray=[[NSArray alloc]initWithObjects:@"0",@"5",@"0",@"5",@"0",@"50", nil];
}

-(void)getCalendar{
    self.calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    //[self.calendar setLocale];
    //[self.calendar setTimeZone:];
    [self.calendar setFirstWeekday:2];
    [self.calendar setMinimumDaysInFirstWeek:1];
}

-(NSMutableArray*)getTimeList{
    
    self.timeList=[[NSMutableArray alloc]init];
    
    //NSDateComponent NSdate NSCalendar in here:
    [self getCalendar];
    [self getTimeString];
    [self getHoursAndMinutesArray];
    NSDateComponents *dateComponents=[self.calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
    //maybe not use
    
    for (int iTimeList=0; iTimeList<6; iTimeList++) {
        NSDateComponents *components=[[NSDateComponents alloc]init];
        [components setYear:[dateComponents year]];
        [components setMonth:[dateComponents month]];
        [components setDay:[dateComponents day]];
        [components setHour:[[self.hoursArray objectAtIndex:iTimeList]intValue]];
        [components setMinute:[[self.minutesArray objectAtIndex:iTimeList]intValue]];
        [components setSecond:0];
        
        NSLog(@"%@",[components description]);
        
        
        NSDate *date=[calendar dateFromComponents:components];
        NSLog(@"%@",[date description]);
        
        [self.timeList addObject:date];
        
        
    }
    //for test
    
    NSLog(@"%@",[self.timeList description]);
    
    return self.timeList;
//    NSDateFormatter *formatter=[[NSDateFormatter alloc] dateFromString:self.firstCourse];
}

-(NSArray*)getTodayNotificationList{
    self.todayNotificationList=[[NSMutableArray alloc]init];
    
    self.timeList=[self getTimeList];
    NSLog(@"%@",[self.timeList description]);
    [self getTodayList];
    
    for (int iList = 0; iList<[self.todayList count]; iList++) {
        int classserial=[[[self.todayList objectAtIndex:iList]valueForKey:@"tcdclassserial"]intValue];
        [self.todayNotificationList addObject:[self.timeList objectAtIndex:classserial]];
//        self.todayList=[self.todayList sortedArrayUsingComparator:^NSComparisonResult(id a,id b){
//            NSUInteger first=[[(NSDictionary*)a valueForKey:@"tcdclassserial"]intValue];
//            NSUInteger second=[[(NSDictionary*)b valueForKey:@"tcdclassserial"]intValue];
//            return [first compare:second];
//        }]
    }
    NSLog(@"%@",[self.todayNotificationList description]);

    return self.todayNotificationList;
    
}



@end
