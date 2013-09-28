//
//  Data.m
//  CurriSchedule
//
//  Created by piner on 5/11/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "Data.h"

@implementation Data

#pragma mark - UI style

+(UIColor*)backgroundColor{
    return [UIColor colorWithRed:180.0/255.0 green:40.0/255.0 blue:25.0/255.0 alpha:1];
}

+(UIColor*)buttonColor{
    return [UIColor colorWithRed:180.0/255.0 green:40.0/255.0 blue:25.0/255.0 alpha:1];
}

+(UIImage*)menuButton{
    return [UIImage imageNamed:@"menuButton.png"];
}

#pragma mark - plist file



+(BOOL)isEmpty{
    if ([[NSDictionary getData]isEqual:[NSNull null]]) {
        return YES;
    }else{
        return NO;
    }
}

+(NSArray*)weekList:(NSUInteger)nowWeek{
    NSMutableArray *array=[[NSMutableArray alloc]initWithObjects:[[NSMutableArray alloc]initWithObjects:[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null], nil],[[NSMutableArray alloc]initWithObjects:[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null], nil],[[NSMutableArray alloc]initWithObjects:[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null], nil],[[NSMutableArray alloc]initWithObjects:[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null], nil],[[NSMutableArray alloc]initWithObjects:[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null], nil],[[NSMutableArray alloc]initWithObjects:[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null], nil],[[NSMutableArray alloc]initWithObjects:[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null], nil], nil];
    for (NSDictionary *dict in [NSDictionary course]) {
        if (nowWeek>=[dict startWeek]&&nowWeek<=[dict endWeek]) {
            if ([dict weekProp]==0||[dict weekProp]==nowWeek%2||[dict weekProp]==nowWeek%2+2) {
                if ([dict isOwn]==1&&![[[array objectAtIndex:[dict weekday]-1]objectAtIndex:[dict classSerial]-1]isEqual:[NSNull null]]) {
                    continue;
                }
                else{
                    [[array objectAtIndex:[dict weekday]-1]replaceObjectAtIndex:[dict classSerial]-1 withObject:dict];
                }
            }
        }
    }
    NSLog(@"week array:%@",[array description]);
    return array;
}

+(NSArray*)todayList{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for (NSDictionary *dict in [[Data weekList:[Data nowWeekOfTerm]]objectAtIndex:[Data weekdayOfToday]-1]) {
        if (![dict isEqual:[NSNull null]]) {
            [array addObject:dict];
        }
    }
    return array;
}


+(void)notificationList:(int)timeInterval{
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    NSArray *hoursArray=[[NSArray alloc]initWithObjects:@"8",@"10",@"14",@"16",@"19",@"20", nil];
    NSArray *minutesArray=[[NSArray alloc]initWithObjects:@"0",@"5",@"0",@"5",@"0",@"50", nil];
    for (NSDictionary *dict in [NSDictionary course]) {
        NSDateComponents *components=[[Data calendar] components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
        NSDateComponents *dateComponents=[[NSDateComponents alloc]init];
        NSInteger dateInterval=[Data weekdayOfToday]-[dict weekday];
        [dateComponents setYear:[components year]];
        [dateComponents setMonth:[components month]];
        [dateComponents setDay:[components day]-dateInterval];
        [dateComponents setHour:[[hoursArray objectAtIndex:[dict classSerial]-1]intValue]];
        [dateComponents setMinute:[[minutesArray objectAtIndex:[dict classSerial]-1]intValue]];
        [dateComponents setSecond:0];
        NSDate *date=[[Data calendar]dateFromComponents:dateComponents];
        NSDate *remindDate=[date dateByAddingTimeInterval:-60*timeInterval];
        UILocalNotification *localNotification=[[UILocalNotification alloc]init];
        localNotification.fireDate=remindDate;
        localNotification.timeZone=[NSTimeZone defaultTimeZone];
        localNotification.soundName=UILocalNotificationDefaultSoundName;
        localNotification.repeatInterval=NSWeekCalendarUnit;
        NSString *alertBody=[NSString stringWithFormat:@"%d分钟之后:%@\n地点:%@",timeInterval,[dict courseName],[dict classRoom]];
        localNotification.alertBody=alertBody;
        localNotification.alertAction=@"上课啦";
        [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
    }
}


//this method just validating
//uncomplete
+(int)addCourse:(NSDictionary*)dictionary{
    int indicator=0;
    NSMutableDictionary *root=[NSDictionary getData];
    NSMutableDictionary *newRoot=[[NSMutableDictionary alloc]initWithDictionary:root copyItems:YES];
    [newRoot removeObjectForKey:@"data"];
    NSArray *array=[root objectForKey:@"data"];
    NSMutableArray *newArray=[[NSMutableArray alloc]initWithArray:array copyItems:YES];
    
    for (NSDictionary *dict in newArray) {
        if ([dictionary isEqualToDictionary:dict]) {
            return 0;
        }
    }
    return 1;
}

+(BOOL)refetchData{
    NSString *path=[[NSString alloc]initWithFormat:@"%@/login?username=%@&password=%@",_BaseURLString,[Data getUsername],[Data getPassword]];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
    [[NetworkClient sharedClient]getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data=[NSJSONSerialization dataWithJSONObject:responseObject options:kNilOptions error:nil];
        NSDictionary *root=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"new root:%@",[root description]);
        [Data replaceData:data];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    return YES;
}

#pragma mark - search

+(NSArray*)searchCourse:(NSString*)courseName{
    //no page
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSString *path=[[NSString alloc]initWithFormat:@"%@/search?class=%@",_BaseURLString,courseName];
    NSURL *url=[NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *root=(NSDictionary*)JSON;
        NSArray *searchList=[root objectForKey:@"list"];
        for (NSDictionary *dict in searchList) {
            [array addObject:dict];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
    }];
    return array;
}

#pragma mark - search

+(NSArray*)searchCourse:(NSString *)courseName withWeek:(int)week{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSString *path=[[NSString alloc]initWithFormat:@"%@/search?class=%@&week=%d",_BaseURLString,courseName,week];
    NSURL *url=[NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *root=(NSDictionary*)JSON;
        NSArray *searchList=[root objectForKey:@"list"];
        for (NSDictionary *dict in searchList) {
            [array addObject:dict];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
    }];
    return array;
}

+(NSArray*)searchCoursewithWeek:(int)week andWeekday:(int)weekday andCourseTime:(NSString *)coursetime{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSString *path=[[NSString alloc]initWithFormat:@"%@/search?&week=%d&weekday=%d&class=%@",_BaseURLString,week,weekday,coursetime];
    NSURL *url=[NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
    AFJSONRequestOperation *operation= [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *root=(NSDictionary*)JSON;
        NSArray *searchList=[root objectForKey:@"list"];
        for (NSDictionary *dict in searchList) {
            [array addObject:dict];
        }
        NSLog(@"array:%@",[array description]);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
    }];
    [operation start];
    NSLog(@"array:%@",[array description]);
    return array;
}


//this method not use in current version (v0.6)
+(void)deleteFromPlist:(int)index{
    NSMutableDictionary *root=[NSDictionary getData];
    
    NSArray *array=[root objectForKey:@"data"];
    NSMutableArray *newArray=[[NSMutableArray alloc]initWithArray:array copyItems:YES];
    [newArray removeObjectAtIndex:index];
    
    NSMutableDictionary *newRoot=[[NSMutableDictionary alloc]initWithDictionary:root copyItems:YES];
    [newRoot removeObjectForKey:@"data"];
    [newRoot setObject:newArray forKey:@"data"];
    
    [NSDictionary writeData:newRoot];
}

//rename by deleteFromPlistByDictionary
+(void)deleteByDictionary:(NSDictionary *)dictionary{
    NSMutableDictionary *root=[NSDictionary getData];
    NSLog(@"root:%@",[root description]);
    NSArray *array=[root objectForKey:@"data"];
    NSMutableArray *newArray=[[NSMutableArray alloc]initWithArray:array copyItems:YES];
    
    //convert to original data:
    NSMutableDictionary *originDict=[[NSMutableDictionary alloc]initWithDictionary:dictionary];
    [originDict removeObjectForKey:@"combinedclassweek"];
    [originDict removeObjectForKey:@"combinedclassinweek"];
    [newArray removeObject:originDict];
    
    NSMutableDictionary *newRoot=[[NSMutableDictionary alloc]initWithDictionary:root copyItems:YES];
    [newRoot removeObjectForKey:@"data"];
    [newRoot setObject:newArray forKey:@"data"];
    NSLog(@"new root:%@",[newRoot description]);

    [NSDictionary writeData:newRoot];
}

//replace data when new login
+(BOOL)replaceData:(NSData*)data{
    BOOL flag=YES;
    NSString *path=[NSDictionary getPath];
    NSFileManager *manager=[NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        [manager removeItemAtPath:path error:nil];
    }
    if ([manager createFileAtPath:path contents:nil attributes:nil]==YES) {
    }
    if ([data writeToFile:path atomically:YES]==NO) {
        flag=NO;
    }
    return flag;
}

//when user logout
//clean all native file
+(BOOL)deleteData{
    BOOL flag=YES;
    NSString *path=[NSDictionary getPath];
    NSFileManager *manager=[NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        flag= [manager removeItemAtPath:path error:nil];
    }
    NSString *friendPath=[NSDictionary getFriendPath];
    if ([manager fileExistsAtPath:friendPath]) {
        flag=[manager removeItemAtPath:friendPath error:nil];
    }
    NSString *directory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *userInfoPath=[directory stringByAppendingPathComponent:@"UserInfo.plist"];
    if ([manager fileExistsAtPath:userInfoPath]) {
        flag=[manager removeItemAtPath:userInfoPath error:nil];
        if (flag==YES) {
            NSLog(@"remove userinfo.plist success");
        }
    }
    return flag;
}





//follow/friend operation
+(NSArray*)convertFriendData:(NSDictionary*)dictionary{
    //    NSLog(@"course: %@",dictionary);
    NSArray *data= [dictionary objectForKey:@"data"];
    NSMutableArray *array=[[NSMutableArray alloc]initWithArray:data copyItems:YES];
    NSMutableArray *combinedArray=[[NSMutableArray alloc]init];
    
    for (NSDictionary *dict in array) {
        NSString *cname=[dict courseName];
        NSString *classTime=[dict classTime];
        NSUInteger classWeekday=[dict weekday];
        NSString *classWeek=[NSString stringWithFormat:@"%d-%d",[dict startWeek],[dict endWeek]];
        NSMutableArray *compareArray=[[NSMutableArray alloc]initWithArray:combinedArray copyItems:YES];
        for (NSMutableDictionary *combinedDict in combinedArray) {
            NSString *combinedCname=[combinedDict courseName];
            NSString *combinedClassTime=[combinedDict classTime];
            NSUInteger combinedClassWeekday=[combinedDict weekday];
            NSString *combinedClassWeek=[NSString stringWithFormat:@"%d-%d",[combinedDict startWeek],[combinedDict endWeek]];

            if ([cname isEqualToString:combinedCname]&&[classTime isEqualToString:combinedClassTime]&&classWeekday==combinedClassWeekday) {
                NSString *newCombinedWeek=[[combinedClassWeek stringByAppendingString:@","]stringByAppendingString:classWeek];
                [combinedDict setValue:newCombinedWeek forKey:@"combinedclassweek"];
            }
        }
        if ([compareArray isEqualToArray:combinedArray]) {
            NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]initWithDictionary:dict copyItems:YES];
            [tempDict setValue:classWeek forKey:@"combinedclassweek"];
            [combinedArray addObject:tempDict];
            
        }
    }
    NSMutableArray *finalArray=[[NSMutableArray alloc]init];
    //!! if wrong , just in here:
    for (NSDictionary *preDict in combinedArray) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithDictionary:preDict copyItems:YES];
        NSString *weekString=[NSString stringWithFormat:@"星期%d",[dict weekday]];
        NSString *timeString=[NSString stringWithFormat:@"%@,第%@节",weekString,[dict classTime]];
        [dict setObject:timeString forKey:@"combinedclassinweek"];
        
        NSString *cname=[dict courseName];
        NSMutableArray *compareArray=[[NSMutableArray alloc]initWithArray:finalArray copyItems:YES];
        for (NSMutableDictionary *combinedDict in finalArray) {
            NSString *combinedCname=[combinedDict courseName];
            if ([cname isEqualToString:combinedCname]/*&&weekProp==combinedWeekProp*/) {
                NSString *combinedClassInWeek=[combinedDict combinedClassInWeek];
                NSString *newCombinedClassInWeek=[[combinedClassInWeek stringByAppendingString:@"\n"]stringByAppendingString:[dict combinedClassInWeek]];
                [combinedDict setObject:newCombinedClassInWeek forKey:@"combinedclassinweek"];
            }
        }
        if ([compareArray isEqualToArray:finalArray]) {
            [finalArray addObject:dict];
        }
    }
    return finalArray;
}

#pragma mark - get userdata list

+(NSArray*)courseList{
    NSArray *array=[NSDictionary course];
    NSLog(@"old array : %d",[array count]);
    NSLog(@"old array : %@",[array description]);
    NSMutableArray *combinedArray=[[NSMutableArray alloc]init];
    for (NSDictionary *preDict in array) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithDictionary:preDict copyItems:YES];
        NSString *weekString=[NSString stringWithFormat:@"星期%d",[dict weekday]];
        NSString *timeString=[NSString stringWithFormat:@"%@,第%@节",weekString,[dict classTime]];
        [dict setObject:timeString forKey:@"combinedclassinweek"];
        
        NSString *cname=[dict courseName];
//        int weekProp=[dict weekProp];
        NSMutableArray *compareArray=[[NSMutableArray alloc]initWithArray:combinedArray copyItems:YES];
        for (NSMutableDictionary *combinedDict in combinedArray) {
            NSString *combinedCname=[combinedDict courseName];
//            int combinedWeekProp=[combinedDict weekProp];
            if ([cname isEqualToString:combinedCname]/*&&weekProp==combinedWeekProp*/) {
                NSString *combinedClassInWeek=[combinedDict combinedClassInWeek];
                NSString *newCombinedClassInWeek=[[combinedClassInWeek stringByAppendingString:@"\n"]stringByAppendingString:[dict combinedClassInWeek]];
                [combinedDict setObject:newCombinedClassInWeek forKey:@"combinedclassinweek"];
            }
        }
        if ([compareArray isEqualToArray:combinedArray]) {
            [combinedArray addObject:dict];
        }
    }
    return combinedArray;
}

+(NSArray*)followsList{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSString *path=[NSDictionary getFriendPath];
    NSFileManager *manager=[NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        array=nil;
        return array;
    }
    else{       
        NSDictionary *root=[NSDictionary getFriend];
        NSLog(@"friend root:%@",[root description]);
        //some operation for root to array in here
        return [root objectForKey:@"data"];
    }
}

//rename method by deleteFollowFromFile
+(BOOL)deleteFollowFromFile:(NSDictionary*)dictionary{
    NSDictionary *root=[NSDictionary getFriend];
    NSArray *array=[root objectForKey:@"data"];
    NSMutableArray *newArray=[[NSMutableArray alloc]initWithArray:array copyItems:YES];
    [newArray removeObject:dictionary];
    NSMutableDictionary *newRoot=[[NSMutableDictionary alloc]initWithDictionary:root copyItems:YES];
    [newRoot removeObjectForKey:@"data"];
    [newRoot setObject:newArray forKey:@"data"];
    return [NSDictionary writeFriend:newRoot];
}

+(BOOL)addFollowToFile:(NSDictionary*)dictionary{
    NSDictionary *root=[NSDictionary getFriend];
    NSArray *array=[root objectForKey:@"data"];
    NSMutableArray *newArray=[[NSMutableArray alloc]initWithArray:array copyItems:YES];
    [newArray addObject:dictionary];
    NSMutableDictionary *newRoot=[[NSMutableDictionary alloc]initWithDictionary:root copyItems:YES];
    [newRoot removeObjectForKey:@"data"];
    [newRoot setObject:newArray forKey:@"data"];
    return [NSDictionary writeFriend:newRoot];
}

// about date and week

+(NSCalendar*)calendar{
    NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setFirstWeekday:2];
    return calendar;
}

+(NSUInteger)weekdayOfToday{
    return [[Data calendar] ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:[NSDate date]];
}

+(NSUInteger)nowWeekOfTerm{
    NSDateFormatter *weekFormatter=[[NSDateFormatter alloc]init];
    [weekFormatter setDateFormat:@"w"];
    return [[weekFormatter stringFromDate:[NSDate date]]intValue]-8;
}


#pragma mark - user infomation operation

+(void)saveUsername:(NSString*)username{
    NSString *directory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path=[directory stringByAppendingPathComponent:@"UserInfo.plist"];
    NSFileManager *manager=[NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        [manager removeItemAtPath:path error:nil];
    }
    NSDictionary *dictionary=[[NSDictionary alloc]initWithObjectsAndKeys:username,@"username", nil];
    [dictionary writeToFile:path atomically:YES];
}

+(NSString *)getUsername{
    NSString *directory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path=[directory stringByAppendingPathComponent:@"UserInfo.plist"];
    NSDictionary *dictionary=[[NSDictionary alloc]initWithContentsOfFile:path];
    return [dictionary objectForKey:@"username"];
    
}

+(void)savePassword:(NSString*)password{
    NSString *directory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path=[directory stringByAppendingPathComponent:@"UserInfo.plist"];
    NSDictionary *root=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]initWithDictionary:root copyItems:YES];
    NSString *string=[NSString stringWithFormat:@"%@",password];
    [dictionary setObject:string forKey:@"password"];
    [dictionary writeToFile:path atomically:YES];

}

+(NSString*)getPassword{
    NSString *directory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path=[directory stringByAppendingPathComponent:@"UserInfo.plist"];
    NSDictionary *dictionary=[[NSDictionary alloc]initWithContentsOfFile:path];
    return [dictionary objectForKey:@"password"];
}

+(void)saveRemindTime:(int)remindTime{
    NSString *directory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path=[directory stringByAppendingPathComponent:@"UserInfo.plist"];
    NSDictionary *root=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]initWithDictionary:root copyItems:YES];
    NSString *string=[NSString stringWithFormat:@"%d",remindTime];
    [dictionary setObject:string forKey:@"remindtime"];
    [dictionary writeToFile:path atomically:YES];
}

+(int)getRemindTime{
    NSString *directory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path=[directory stringByAppendingPathComponent:@"UserInfo.plist"];
    NSDictionary *dictionary=[[NSDictionary alloc]initWithContentsOfFile:path];
    return [[dictionary objectForKey:@"remindtime"]intValue]==0?10:[[dictionary objectForKey:@"remindtime"]intValue];
}

+(void)saveFullname:(NSString*)fullname{
    NSString *directory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path=[directory stringByAppendingPathComponent:@"UserInfo.plist"];
    NSDictionary *root=[[NSDictionary alloc]initWithContentsOfFile:path];
    NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]initWithDictionary:root copyItems:YES];
    NSString *string=[NSString stringWithFormat:@"%@",fullname];
    [dictionary setObject:string forKey:@"fullname"];
    [dictionary writeToFile:path atomically:YES];
}

+(NSString*)getFullname{
    NSString *directory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path=[directory stringByAppendingPathComponent:@"UserInfo.plist"];
    NSDictionary *dictionary=[[NSDictionary alloc]initWithContentsOfFile:path];
    return [dictionary objectForKey:@"fullname"];
}


@end
