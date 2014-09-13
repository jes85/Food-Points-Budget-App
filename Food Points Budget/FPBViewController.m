//
//  FPBViewController.m
//  Food Points Budget
//
//  Created by Jeremy on 8/26/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "FPBViewController.h"
#import "FPBBudget.h"

//static const NSUInteger days = 100;
static const NSUInteger endMonth = 12;
static const NSUInteger endDay = 14;
static const NSUInteger endYear = 2014;

@interface FPBViewController ()
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UITextField *totalFoodPointsTextField;
@property (weak, nonatomic) IBOutlet UILabel *avgFoodPointsPerDayLabel;


@end

@implementation FPBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)calculateButtonPressed:(id)sender {
    NSNumber *num = (NSNumber *)self.totalFoodPointsTextField.text;
    float totalFoodPoints = [num floatValue];
    
    NSDateComponents *endDateComponents = [[NSDateComponents alloc]init];
    [endDateComponents setDay:endDay];
    [endDateComponents setMonth:endMonth];
    [endDateComponents setYear:endYear];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *endDate = [calendar dateFromComponents:endDateComponents];
    
    
    //FPBBudget *budget = [[FPBBudget alloc]initWithStartDate:[NSDate date] endDate:[NSDate dateWithTimeInterval:60*60*24*days sinceDate:[NSDate date]] foodPoints:2000];
    
    FPBBudget *budget = [[FPBBudget alloc]initWithStartDate:[NSDate date] endDate:endDate foodPoints:totalFoodPoints];
    float avgFoodPointsPerDay = [budget mainCalculations];
    NSString *avgFoodPointsText = [NSString stringWithFormat:@"%.2f", avgFoodPointsPerDay];
    self.avgFoodPointsPerDayLabel.text = avgFoodPointsText;

}


@end
