//
//  UIViewController+TimeController.h
//  LEDBLEControl
//
//  Created by Developer on 14/12/8.
//  Copyright (c) 2014年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "PerModel.h"

@interface TimeController:UIViewController
{
    UISwitch *switch1;
    UISwitch *switch2;
    UIDatePicker *pickerOn;
    UIDatePicker *pickerOff;
}
-(IBAction)ClickSwitch1:(id)sender;
-(IBAction)ClickSwitch2:(id)sender;

@property (strong, nonatomic) PeripheralModel *permodel;

@property (strong, nonatomic) UISwitch *switch1;
@property (strong, nonatomic) UISwitch *switch2;

@property (strong, nonatomic) UIDatePicker *pickerOn;
@property (strong, nonatomic) UIDatePicker *pickerOff;

@end

