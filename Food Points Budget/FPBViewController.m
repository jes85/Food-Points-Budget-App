//
//  FPBViewController.m
//  Food Points Budget
//
//  Created by Jeremy on 8/26/14.
//  Copyright (c) 2014 Jeremy. All rights reserved.
//

#import "FPBViewController.h"
#import "FPBBudget.h"

//add something to find out which semester they're in
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
    [self.totalFoodPointsTextField becomeFirstResponder];
    self.totalFoodPointsTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)calculateAvgFoodPointsPerDay
{
    if([self.totalFoodPointsTextField isFirstResponder]) [self.totalFoodPointsTextField resignFirstResponder]; //dismiss keyboard
    
    NSNumber *num = (NSNumber *)self.totalFoodPointsTextField.text;
    float totalFoodPoints = [num floatValue];
    
    NSDateComponents *endDateComponents = [[NSDateComponents alloc]init];
    [endDateComponents setDay:endDay];
    [endDateComponents setMonth:endMonth];
    [endDateComponents setYear:endYear];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *endDate = [calendar dateFromComponents:endDateComponents];
    
    
    // Calculations
    FPBBudget *budget = [[FPBBudget alloc]initWithStartDate:[NSDate date] endDate:endDate foodPoints:totalFoodPoints];
    float avgFoodPointsPerDay = [budget mainCalculations];
    
    // Convert Number to Label
    NSString *avgFoodPointsText = [NSString stringWithFormat:@"%.2f", avgFoodPointsPerDay];
    NSString *dollarSign = @"$";
    NSString *resultLabel = [dollarSign stringByAppendingString:avgFoodPointsText];
    self.avgFoodPointsPerDayLabel.text = resultLabel;

}
-(void)calculateSemester
{
    
}- (IBAction)backgroundTouched:(id)sender {
    if([self.totalFoodPointsTextField isFirstResponder]) [self.totalFoodPointsTextField resignFirstResponder];
}

@end
