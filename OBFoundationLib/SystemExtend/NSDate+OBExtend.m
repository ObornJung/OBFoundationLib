//
//  NSData+BDUtils.m
//  OBFoundationLib
//
//  Created by Oborn.Jung on 8/20/14.
//  Copyright (c) 2014 ObornJung. All rights reserved.
//

#import "NSDate+OBExtend.h"

#define kOBDateFormatStr @"yyyy-MM-dd HH:mm:ss.SSS"

static const NSUInteger kSecondsPerMinutes = 60;
static const NSUInteger kSecondsPerHour = 3600;
static const NSUInteger kSecondsPerDay = 86400;
static const NSUInteger kSecondsPerWeek = 604800;
//static const NSUInteger kSecondsPerYear = 31556926;
static const NSUInteger kDateComponents = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

@implementation NSDate (OBExtend)

+ (NSDate *)dateTomorrow
{
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *)dateYesterday
{
    return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *)dateWithDaysFromNow:(NSInteger)days
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] + kSecondsPerDay * days;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] - kSecondsPerDay * days;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

+ (NSDate *)dateWithHoursFromNow:(NSInteger)hours
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] + kSecondsPerHour * hours;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)hours
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] - kSecondsPerHour * hours;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

+ (NSDate *)dateWithMinutesFromNow:(NSInteger)minutes
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] + kSecondsPerMinutes * minutes;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)minutes
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] - kSecondsPerMinutes * minutes;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

- (BOOL)isToday
{
    return [self isSameDayWithDate:[NSDate date]];
}

- (BOOL)isTomorrow
{
    return [self isSameDayWithDate:[NSDate dateTomorrow]];
}

- (BOOL)isYesterday
{
    return [self isSameDayWithDate:[NSDate dateYesterday]];
}

- (BOOL)isThisWeek
{
    return [self isSameWeekWithDate:[NSDate date]];
}

- (BOOL)isNextWeek
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] + kSecondsPerWeek;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
    return [self isSameWeekWithDate:date];
}

- (BOOL)isLastWeek
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] - kSecondsPerWeek;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
    return [self isSameWeekWithDate:date];
}

- (BOOL)isThisYear
{
    return [self isSameYearWithDate:[NSDate date]];
}

- (BOOL)isNextYear
{
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    return ([components1 year] == ([components2 year] + 1));
}

- (BOOL)isLastYear
{
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    return ([components1 year] == ([components2 year] - 1));
}

- (BOOL)isSameDayWithDate:(NSDate *)date
{
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:kDateComponents fromDate:date];
    return (([components1 year] == [components2 year]) &&
            ([components1 month] == [components2 month]) &&
            ([components1 day] == [components2 day]));
}

- (BOOL)isSameWeekWithDate:(NSDate *)date
{
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:kDateComponents fromDate:date];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if ([components1 weekOfYear] != [components2 weekOfYear])
    {
        return NO;
    }
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:date]) < kSecondsPerWeek);
}

- (BOOL)isSameMonthWithDate:(NSDate *)aDate
{
    if ([self isSameYearWithDate:aDate] == NO)
    {
        return NO;
    }
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:aDate];
    return ([components1 month] == [components2 month]);
}

- (BOOL)isSameYearWithDate:(NSDate *)date
{
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:date];
    return ([components1 year] == [components2 year]);
}

- (BOOL)isEarlierThanDate:(NSDate *)date
{
    return ([self earlierDate:date] == self);
}

- (BOOL)isLaterThanDate:(NSDate *)date
{
    return ([self laterDate:date] == self);
}




- (NSDate *)dateByAddingDays:(NSInteger)days
{
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate] + kSecondsPerDay * days;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

- (NSDate *)dateBySubtractingDays:(NSInteger)days
{
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate] - kSecondsPerDay * days;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours
{
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate] + kSecondsPerHour * hours;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

- (NSDate *)dateBySubtractingHours:(NSInteger)hours
{
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate] - kSecondsPerHour * hours;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes
{
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate] + kSecondsPerMinutes * minutes;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

- (NSDate *)dateBySubtractingMinutes:(NSInteger)minutes
{
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate] - kSecondsPerMinutes * minutes;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

- (NSDate *)dateAtStartOfDay
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}




- (NSInteger)nearestHour
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] + kSecondsPerHour * 0.5;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:date];
    return [components hour];
}

- (NSInteger)hour
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components hour];
}

- (NSInteger)minute
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components minute];
}

- (NSInteger)seconds
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components second];
}

- (NSInteger)day
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components day];
}

- (NSInteger)month
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components month];
}

- (NSInteger)week
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components weekOfYear];
}

- (NSInteger)weekday
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components weekday];
}

- (NSInteger)nthWeekday
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components weekdayOrdinal];
}

- (NSInteger)year
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components year];
}

- (NSString *)description
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:kOBDateFormatStr];
    return [dateFormatter stringFromDate:self];
}

@end