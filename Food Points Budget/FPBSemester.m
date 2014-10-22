//
//  FPBSemester.m
//  Food Points Budget
//
//  Created by Jeremy on 10/6/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "FPBSemester.h"

@implementation FPBSemester

-(instancetype)initWithName:(NSString *)name endMonth:(NSUInteger)endMonth endDay: (NSUInteger)endDay endYear:(NSUInteger)endYear numDaysNotInSchool:(NSUInteger)numDays
{
    self = [super init];
    if (self){
        self.name = name;
        self.endMonth = endMonth;
        self.endDay = endDay;
        self.endYear = endYear;
        self.numDaysNotInSchool = numDays;
    }
    return self;
}
-(instancetype)initWithName:(NSString *)name endMonth:(NSUInteger)endMonth endDay: (NSUInteger)endDay endYear:(NSUInteger)endYear daysNotInSchool:(NSArray *)days
{
    self = [super init];
    if (self){
        self.name = name;
        self.endMonth = endMonth;
        self.endDay = endDay;
        self.endYear = endYear;
        self.daysNotInSchool = days;
    }
    return self;
}
-(NSDate *)calculateEndDate
{
    NSDateComponents *endDateComponents = [[NSDateComponents alloc]init];
    [endDateComponents setDay:self.endDay];
    [endDateComponents setMonth:self.endMonth];
    [endDateComponents setYear:self.endYear];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *endDate = [calendar dateFromComponents:endDateComponents];
    return endDate;
}
-(NSUInteger)calculateDaysNotInSchool
{
    NSUInteger numDays = 0;
    NSDate *today = [NSDate date];
    NSDate *startOfToday;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //Inititialize startOfToday
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&startOfToday
                 interval:NULL forDate:today];

    for(NSDate *day in self.daysNotInSchool){
        if([startOfToday compare:day] <= 0){ //if today is a day off (=0), include today in numDaysNotInSchool
            numDays++;
        }
    }
    
    return numDays;
}
@end
