//
//  FPBViewController.m
//  Food Points Budget
//
//  Created by Jeremy on 8/26/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "FPBViewController.h"
#import "FPBBudget.h"
#import "FPBSemester.h"

// Fall 2014
static const NSUInteger endMonthF14 = 12;
static const NSUInteger endDayF14 = 14;
static const NSUInteger endYearF14 = 2014;
static const NSUInteger numDaysNotInSchoolF14 = 9;

// Spring 2015
static const NSUInteger endMonthS15 = 5;
static const NSUInteger endDayS15 = 2;
static const NSUInteger endYearS15 = 2015;
static const NSUInteger numDaysNotInSchoolS15 =9;



@interface FPBViewController ()

@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UITextField *totalFoodPointsTextField;
@property (weak, nonatomic) IBOutlet UILabel *avgFoodPointsPerDayLabel;
@property (nonatomic) NSMutableArray *semesters;

@end

@implementation FPBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.totalFoodPointsTextField becomeFirstResponder];
    self.totalFoodPointsTextField.delegate = self;
    
    NSArray *daysMissingF14 = [self daysMissingF14];
    NSArray *daysMissingS15 = [self daysMissingS15];
    
    
    
  /*  FPBSemester *fall2014 = [[FPBSemester alloc]initWithName:@"fall2014" endMonth:endMonthF14 endDay:endDayF14 endYear:endYearF14 numDaysNotInSchool:numDaysNotInSchoolF14];
    FPBSemester *spring2015 = [[FPBSemester alloc]initWithName:@"spring2015" endMonth:endMonthS15 endDay:endDayS15 endYear:endYearS15 numDaysNotInSchool:numDaysNotInSchoolS15];*/
    FPBSemester *fall2014 = [[FPBSemester alloc]initWithName:@"fall2014" endMonth:endMonthF14 endDay:endDayF14 endYear:endYearF14 daysNotInSchool:daysMissingF14];
    FPBSemester *spring2015 = [[FPBSemester alloc]initWithName:@"spring2015" endMonth:endMonthS15 endDay:endDayS15 endYear:endYearS15 daysNotInSchool:daysMissingS15];
    

    [self.semesters addObject:fall2014];
    [self.semesters addObject:spring2015];
    
}

-(NSArray *)daysMissingF14
{
    NSMutableArray *daysMissingArray = [[NSMutableArray alloc]init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];

    NSUInteger october = 10;
    NSUInteger november = 11;
    NSUInteger year = 2014;
    
    for (int i = 11; i<15; i++){
        [dateComponents setDay:i];
        [dateComponents setMonth:october];
        [dateComponents setYear:year];
        NSDate *dayMissing = [calendar dateFromComponents:dateComponents];
        [daysMissingArray addObject:dayMissing];
        
    }
    for (int i = 26; i<31; i++){
        [dateComponents setDay:i];
        [dateComponents setMonth:november];
        [dateComponents setYear:year];
        NSDate *dayMissing = [calendar dateFromComponents:dateComponents];
        [daysMissingArray addObject:dayMissing];
        
    }
   
    
    return daysMissingArray;
    
    
}
-(NSArray *)daysMissingS15
{
    NSMutableArray *daysMissingArray = [[NSMutableArray alloc]init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    
    NSUInteger march = 3;
    NSUInteger year = 2015;
    
    for (int i = 7; i<16; i++){
        [dateComponents setDay:i];
        [dateComponents setMonth:march];
        [dateComponents setYear:year];
        NSDate *dayMissing = [calendar dateFromComponents:dateComponents];
        [daysMissingArray addObject:dayMissing];
        
    }
   
    
    
    return daysMissingArray;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)semesters
{
    if(!_semesters)_semesters = [[NSMutableArray alloc]init];
    return _semesters;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self calculateAvgFoodPointsPerDay];
    
    return NO;
}
- (IBAction)calculateButtonPressed:(id)sender {
    [self calculateAvgFoodPointsPerDay];
  
}

- (IBAction)backgroundTouched:(id)sender {
    if([self.totalFoodPointsTextField isFirstResponder]) [self.totalFoodPointsTextField resignFirstResponder];
}
- (void)calculateAvgFoodPointsPerDay
{
    if([self.totalFoodPointsTextField isFirstResponder]) [self.totalFoodPointsTextField resignFirstResponder]; //dismiss keyboard
    
    NSNumber *num = (NSNumber *)self.totalFoodPointsTextField.text;
    float totalFoodPoints = [num floatValue];
    
    
    NSDate *startDate = [NSDate date]; //maybe add something to make sure current date is during the semester (make sure it's not summer/winter break)
    
    // Testing with generated start date
    //NSDate *startDate = [self setStartDate];
    
    
    NSDate *endDate;
    NSUInteger numDaysNotInSchool=0;
    
    
    
    // Set appropriate endDate based on what the semester is currently
    for(FPBSemester *semester in self.semesters){
        endDate = [semester calculateEndDate];
        if([startDate compare:endDate] < 0){
            numDaysNotInSchool = [semester calculateDaysNotInSchool];
            break;
        }
    }
    
#warning - might want to alert user if endDate is null, meaning the current date is past the last updated semester (app is not updated). Also might want to tell user what semester the app thinks it is
    
    // Calculations
    FPBBudget *budget = [[FPBBudget alloc]initWithStartDate:[NSDate date] endDate:endDate foodPoints:totalFoodPoints numDaysNotInSchool:numDaysNotInSchool];
    float avgFoodPointsPerDay = [budget mainCalculations];
    
    
    // Convert Number to Label
    NSString *avgFoodPointsText = [NSString stringWithFormat:@"%.2f", avgFoodPointsPerDay];
    NSString *dollarSign = @"$";
    NSString *resultLabel = [dollarSign stringByAppendingString:avgFoodPointsText];
    self.avgFoodPointsPerDayLabel.text = resultLabel;
    
}

/*
 * Method for testing purposes only. Can change the start date with this method
 */
-(NSDate *)setStartDate
{
    NSDateComponents *endDateComponents = [[NSDateComponents alloc]init];
    [endDateComponents setMonth:1];
    [endDateComponents setDay:7];
    [endDateComponents setYear:2015];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *endDate = [calendar dateFromComponents:endDateComponents];
    
    return endDate;
}



@end
