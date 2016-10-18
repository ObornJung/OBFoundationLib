//
//  NSData+OBExtend.m
//  OBFoundationLib
//
//  Created by Oborn.Jung on 8/20/14.
//  Copyright (c) 2014 ObornJung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (OBExtend)

// Relative dates from the current date
+ (NSDate *)ob_dateTomorrow;
+ (NSDate *)ob_dateYesterday;
+ (NSDate *)ob_dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)ob_dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)ob_dateWithHoursFromNow:(NSInteger)hours;
+ (NSDate *)ob_dateWithHoursBeforeNow:(NSInteger)hours;
+ (NSDate *)ob_dateWithMinutesFromNow:(NSInteger)minutes;
+ (NSDate *)ob_dateWithMinutesBeforeNow:(NSInteger)minutes;

// Comparing dates
- (BOOL)ob_isToday;
- (BOOL)ob_isTomorrow;
- (BOOL)ob_isYesterday;
- (BOOL)ob_isThisWeek;
- (BOOL)ob_isNextWeek;
- (BOOL)ob_isLastWeek;
- (BOOL)ob_isThisYear;
- (BOOL)ob_isNextYear;
- (BOOL)ob_isLastYear;
- (BOOL)ob_isSameDayWithDate:(NSDate *)ob_date;
- (BOOL)ob_isSameWeekWithDate:(NSDate *)ob_date;
- (BOOL)ob_isSameMonthWithDate:(NSDate *)aDate;
- (BOOL)ob_isSameYearWithDate:(NSDate *)ob_date;
- (BOOL)ob_isEarlierThanDate:(NSDate *)ob_date;
- (BOOL)ob_isLaterThanDate:(NSDate *)ob_date;

// Adjusting dates
- (NSDate *)ob_dateByAddingDays:(NSInteger)days;
- (NSDate *)ob_dateBySubtractingDays:(NSInteger)days;
- (NSDate *)ob_dateByAddingHours:(NSInteger)hours;
- (NSDate *)ob_dateBySubtractingHours:(NSInteger)hours;
- (NSDate *)ob_dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)ob_dateBySubtractingMinutes:(NSInteger)minutes;
- (NSDate *)ob_dateAtStartOfDay;

// Decomposing dates
@property (readonly) NSInteger ob_nearestHour;
@property (readonly) NSInteger ob_hour;
@property (readonly) NSInteger ob_minute;
@property (readonly) NSInteger ob_seconds;
@property (readonly) NSInteger ob_day;
@property (readonly) NSInteger ob_month;
@property (readonly) NSInteger ob_week;
@property (readonly) NSInteger ob_weekday;
@property (readonly) NSInteger ob_nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger ob_year;

@end
