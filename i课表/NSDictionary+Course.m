//
//  NSDictionary+Course.m
//  CurriSchedule
//
//  Created by piner on 5/11/13.
//  Copyright (c) 2013 Piner. All rights reserved.
//

#import "NSDictionary+Course.h"

@implementation NSDictionary(Course)

+(NSMutableDictionary*)getData{
    
    NSString *path=[NSDictionary getPath];
//    NSData *data=[NSData dataWithContentsOfFile:path];
//    NSMutableDictionary *root=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSMutableDictionary *root=[NSMutableDictionary dictionaryWithContentsOfFile:path];
    return root;
}

+(void)writeData:(NSDictionary*)root{
    NSString *path=[NSDictionary getPath];
    NSData *data=[NSJSONSerialization dataWithJSONObject:root options:kNilOptions error:nil];
    [data writeToFile:path atomically:YES];
}

+(NSString*)getPath{
    NSString *directory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    return [directory stringByAppendingPathComponent:@"Data.dat"];
    NSString *path = [directory stringByAppendingPathComponent:@"Data.plist"];
    NSFileManager *fileManager=[[NSFileManager alloc]init];
    if (![fileManager fileExistsAtPath:path]) {
        NSString *rootPath=[[NSBundle mainBundle]pathForResource:@"Data" ofType:@"plist"];
        NSDictionary *root=[NSDictionary dictionaryWithContentsOfFile:rootPath];
        [root writeToFile:path atomically:YES];
        return path;
    }
}

+(NSString*)getFriendPath{
    NSString *directory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [directory stringByAppendingPathComponent:@"Friend.dat"];
}

+(BOOL)writeFriend:(NSDictionary*)root{
    NSString *path=[NSDictionary getFriendPath];
    NSData *data=[NSJSONSerialization dataWithJSONObject:root options:kNilOptions error:nil];
    return [data writeToFile:path atomically:YES];
}

+(NSMutableDictionary*)getFriend{
    NSString *path=[NSDictionary getFriendPath];
    NSData *data=[NSData dataWithContentsOfFile:path];
    NSMutableDictionary *root=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return root;
}

//this method ... not use but need use
+(NSArray*)follows{
    
}

+(NSArray*)course{
    NSDictionary *dictionary=[NSDictionary getData];
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
    return combinedArray;
}

-(NSString*)courseName{
    return [self objectForKey:@"cname"];
}
-(NSString*)studentName{
    return [self objectForKey:@"sname"];
}
-(NSString*)teacherName{
    return [self objectForKey:@"tname"];
}
-(int)isOwn{
    if ([[self objectForKey:@"own"]intValue]==0) {
        return 0;
    }
    else{
        return 1;
    }
}
-(NSString*)tcdno{
    return [self objectForKey:@"tcdno"];
}
-(NSString*)classNo{
    return [self objectForKey:@"classno"];
}
-(NSUInteger)startWeek{
    return [[self objectForKey:@"tcdstartweek"]intValue];
}
-(NSUInteger)endWeek{
    return [[self objectForKey:@"tcdendweek"]intValue];
}
-(NSUInteger)weekday{
    return [[self objectForKey:@"tcdweekday"]intValue];
}
-(NSUInteger)classSerial{
    return [[self objectForKey:@"tcdclassserial"]intValue];
}
-(NSString*)classTime{
    return [self objectForKey:@"tcdclass"];
}
-(NSString*)classRoom{
    return [self objectForKey:@"tcdroom"];
}
-(NSUInteger)weekProp{
    return [[self objectForKey:@"tcdweekprop"]intValue];
}
-(NSString*)classDescription{
    if ([[self objectForKey:@"tcddescription"]isEqual:[NSNull null]]) {
        return @"无";
    }
    else{
        return [self objectForKey:@"tcddescription"];
    }
}
-(NSString*)combinedClassWeek{
    return [self objectForKey:@"combinedclassweek"];
}
-(NSString*)combinedClassInWeek{
    return [self objectForKey:@"combinedclassinweek"];
}



-(NSString*)friendName{
    return [self objectForKey:@"followedName"];
}
-(NSString*)friendId{
    return [self objectForKey:@"followedId"];
}
-(NSString*)friendSex{
    if ([[self objectForKey:@"followedSex"]intValue]==1) {
        return @"男";
    }
    else{
        return @"女";
    }
    
}
-(NSString*)friendDescription{
    return  [self objectForKey:@"fdescription"];
    
}

-(NSString*)fno{
    return [self objectForKey:@"fno"];
}
-(NSString*)friendPassword{
    return [self objectForKey:@"followedPassword"];
}


@end
