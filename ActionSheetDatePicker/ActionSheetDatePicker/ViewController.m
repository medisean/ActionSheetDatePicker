//
//  ViewController.m
//  ActionSheetDatePicker
//
//  Created by liangming on 15/3/16.
//  Copyright (c) 2015年 teambition. All rights reserved.
//

#import "ViewController.h"
#import "ActionSheetDatePicker.h"

@interface ViewController ()<ActionSheetDatePickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - ActionSheetDatePickerDelegate

-(void)datePicker:(ActionSheetDatePicker *)datePicker saveDate:(NSDate *)date {
    NSLog(@"save date:%@",date);
}

-(void)datePicker:(ActionSheetDatePicker *)datePicker dismissView:(NSDate *)date {
    NSLog(@"cancel date:%@",date);
}

#pragma mark - show date picker

-(IBAction)showDateView:(id)sender {
    [ActionSheetDatePicker showInViewController:self delegate:self defaultDate:[NSDate date] mode:UIDatePickerModeDateAndTime];
}

-(IBAction)showDateTimeView:(id)sender {
    [ActionSheetDatePicker showInViewController:self delegate:self defaultDate:[NSDate date] mode:UIDatePickerModeDate];
}

-(IBAction)showTimeView:(id)sender {
    [ActionSheetDatePicker showInViewController:self delegate:self defaultDate:[NSDate date] mode:UIDatePickerModeTime];
}

-(IBAction)dismiss:(id)sender {
    [ActionSheetDatePicker dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
