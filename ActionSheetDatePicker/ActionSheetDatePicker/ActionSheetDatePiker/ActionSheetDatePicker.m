//
//  ActionSheetDatePicker.m
//  ActionSheetDatePicker
//
//  Created by liangming on 15/3/16.
//  Copyright (c) 2015年 teambition. All rights reserved.
//

#import "ActionSheetDatePicker.h"

#define kActionSheetShowTime 0.3
#define kActionSheetButtonColor [UIColor colorWithRed:3.f/255.f green:169.f/255.f blue:244.f/255.f alpha:1]
#define kActionSheetTopViewBgColor [UIColor colorWithRed:245.f/255.f green:245.f/255.f blue:245.f/255.f alpha:1.0]
#define kActionSheetLineColor [UIColor colorWithRed:201.f/255.f green:201.f/255.f blue:201.f/255.f alpha:1.0]

@implementation ActionSheetDatePicker

static ActionSheetDatePicker *singleActionSheet;
@synthesize datePicker;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self initTopView];
        [self initDatePicker];
        [self initButtonCancel];
        [self initButtonSave];
        [self initLine];
        
        [topToolView addSubview:buttonCancel];
        [topToolView addSubview:buttonSave];
        [topToolView addSubview:viewTopLine];
        [topToolView addSubview:viewBottomLine];
        [self addSubview:topToolView];
    }
    return self;
}

-(void)initTopView {
    topToolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-216-44, self.frame.size.width, 44)];
    topToolView.backgroundColor = kActionSheetTopViewBgColor;
}

-(void)initDatePicker {
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.frame.size.height-216, self.frame.size.width, 216)];
    datePicker.backgroundColor = [UIColor whiteColor];
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:currentLanguage];
    [self addSubview:datePicker];
}

-(void)initButtonCancel {
    buttonCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 44)];
    [buttonCancel setTitle:NSLocalizedString(@"Cancel", @"Cancel") forState:UIControlStateNormal];
    [buttonCancel setTitleColor:kActionSheetButtonColor forState:UIControlStateNormal];
    [buttonCancel addTarget:self action:@selector(onCancelClick) forControlEvents:UIControlEventTouchUpInside];
    buttonCancel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    buttonCancel.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}

-(void)initButtonSave {
    buttonSave = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-60, 0, 60, 44)];
    [buttonSave setTitle:NSLocalizedString(@"Save", @"Save") forState:UIControlStateNormal];
    [buttonSave setTitleColor:kActionSheetButtonColor forState:UIControlStateNormal];
    [buttonSave addTarget:self action:@selector(onSaveClick) forControlEvents:UIControlEventTouchUpInside];
    buttonSave.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    buttonSave.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
}

-(void)initLine {
    viewTopLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    viewBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, self.frame.size.width, 0.5)];
    viewTopLine.backgroundColor = kActionSheetLineColor;
    viewBottomLine.backgroundColor = kActionSheetLineColor;
}

- (id)initWithFrame:(CGRect)frame andView:(UIView *)view{
    self = [self initWithFrame:CGRectMake(0, view.frame.size.height, frame.size.width, 216+44)];
    [view addSubview:self];
    return self;
}

-(void)showInViewController:(UIViewController *)vc andDate:(NSDate *)date andMode:(UIDatePickerMode)mode{
    parentVC=vc;
    if (date) {
        [datePicker setDate:date animated:NO];
    }
    datePicker.datePickerMode = mode;
    
    [UIView animateWithDuration:kActionSheetShowTime delay:0 options:7<<16 animations:^{
        self.frame = CGRectMake(0, vc.view.frame.size.height-216-44, vc.view.frame.size.width, 44+216);
        self.isShow = YES;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - show view and dismiss view 

+(void)showInViewController:(UIViewController *)vc delegate:(id)delegate defaultDate:(NSDate *)date mode:(UIDatePickerMode)mode {
    
    if (singleActionSheet) {
        if (singleActionSheet.isShow) {
            singleActionSheet.datePicker.datePickerMode = mode;
            [singleActionSheet.datePicker setDate:date animated:YES];
        } else {
            singleActionSheet = [[ActionSheetDatePicker alloc] initWithFrame:vc.view.frame andView:vc.view];
            [singleActionSheet showInViewController:vc andDate:date andMode:mode];
        }
    } else {
        singleActionSheet = [[ActionSheetDatePicker alloc] initWithFrame:vc.view.frame andView:vc.view];
        [singleActionSheet showInViewController:vc andDate:date andMode:mode];
    }
    singleActionSheet.delegate = delegate;
}

+(void)showInViewController:(UIViewController *)vc delegate:(id)delegate {
    NSDate *currentDate = [NSDate date];
    if (singleActionSheet) {
        if (singleActionSheet.isShow) {
            [singleActionSheet.datePicker setDate:currentDate animated:YES];
        } else {
            singleActionSheet = [[ActionSheetDatePicker alloc] initWithFrame:vc.view.frame andView:vc.view];
            [singleActionSheet showInViewController:vc andDate:currentDate andMode:UIDatePickerModeDateAndTime];
        }
    } else {
        singleActionSheet = [[ActionSheetDatePicker alloc] initWithFrame:vc.view.frame andView:vc.view];
        [singleActionSheet showInViewController:vc andDate:currentDate andMode:UIDatePickerModeDateAndTime];
    }
    singleActionSheet.delegate = delegate;
}

+(void)dismiss {
    [singleActionSheet dismissViewAnimimation];
}

#pragma mark - button event

-(void)onCancelClick{
    if ([self.delegate respondsToSelector:@selector(datePicker:dismissView:)]) {
        [self.delegate datePicker:singleActionSheet dismissView:datePicker.date];
    }
    [self dismissViewAnimimation];
}

-(void)onSaveClick{
    if ([self.delegate respondsToSelector:@selector(datePicker:saveDate:)]) {
        [self.delegate datePicker:singleActionSheet saveDate:datePicker.date];
    }
    [self dismissViewAnimimation];
}

-(void)dismissViewAnimimation{
    
    [UIView animateWithDuration:kActionSheetShowTime delay:0 options:7<<16 animations:^{
        self.frame = CGRectMake(0, parentVC.view.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        self.isShow = NO;
        [self removeFromSuperview];
    }];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
