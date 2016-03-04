//
//  UIViewController+TimeModelController.h
//  LEDBLEControl
//
//  Created by Developer on 14/12/19.
//  Copyright (c) 2014年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "PerModel.h"
#import "RadioButton.h"

@interface TimeModelController:UIViewController<RadioButtonDelegate>
{
    UISwitch *switch1;
    UISwitch *switch2;
    UIDatePicker *pickerOn;
    UIDatePicker *pickerOff;
    RadioButton *rb1,*rb2,*rb3;
}

-(IBAction)ClickSwitch1:(id)sender;
-(IBAction)ClickSwitch2:(id)sender;
-(IBAction)SendClick:(id)sender;

@property (strong, nonatomic) PeripheralModel *permodel;

@property (strong, nonatomic) UISwitch *switch1;
@property (strong, nonatomic) UISwitch *switch2;

@property (strong, nonatomic) UIDatePicker *pickerOn;
@property (strong, nonatomic) UIDatePicker *pickerOff;

@property (strong, nonatomic) RadioButton  *rb1,*rb2,*rb3;

@end

