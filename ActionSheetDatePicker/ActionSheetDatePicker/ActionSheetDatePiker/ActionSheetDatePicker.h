//
//  ActionSheetDatePicker.h
//  ActionSheetDatePicker
//
//  Created by liangming on 15/3/16.
//  Copyright (c) 2015年 teambition. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ActionSheetDatePicker;

@protocol ActionSheetDatePickerDelegate <NSObject>

@optional
-(void)datePicker:(ActionSheetDatePicker *)datePicker saveDate:(NSDate *)date;
-(void)datePicker:(ActionSheetDatePicker *)datePicker dismissView:(NSDate *)date;

@end

@interface ActionSheetDatePicker : UIView{
    UIView *topToolView;
    UIButton *buttonCancel;
    UIButton *buttonSave;
    UIView *viewTopLine;
    UIView *viewBottomLine;
    UIViewController *parentVC;
}

@property(nonatomic, assign) id<ActionSheetDatePickerDelegate>delegate;
@property(nonatomic, strong) UIDatePicker *datePicker;
@property(nonatomic, assign) BOOL isShow;

+(void)showInViewController:(UIViewController *)vc delegate:(id)delegate defaultDate:(NSDate *)date mode:(UIDatePickerMode)mode;
+(void)showInViewController:(UIViewController *)vc delegate:(id)delegate;
+(void)dismiss;

@end

