//
//  FPBBudget.h
//  Food Points Budget
//
//  Created by Jeremy on 8/26/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPBBudget : NSObject


-(instancetype)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate foodPoints:(float)foodPoints;
-(float)mainCalculations;
@end
