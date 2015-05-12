//
//  NSDate+Calc.m
//  PhotoSelector
//
//  Created by TouchROI on 11/22/14.
//  Copyright (c) 2014 tim.obrien. All rights reserved.
//

#import "NSDate+Calc.h"

@implementation NSDate (Calc)


+(NSDate*) newDate:(int) year Month:(int) month
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents* dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year  = year;
    dateComponents.month = month;
    dateComponents.hour = 0;
    dateComponents.minute = 0;
    dateComponents.second = 0;
    
    return [calendar dateFromComponents:dateComponents];
    
}


+(NSDate*)lastDayOfMonth:(int) year Month:(int) month
{
    NSDate*  date = [NSDate newDate:year Month:month];
   return [NSDate lastDayOfMonthDate:date];
    
}

+(NSDate*)firstDayOfMonth:(int) year Month:(int) month
{
    
    NSDate*  date = [NSDate newDate:year Month:month];
    return  date;
    
}


+(NSDate*)lastDayOfMonthDate:(NSDate*) date;
{
    NSInteger dayCount = [self numberOfDaysInMonthCount:date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    NSDateComponents *comp = [calendar components:
                              NSCalendarUnitYear|
                              NSCalendarUnitMonth |
                              NSCalendarUnitDay fromDate:date];
    
    [comp setDay:dayCount];
    [comp setHour:23];
    [comp setMinute:59];
    [comp setSecond:59];
    
    return [calendar dateFromComponents:comp];
}

+(NSInteger)numberOfDaysInMonthCount:(NSDate*) date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    NSRange dayRange = [calendar rangeOfUnit:NSCalendarUnitDay
                                      inUnit:NSCalendarUnitMonth
                                     forDate:date];
    
    return dayRange.length;
}

@end
