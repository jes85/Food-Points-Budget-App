//
//  main.m
//  Food Points Budget
//
//  Created by Jeremy on 8/26/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FPBBudget.h"
#import "FPBAppDelegate.h"


//static const NSUInteger days = 100;
int main(int argc, char * argv[])
{
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([FPBAppDelegate class]));
        /*
        NSDateComponents *endDateComponents = [[NSDateComponents alloc]init];
        [endDateComponents setDay:14];
        [endDateComponents setMonth:12];
        [endDateComponents setYear:2014];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        NSDate *endDate = [calendar dateFromComponents:endDateComponents];
        
        
        //FPBBudget *budget = [[FPBBudget alloc]initWithStartDate:[NSDate date] endDate:[NSDate dateWithTimeInterval:60*60*24*days sinceDate:[NSDate date]] foodPoints:2000];
        
        FPBBudget *budget = [[FPBBudget alloc]initWithStartDate:[NSDate date] endDate:endDate foodPoints:2000];
        
        [budget mainCalculations];
        return 0;*/
    }
}
