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
+ (NSDate *)dateTomorrow;
+ (NSDate *)dateYesterday;
+ (NSDate *)dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)dateWithHoursFromNow:(NSInteger)hours;
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)hours;
+ (NSDate *)dateWithMinutesFromNow:(NSInteger)minutes;
+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)minutes;

// Comparing dates
- (BOOL)isToday;
- (BOOL)isTomorrow;
- (BOOL)isYesterday;
- (BOOL)isThisWeek;
- (BOOL)isNextWeek;
- (BOOL)isLastWeek;
- (BOOL)isThisYear;
- (BOOL)isNextYear;
- (BOOL)isLastYear;
- (BOOL)isSameDayWithDate:(NSDate *)date;
- (BOOL)isSameWeekWithDate:(NSDate *)date;
- (BOOL)isSameMonthWithDate:(NSDate *)aDate;
- (BOOL)isSameYearWithDate:(NSDate *)date;
- (BOOL)isEarlierThanDate:(NSDate *)date;
- (BOOL)isLaterThanDate:(NSDate *)date;

// Adjusting dates
- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateBySubtractingDays:(NSInteger)days;
- (NSDate *)dateByAddingHours:(NSInteger)hours;
- (NSDate *)dateBySubtractingHours:(NSInteger)hours;
- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)dateBySubtractingMinutes:(NSInteger)minutes;
- (NSDate *)dateAtStartOfDay;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

@end
