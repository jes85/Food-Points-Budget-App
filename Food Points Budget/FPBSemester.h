//
//  FPBSemester.h
//  Food Points Budget
//
//  Created by Jeremy on 10/6/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPBSemester : NSObject

@property (nonatomic) NSString *name;

@property (nonatomic) NSUInteger endMonth;
@property (nonatomic) NSUInteger endDay;
@property (nonatomic) NSUInteger endYear;

@property (nonatomic) NSArray *daysNotInSchool;
@property (nonatomic) NSUInteger numDaysNotInSchool;

-(instancetype)initWithName:(NSString *)name endMonth:(NSUInteger)endMonth endDay: (NSUInteger)endDay endYear:(NSUInteger)endYear daysNotInSchool:(NSArray *)days;
-(NSDate *)calculateEndDate;
-(NSUInteger)calculateDaysNotInSchool;

@end
