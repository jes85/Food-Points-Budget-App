//
//  FPBBudget.m
//  Food Points Budget
//
//  Created by Jeremy on 8/26/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "FPBBudget.h"


//wedding: 3
//fall break: 4
//thanksgiving: 5
static const NSUInteger numDaysNotInSchool = 9;
static const NSUInteger jeremyNumDaysNotInSchool = 12;


@interface FPBBudget()

@property (nonatomic) NSDate *startDate;
@property (nonatomic) NSDate *endDate;
@property (nonatomic) float totalFoodPoints;

@end


@implementation FPBBudget




-(instancetype)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate foodPoints:(float)foodPoints
{
    self = [super init];
    if(self){
        self.startDate = startDate;
        self.endDate = endDate;
        self.totalFoodPoints = foodPoints;
    }
    return self;
}
-(NSUInteger)calculateDaysLeft
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:self.startDate];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:self.endDate];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    NSUInteger daysLeft = [difference day]  - numDaysNotInSchool;
    //NSLog(@"Days Left: %ld",(unsigned long)daysLeft);
    
    return daysLeft;
}

-(float)foodPointsPerDayForNumDaysLeft:(NSUInteger)numDays totalFoodPointsLeft:(float)foodPointsLeft
{
    return foodPointsLeft / numDays;
}

-(float)mainCalculations
{
    NSUInteger numDaysLeft = [self calculateDaysLeft];
    float avgFoodPointsPerDay = [self foodPointsPerDayForNumDaysLeft:numDaysLeft totalFoodPointsLeft:self.totalFoodPoints];
    //NSLog(@"Avg food points per day: %f", avgFoodPointsPerDay);
    
    return avgFoodPointsPerDay;
}

@end
