//
//  UIViewController+TimeModelController.m
//  LEDBLEControl
//
//  Created by Developer on 14/12/19.
//  Copyright (c) 2014年 Developer. All rights reserved.
//

#import "TimeModelController.h"

@implementation TimeModelController:UIViewController

@synthesize pickerOn;
@synthesize pickerOff;
@synthesize switch1;
@synthesize switch2;
@synthesize rb1,rb2,rb3;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"timebg.png"]]];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(SendClick:)];
    
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 130, 31)];
    lb1.text = @"开灯时间";
    [lb1.font fontWithSize:20.0];
    
    switch1 = [[UISwitch alloc]initWithFrame:CGRectMake(150, 20, 49, 31)];
    
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(250, 20, 130, 31)];
    lb2.text = @"熄灯时间";
    [lb2.font fontWithSize:20.0];
    
    rb1 = [[RadioButton alloc] initWithGroupId:@"first group" index:0];
    rb2 = [[RadioButton alloc] initWithGroupId:@"first group" index:1];
    rb3 = [[RadioButton alloc] initWithGroupId:@"first group" index:2];
    rb1.frame = CGRectMake(10,70,22,22);
    [rb1 setChecked:YES];
    UILabel *l1 = [[UILabel alloc]initWithFrame:CGRectMake(33, 70, 70, 22)];
    l1.text=@"立即";
    l1.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(label1Click:)];
    [l1 addGestureRecognizer:tapGestureTel];
    
    rb2.frame = CGRectMake(80,70,22,22);
    UILabel *l2 = [[UILabel alloc]initWithFrame:CGRectMake(103, 70, 70, 22)];
    l2.text=@"30s 渐变";
    l2.userInteractionEnabled=YES;
    tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(label2Click:)];
    [l2 addGestureRecognizer:tapGestureTel];
    
    rb3.frame = CGRectMake(180,70,22,22);
    UILabel *l3 = [[UILabel alloc]initWithFrame:CGRectMake(203, 70, 70, 22)];
    l3.text=@"60s 渐变";
    l3.userInteractionEnabled=YES;
    tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(label3Click:)];
    [l3 addGestureRecognizer:tapGestureTel];
    
    [RadioButton addObserverForGroupId:@"first group" observer:self];
    
//    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(280, 70, 70, 31)];
//    [sendBtn addTarget:self action:@selector(SendClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    pickerOn = [[UIDatePicker alloc]initWithFrame:CGRectMake(-20, 130, 10, 10)];
    [pickerOn setMinimumDate:[NSDate date]];
    [pickerOn setDatePickerMode:UIDatePickerModeDateAndTime];
    [pickerOn setLocale:locale];
    
    [self.view addSubview:lb1];
    [self.view addSubview:lb2];
    [self.view addSubview:switch1];
    [self.view addSubview:switch2];
    [self.view addSubview:rb1];
    [self.view addSubview:l1];
    [self.view addSubview:rb2];
    [self.view addSubview:l2];
    [self.view addSubview:rb3];
    [self.view addSubview:l3];
//    [self.view addSubview:sendBtn];
    [self.view addSubview:pickerOn];
}

-(void)label1Click:(id)sender
{
    [rb1 setChecked:YES];
    [rb2 setChecked:NO];
    [rb3 setChecked:NO];
}

-(void)label2Click:(id)sender
{
    [rb1 setChecked:NO];
    [rb2 setChecked:YES];
    [rb3 setChecked:NO];
}

-(void)label3Click:(id)sender
{
    [rb1 setChecked:NO];
    [rb2 setChecked:NO];
    [rb3 setChecked:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId
{
    
}

-(IBAction)ClickSwitch1:(id)sender{
    [sender setOn:NO];
    
    NSDate *date = [self.pickerOn date];
    NSTimeInterval time = [date timeIntervalSinceNow];
    
    if(time>0)
    {
        int hour = time/60/60;
        int minute = ((int)time)%60;
        int model = 0;
        
        if([rb1 isChecked])
            model = 0x20;
        if([rb2 isChecked])
            model = 0x23;
        if([rb3 isChecked])
            model = 0x26;
        
        Byte b[]={hour,minute,model,1};
        NSData *d = [[NSData alloc]initWithBytes:b length:sizeof(b)];
        
        [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic2 type:CBCharacteristicWriteWithResponse];
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"开灯时间设置成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
}

-(IBAction)ClickSwitch2:(id)sender{
    [sender setOn:NO];
    
    NSDate *date = [self.pickerOn date];
    NSTimeInterval time = [date timeIntervalSinceNow];
    if(time>0)
    {
        int hour = time/60/60;
        int minute = ((int)time)%60;
        int model = 0;
        
        if([rb1 isChecked])
            model = 0x20;
        if([rb2 isChecked])
            model = 0x23;
        if([rb3 isChecked])
            model = 0x26;
        
        Byte b[]={hour,minute,model,0};
        NSData *d = [[NSData alloc]initWithBytes:b length:sizeof(b)];
        
        [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic2 type:CBCharacteristicWriteWithResponse];
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"熄灯时间设置成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [myAlertView show];
    }
}

-(IBAction)SendClick:(id)sender
{
    NSDate *date = [self.pickerOn date];
    NSTimeInterval time = [date timeIntervalSinceNow];
    if(time>0)
    {
        int hour = time/60/60;
        int minute = ((int)time/60)%60;
        
        if((((int)time)%60)>0)
            minute++;
            
        int model = 0;
        
        if([rb1 isChecked])
            model = 0x20;
        if([rb2 isChecked])
            model = 0x23;
        if([rb3 isChecked])
            model = 0x26;
        int onoff = 0;

        if([switch1 isOn])//熄灯
        {
            onoff=0;
        }
        else//开灯
        {
            onoff=1;
        }
        
        Byte b[]={hour,minute,model,onoff};
        NSData *d = [[NSData alloc]initWithBytes:b length:sizeof(b)];
        
        [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic2 type:CBCharacteristicWriteWithResponse];
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"设置成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
}
@end
