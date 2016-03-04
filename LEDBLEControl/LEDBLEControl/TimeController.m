//
//  UIViewController+TimeController.m
//  LEDBLEControl
//
//  Created by Developer on 14/12/8.
//  Copyright (c) 2014年 Developer. All rights reserved.
//

#import "TimeController.h"

@implementation TimeController:UIViewController

@synthesize pickerOn;
@synthesize pickerOff;
@synthesize switch1;
@synthesize switch2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 57, 90, 21)];
    lb1.text = @"开灯时间：";
    
    switch1 = [[UISwitch alloc]initWithFrame:CGRectMake(260, 57, 49, 31)];
    [switch1 addTarget:self action:@selector(ClickSwitch1:) forControlEvents:UIControlEventValueChanged];
     
    pickerOn = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 100, 200, 150)];
    [pickerOn setMinimumDate:[NSDate date]];
    [pickerOn setDatePickerMode:UIDatePickerModeTime];
    
    
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 307, 90, 21)];
    lb1.text = @"熄灯时间：";
    
    switch2 = [[UISwitch alloc]initWithFrame:CGRectMake(260, 307, 49, 31)];
    [switch2 addTarget:self action:@selector(ClickSwitch2:) forControlEvents:UIControlEventValueChanged];
    
    pickerOff = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 350, 200, 150)];
    [pickerOff setMinimumDate:[NSDate date]];
    [pickerOff setDatePickerMode:UIDatePickerModeTime];
    
    [self.view addSubview:lb1];
    [self.view addSubview:switch1];
    [self.view addSubview:pickerOn];
    
    [self.view addSubview:lb2];
    [self.view addSubview:switch2];
    [self.view addSubview:pickerOff];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)ClickSwitch1:(id)sender{
    [sender setOn:NO];
    
    
    NSDate *date = [self.pickerOn date];
    NSTimeInterval time = [date timeIntervalSinceNow];
    if(time>0)
    {
        int hour = time/60/60;
        int minute = ((int)time)%60;
        
        Byte b[]={hour,minute,1};
        NSData *d = [[NSData alloc]initWithBytes:b length:sizeof(b)];
        
        [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic2 type:CBCharacteristicWriteWithResponse];
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"开灯时间设置成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [myAlertView show];

    }
}

-(IBAction)ClickSwitch2:(id)sender{
    [sender setOn:NO];
    
    NSDate *date = [self.pickerOff date];
    NSTimeInterval time = [date timeIntervalSinceNow];
    if(time>0)
    {
        int hour = time/60/60;
        int minute = ((int)time)%60;
        
        Byte b[]={hour,minute,0};
        NSData *d = [[NSData alloc]initWithBytes:b length:sizeof(b)];
        
        [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic2 type:CBCharacteristicWriteWithResponse];
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"熄灯时间设置成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [myAlertView show];
    }
}
@end
