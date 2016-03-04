//
//  UIViewController+DetailController.m
//  LEDBLEControl
//
//  Created by Developer on 14/12/2.
//  Copyright (c) 2014年 Developer. All rights reserved.
//
#import "HYActivityView.h"
#import "RSCameraRotator.h"
#import "DetailController.h"
#import "TimeModelController.h"
#import "DKCircleButton.h"
#import "UIButton+Bootstrap.h"
#import <QuartzCore/QuartzCore.h>
#import "TitleViewControl.h"
#import "SettingsHelper.h"

#define DEFAULT_VOID_COLOR [UIColor whiteColor]

@implementation DetailController

@synthesize options = _options;
@synthesize LightOnOff;
@synthesize activityView;
@synthesize timeView;
@synthesize time;

+ (UIColor *)colorWithARGBHex:(UInt32)hex
{
    int b = hex & 0x000000FF;
    int g = ((hex & 0x0000FF00) >> 8);
    int r = ((hex & 0x00FF0000) >> 16);
    int a = ((hex & 0xFF000000) >> 24);
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:a / 255.f];
}

bool isfirst;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    NSLog(@"print %f,%f",width,height);
    
    isfirst=true;
    
    time = [NSDate date];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"detailbg.jpeg"]]];
    [self.view setContentMode:UIViewContentModeTop];
    
    NSString *title = self.permodel.bleName;
    if(title==nil)
        title = self.permodel.perName;
    
    self.navigationItem.titleView = [[TitleViewControl alloc] initWithTitleText:title titlesize:CGSizeMake(100, 50) delegate:self];
    UIBarButtonItem *buttonItem =[[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(SendClick:)];

    self.navigationItem.rightBarButtonItem = buttonItem;
    
    //self.isOnOff=NO;
    colorPicker = [[RSColorPickerView alloc] initWithFrame:CGRectMake(1,1,210,210)];
    [colorPicker setDelegate:self];
    [colorPicker setBrightness:1.0];
    [colorPicker setCropToCircle:YES]; // Defaults to YES (and you can set BG color)
    [colorPicker setBackgroundColor:[UIColor clearColor]];
    
    CGFloat x = (width-230)/2+3;
    colorPatch = [[UIView alloc] initWithFrame:CGRectMake(x, 15, 230, 230)];
    [colorPatch.layer setCornerRadius:110];
    colorPatch.layer.cornerRadius=110;
    colorPatch.layer.cornerRadius=110;
    colorPatch.layer.borderWidth=3;
    colorPatch.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    
    x = (width-210)/2+2;
    colorPickerRadius =[[UIView alloc] initWithFrame:CGRectMake(x, 24, 212, 212)];
    [colorPickerRadius setBackgroundColor:[UIColor lightGrayColor]];
    [colorPickerRadius.layer setCornerRadius:101];
    colorPickerRadius.layer.cornerRadius=101;
    colorPickerRadius.layer.borderWidth=3;
    colorPickerRadius.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    
    x = (width-220)/2;
    brightnessSlider = [[RSBrightnessSlider alloc] initWithFrame:CGRectMake(x, 265.0, 220, 40.0)];
    [brightnessSlider setColorPicker:colorPicker];
    [brightnessSlider setUseCustomSlider:YES];
    
    x = (width-320)/2+16;
    self.LightOnOff = [[RSCameraRotator alloc] initWithFrame:CGRectMake(x , 320, 80, 40)];
    self.LightOnOff.tintColor = [UIColor blackColor];
    self.LightOnOff.offColor = [[self class] colorWithARGBHex:0xff498e14];
    self.LightOnOff.onColorLight = [[self class] colorWithARGBHex:0xff9dd32a];
    self.LightOnOff.onColorDark = [[self class] colorWithARGBHex:0xff66a61b];
    self.LightOnOff.delegate = self;
    
    x = (width-320)/2+113;
    UIButton *SetTime = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [SetTime setTitle:@"时间设置" forState:UIControlStateNormal];
    SetTime.frame = CGRectMake(x , 320, 85, 40);
    [SetTime successStyle];
    [SetTime addTarget:self action:@selector(SetTimeClick) forControlEvents:UIControlEventTouchUpInside];
    
    x = (width-320)/2+216;
    UIButton *SetModel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [SetModel setTitle:@"模式设置" forState:UIControlStateNormal];
    SetModel.tintColor=[UIColor blackColor];
    SetModel.frame = CGRectMake(x , 320, 85, 40);
    [SetModel successStyle];
    [SetModel addTarget:self action:@selector(SetModelClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:brightnessSlider];
    [colorPatch addSubview:colorPickerRadius];
    [colorPickerRadius addSubview:colorPicker];
    [self.view addSubview:colorPatch];
    [self.view addSubview:colorPickerRadius];
    [self.view addSubview:SetTime];
    [self.view addSubview:SetModel];
    [self.view addSubview:self.LightOnOff];
}


-(IBAction)SendClick:(id)sender
{
    
    SettingsHelper *settings=[[SettingsHelper alloc]init];
    NSString *model1= [NSString stringWithFormat:@"%@|M%d",self.permodel.UUID,1 ];
    NSString *model2= [NSString stringWithFormat:@"%@|M%d",self.permodel.UUID,2 ];
    NSString *model3= [NSString stringWithFormat:@"%@|M%d",self.permodel.UUID,3 ];
    NSString *n1 = [settings GetValueByKey:model1];
    NSString *n2 = [settings GetValueByKey:model2];
    NSString *n3 = [settings GetValueByKey:model3];
    if(n1==nil)
        n1=@"自定义模式1";
    else
        n1=[n1 componentsSeparatedByString:@"|"][0];
    if(n2==nil)
        n2=@"自定义模式2";
    else
        n2=[n2 componentsSeparatedByString:@"|"][0];
    if(n3==nil)
        n3=@"自定义模式3";
    else
        n3=[n3 componentsSeparatedByString:@"|"][0];
    
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"设置" message:@"将当前颜色设为自定义模式" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:n1,n2,n3, nil];
    [alert show];
}

int isAlertButtonIndex;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    SettingsHelper *settings=[[SettingsHelper alloc]init];
    NSString *model;
    NSString *name=@"";
    
    UITextField *tf = [alertView textFieldAtIndex:0];
    
    if(tf==nil)
    {
        if(buttonIndex>0)
        {
            if(isAlertButtonIndex==0)
            {
                model = [NSString stringWithFormat:@"%@|M%d",self.permodel.UUID,(int)buttonIndex ];
                isAlertButtonIndex=(int)buttonIndex;
                if(model!=nil)
                {
                    NSString *qry = [settings GetValueByKey:model];
                    if(qry!=nil)
                    {
                        NSArray *arr =[qry componentsSeparatedByString:@"|"];
                        if(arr!=nil&&arr.count>1)
                            name = arr[0];
                    }
                }
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置颜色名称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存",nil];
                [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
                [alert textFieldAtIndex:0].text=name;
                [alert show];
            }
        }
    }
    else
    {
        if(buttonIndex>0)
        {
            model = [NSString stringWithFormat:@"%@|M%d",self.permodel.UUID,isAlertButtonIndex ];
            isAlertButtonIndex=0;
            name = [alertView textFieldAtIndex:0].text;
            
            [settings AddValue:model Value:[NSString stringWithFormat:@"%@|%@",name,[self changeUIColorToRGB:colorPicker.selectionColor]]];
            [delegate submitChange:self.permodel];
        }
        else
            isAlertButtonIndex=0;
    }
}



- (id) initWithDelegate:(NSObject<DetailControllerDelegate> *)detailControllerDelegate
{
    delegate = detailControllerDelegate;
    return self;
}

-(void)submitChange:(NSString *)value
{
    self.permodel.bleName = value;
    SettingsHelper *settings=[[SettingsHelper alloc]init];
    [settings AddValue:self.permodel.UUID Value:value];
    [delegate submitChange:self.permodel];
}


-(void)colorPickerDidChangeSelection:(RSColorPickerView *)cp {
    colorPatch.backgroundColor = [cp selectionColor];
    NSLog(@"%f",[time timeIntervalSinceNow]);
    if([time timeIntervalSinceNow]<-0.5)
    {
        time = [NSDate date];
        
        if(self.isOnOff)
        {
            NSString *colorString =[self changeUIColorToRGB:cp.selectionColor];
        
            NSLog(@"%@",colorString);
        
            //0:r 1:g 2:b
            int r=[self colorStringToInt:colorString colorNo:0];
            int g=[self colorStringToInt:colorString colorNo:1];
            int b=[self colorStringToInt:colorString colorNo:2];
            
            
            Byte _b[] ={r
                ,g
                ,b
                ,0x00
                ,0x64};
        
            NSData *d = [[NSData alloc] initWithBytes:_b length:sizeof(_b)];
        
            [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic1 type:CBCharacteristicWriteWithResponse];
    
            NSLog(@"Red: %d Green: %d Blue: %d Bright: %d",r,g,b,[[NSString stringWithFormat:@"%f",[brightnessSlider value]*100 ] intValue]);
        }
    }
}


//字符串转颜色
- (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

//颜色转字符串
- (NSString *) changeUIColorToRGB:(UIColor *)color{
    const CGFloat *cs=CGColorGetComponents(color.CGColor);
    NSString *r = [NSString stringWithFormat:@"%@",[self  ToHex:cs[0]*255]];
    NSString *g = [NSString stringWithFormat:@"%@",[self  ToHex:cs[1]*255]];
    NSString *b = [NSString stringWithFormat:@"%@",[self  ToHex:cs[2]*255]];
    return [NSString stringWithFormat:@"#%@%@%@",r,g,b];
    
    
}

-(int)colorStringToInt:(NSString *)colorString colorNo:(int)colorNo
{
    const char *cstr;
    int iPosition=0;
    int nColor=0;
    cstr=[colorString UTF8String];
    
    //判断是否有＃号
    if(cstr[0]=='#') iPosition = 1;
    else iPosition = 0;
    
    int index = iPosition + 2 * colorNo;
    
    nColor = (int)strtoul([[colorString substringWithRange:NSMakeRange(index, 2)] UTF8String],0,16);
    
    return nColor;
}

//十进制转十六进制
-(NSString *)ToHex:(int)tmpid
{
    NSString *endtmp=@"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig=tmpid%16;
    int tmp=tmpid/16;
    switch (ttmpig)
    {
        case 10:
            nLetterValue =@"A";break;
        case 11:
            nLetterValue =@"B";break;
        case 12:
            nLetterValue =@"C";break;
        case 13:
            nLetterValue =@"D";break;
        case 14:
            nLetterValue =@"E";break;
        case 15:
            nLetterValue =@"F";break;
        default:nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
            
    }
    switch (tmp)
    {
        case 10:
            nStrat =@"A";break;
        case 11:
            nStrat =@"B";break;
        case 12:
            nStrat =@"C";break;
        case 13:
            nStrat =@"D";break;
        case 14:
            nStrat =@"E";break;
        case 15:
            nStrat =@"F";break;
        default:nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
            
    }
    endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    return endtmp;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)clicked:(BOOL)isFront
{
    // When using GPUImage, put [self.videoCamera rotateCamera]; here,
    // Otherwise do:
    NSData *d;
    if (!isFront) {
        self.isOnOff = YES;
        char b[] = {0x00,0x00,0x00,0xFF,0x64};
        d = [[NSData alloc] initWithBytes:b length:sizeof(b)];
    }
    else {
        
        if(isfirst)
        {
            isfirst=false;
            return;
        }
        self.isOnOff = NO;
        Byte b[] = {0x00,0x00,0x00,0x00,0x00};
        d = [[NSData alloc] initWithBytes:b length:sizeof(b) ];
    }
    
    [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic1 type:CBCharacteristicWriteWithResponse];
}

-(void)LightOnOffClick{
    self.isOnOff=!self.isOnOff;
    NSData *d;
    
    if(self.isOnOff)
    {
        char b[] = {0x00,0x00,0x00,0xFF,0x64};
        d = [[NSData alloc] initWithBytes:b length:sizeof(b)];
    }
    else
    {
        Byte b[] = {0xFF,0xFF,0xFF,0xFF,0x00};
        d = [[NSData alloc] initWithBytes:b length:sizeof(b) ];
    }
    
    [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic1 type:CBCharacteristicWriteWithResponse];
}

-(void)SetTimeClick{
    self.timeView = [[TimeModelController alloc]init];
    self.timeView.permodel = self.permodel;
    [self.navigationController showViewController:self.timeView sender:self];
}

-(void)SetModelClick{
    if (!self.activityView) {
        self.activityView = [[HYActivityView alloc]initWithTitle:@"请选择一个模式..." referView:self.view];
        
        SettingsHelper *settings=[[SettingsHelper alloc]init];
        
        //横屏会变成一行6个, 竖屏无法一行同时显示6个, 会自动使用默认一行4个的设置.
        self.activityView.numberOfButtonPerLine = 6;
        
        ButtonView *bv = [[ButtonView alloc]initWithText:@"照明" image:[UIImage imageNamed:@"Model.png"] handler:^(ButtonView *buttonView){
            
            Byte b[] = {0x10};
            NSData *d = [[NSData alloc]initWithBytes:b length:1];
            [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic3 type:CBCharacteristicWriteWithResponse];
            
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"淡雅" image:[UIImage imageNamed:@"Model.png"] handler:^(ButtonView *buttonView){
            
            Byte b[] = {0x11};
            NSData *d = [[NSData alloc]initWithBytes:b length:1];
            [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic3 type:CBCharacteristicWriteWithResponse];
            
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"暖光" image:[UIImage imageNamed:@"Model.png"] handler:^(ButtonView *buttonView){
            
            Byte b[] = {0x12};
            NSData *d = [[NSData alloc]initWithBytes:b length:1];
            [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic3 type:CBCharacteristicWriteWithResponse];
            
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"晨曦" image:[UIImage imageNamed:@"Model.png"] handler:^(ButtonView *buttonView){
            
            Byte b[] = {0x13};
            NSData *d = [[NSData alloc]initWithBytes:b length:1];
            [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic3 type:CBCharacteristicWriteWithResponse];
            
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"暮光" image:[UIImage imageNamed:@"Model.png"] handler:^(ButtonView *buttonView){
            
            Byte b[] = {0x14};
            NSData *d = [[NSData alloc]initWithBytes:b length:1];
            [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic3 type:CBCharacteristicWriteWithResponse];
            
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"明亮" image:[UIImage imageNamed:@"Model.png"] handler:^(ButtonView *buttonView){
            
            Byte b[] = {0x15};
            NSData *d = [[NSData alloc]initWithBytes:b length:1];
            [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic3 type:CBCharacteristicWriteWithResponse];
            
        }];
        
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"月光" image:[UIImage imageNamed:@"yueguang.png"] handler:^(ButtonView *buttonView){
            
            Byte b[] = {0x16};
            NSData *d = [[NSData alloc]initWithBytes:b length:1];
            [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic3 type:CBCharacteristicWriteWithResponse];
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"阅读" image:[UIImage imageNamed:@"yuedu.png"] handler:^(ButtonView *buttonView){
            
            Byte b[] = {0x17};
            NSData *d = [[NSData alloc]initWithBytes:b length:1];
            [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic3 type:CBCharacteristicWriteWithResponse];
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"冷冽" image:[UIImage imageNamed:@"lenlie.png"] handler:^(ButtonView *buttonView){
            
            Byte b[] = {0x18};
            NSData *d = [[NSData alloc]initWithBytes:b length:1];
            [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic3 type:CBCharacteristicWriteWithResponse];
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"温暖" image:[UIImage imageNamed:@"wennuan.png"] handler:^(ButtonView *buttonView){
            
            Byte b[] = {0x19};
            NSData *d = [[NSData alloc]initWithBytes:b length:1];
            [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic3 type:CBCharacteristicWriteWithResponse];
        }];
        [self.activityView addButtonView:bv];
        
        bv = [[ButtonView alloc]initWithText:@"魅惑" image:[UIImage imageNamed:@"meihuo.png"] handler:^(ButtonView *buttonView){
            
            Byte b[] = {0x20};
            NSData *d = [[NSData alloc]initWithBytes:b length:1];
            [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic3 type:CBCharacteristicWriteWithResponse];
        }];
        [self.activityView addButtonView:bv];
        
        NSString *qry =[settings GetValueByKey:[NSString stringWithFormat:@"%@|M1",self.permodel.UUID]];
        NSArray *arr = [qry componentsSeparatedByString:@"|"];
        NSString *n = @"自定义1";
        if(arr[0]!=nil)
            n=arr[0];
        
        bv = [[ButtonView alloc]initWithText:n image:[UIImage imageNamed:@"Model.png"] handler:^(ButtonView *buttonView){
            
            NSString *colorString = arr[1];
            if(colorString != nil)
            {
                int r=[self colorStringToInt:colorString colorNo:0];
                int g=[self colorStringToInt:colorString colorNo:1];
                int b=[self colorStringToInt:colorString colorNo:2];
                
                Byte _b[] ={r
                    ,g
                    ,b
                    ,0x00
                    ,0x64};
                
                NSData *d = [[NSData alloc] initWithBytes:_b length:sizeof(_b)];
                
                [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic1 type:CBCharacteristicWriteWithResponse];
            }
            
        }];
        
        [self.activityView addButtonView:bv];
        
        qry =[settings GetValueByKey:[NSString stringWithFormat:@"%@|M2",self.permodel.UUID]];
        arr = [qry componentsSeparatedByString:@"|"];
        n = @"自定义2";
        if(arr[0]!=nil)
            n=arr[0];
        
        bv = [[ButtonView alloc]initWithText:n image:[UIImage imageNamed:@"Model.png"] handler:^(ButtonView *buttonView){
            
            NSString *colorString = arr[1];
            if(colorString != nil)
            {
                int r=[self colorStringToInt:colorString colorNo:0];
                int g=[self colorStringToInt:colorString colorNo:1];
                int b=[self colorStringToInt:colorString colorNo:2];
                
                Byte _b[] ={r
                    ,g
                    ,b
                    ,0x00
                    ,0x64};
                
                NSData *d = [[NSData alloc] initWithBytes:_b length:sizeof(_b)];
                
                [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic1 type:CBCharacteristicWriteWithResponse];
            }
            
        }];
        [self.activityView addButtonView:bv];
        
        qry =[settings GetValueByKey:[NSString stringWithFormat:@"%@|M3",self.permodel.UUID]];
        arr = [qry componentsSeparatedByString:@"|"];
        n = @"自定义3";
        if(arr[0]!=nil)
            n=arr[0];
            
        bv = [[ButtonView alloc]initWithText:n image:[UIImage imageNamed:@"Model.png"] handler:^(ButtonView *buttonView){
            
            NSString *colorString = arr[1];
            if(colorString != nil)
            {
                int r=[self colorStringToInt:colorString colorNo:0];
                int g=[self colorStringToInt:colorString colorNo:1];
                int b=[self colorStringToInt:colorString colorNo:2];
                
                Byte _b[] ={r
                    ,g
                    ,b
                    ,0x00
                    ,0x64};
                
                NSData *d = [[NSData alloc] initWithBytes:_b length:sizeof(_b)];
                
                [self.permodel.peripheral writeValue:d forCharacteristic:self.permodel.characteristic1 type:CBCharacteristicWriteWithResponse];
            }
            
        }];
        [self.activityView addButtonView:bv];
    }
    
    [self.activityView show];
    
}

@end
