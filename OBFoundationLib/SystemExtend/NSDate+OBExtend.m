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

+ (NSDate *)ob_dateTomorrow {
    return [NSDate ob_dateWithDaysFromNow:1];
}

+ (NSDate *)ob_dateYesterday {
    return [NSDate ob_dateWithDaysBeforeNow:1];
}

+ (NSDate *)ob_dateWithDaysFromNow:(NSInteger)days {
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] + kSecondsPerDay * days;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

+ (NSDate *)ob_dateWithDaysBeforeNow:(NSInteger)days {
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] - kSecondsPerDay * days;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

+ (NSDate *)ob_dateWithHoursFromNow:(NSInteger)hours {
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] + kSecondsPerHour * hours;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

+ (NSDate *)ob_dateWithHoursBeforeNow:(NSInteger)hours {
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] - kSecondsPerHour * hours;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

+ (NSDate *)ob_dateWithMinutesFromNow:(NSInteger)minutes {
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] + kSecondsPerMinutes * minutes;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

+ (NSDate *)ob_dateWithMinutesBeforeNow:(NSInteger)minutes {
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] - kSecondsPerMinutes * minutes;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

- (BOOL)ob_isToday {
    return [self ob_isSameDayWithDate:[NSDate date]];
}

- (BOOL)ob_isTomorrow {
    return [self ob_isSameDayWithDate:[NSDate ob_dateTomorrow]];
}

- (BOOL)ob_isYesterday {
    return [self ob_isSameDayWithDate:[NSDate ob_dateYesterday]];
}

- (BOOL)ob_isThisWeek {
    return [self ob_isSameWeekWithDate:[NSDate date]];
}

- (BOOL)ob_isNextWeek {
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] + kSecondsPerWeek;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
    return [self ob_isSameWeekWithDate:date];
}

- (BOOL)ob_isLastWeek {
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] - kSecondsPerWeek;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
    return [self ob_isSameWeekWithDate:date];
}

- (BOOL)ob_isThisYear {
    return [self ob_isSameYearWithDate:[NSDate date]];
}

- (BOOL)ob_isNextYear {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    return ([components1 year] == ([components2 year] + 1));
}

- (BOOL)ob_isLastYear {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    return ([components1 year] == ([components2 year] - 1));
}

- (BOOL)ob_isSameDayWithDate:(NSDate *)date {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:kDateComponents fromDate:date];
    return (([components1 year] == [components2 year]) &&
            ([components1 month] == [components2 month]) &&
            ([components1 day] == [components2 day]));
}

- (BOOL)ob_isSameWeekWithDate:(NSDate *)date {
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

- (BOOL)ob_isSameMonthWithDate:(NSDate *)aDate {
    if ([self ob_isSameYearWithDate:aDate] == NO)
    {
        return NO;
    }
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:aDate];
    return ([components1 month] == [components2 month]);
}

- (BOOL)ob_isSameYearWithDate:(NSDate *)date {
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:date];
    return ([components1 year] == [components2 year]);
}

- (BOOL)ob_isEarlierThanDate:(NSDate *)date {
    return ([self earlierDate:date] == self);
}

- (BOOL)ob_isLaterThanDate:(NSDate *)date {
    return ([self laterDate:date] == self);
}


- (NSDate *)ob_dateByAddingDays:(NSInteger)days {
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate] + kSecondsPerDay * days;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

- (NSDate *)ob_dateBySubtractingDays:(NSInteger)days {
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate] - kSecondsPerDay * days;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

- (NSDate *)ob_dateByAddingHours:(NSInteger)hours {
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate] + kSecondsPerHour * hours;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

- (NSDate *)ob_dateBySubtractingHours:(NSInteger)hours {
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate] - kSecondsPerHour * hours;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

- (NSDate *)ob_dateByAddingMinutes:(NSInteger)minutes {
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate] + kSecondsPerMinutes * minutes;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

- (NSDate *)ob_dateBySubtractingMinutes:(NSInteger)minutes {
    NSTimeInterval interval = [self timeIntervalSinceReferenceDate] - kSecondsPerMinutes * minutes;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
}

- (NSDate *)ob_dateAtStartOfDay {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}




- (NSInteger)ob_nearestHour {
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceReferenceDate] + kSecondsPerHour * 0.5;
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:date];
    return [components hour];
}

- (NSInteger)ob_hour {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components hour];
}

- (NSInteger)ob_minute {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components minute];
}

- (NSInteger)ob_seconds {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components second];
}

- (NSInteger)ob_day {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components day];
}

- (NSInteger)ob_month {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components month];
}

- (NSInteger)ob_week {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components weekOfYear];
}

- (NSInteger)ob_weekday {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components weekday];
}

- (NSInteger)ob_nthWeekday {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components weekdayOrdinal];
}

- (NSInteger)ob_year {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kDateComponents fromDate:self];
    return [components year];
}

- (NSString *)description {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:kOBDateFormatStr];
    return [dateFormatter stringFromDate:self];
}

@end
