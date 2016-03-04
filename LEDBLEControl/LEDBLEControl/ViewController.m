//
//  ViewController.m
//  LEDBLEControl
//
//  Created by Developer on 14/12/2.
//  Copyright (c) 2014年 Developer. All rights reserved.
//
#import "HYActivityView.h"
#import "ViewController.h"
#import "DetailController.h"
#import "DKCircleButton.h"
#import <UIKit/UIKit.h>
#import "BLEHelper.h"
#import "UIButton+Bootstrap.h"
#import "SettingsHelper.h"
#import "tableCellController.h"




#import "MainMusicViewController.h"


@implementation ViewController
@synthesize options = _options;
@synthesize ActiveSender;
@synthesize scansperipherals;
@synthesize ble;
@synthesize activityView;
@synthesize LightOnOff;
@synthesize lplv;

int clickButtonNumber=0;
bool isScan;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed=YES;
        
        
    }
    return self;
}


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

#pragma HBAdd

-(void)createRightBar{
    
    UIButton *btnb = [UIButton buttonWithType : UIButtonTypeCustom];
    btnb.frame = CGRectMake (5.5, 5.5, 33, 33);
    [btnb setBackgroundImage :[UIImage imageNamed:@"bar1"] forState:UIControlStateNormal];
    btnb.showsTouchWhenHighlighted=YES;
    [btnb addTarget:self action:@selector(showRight:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *ubar=[[UIBarButtonItem alloc] initWithCustomView :btnb];
    self.navigationItem.rightBarButtonItem = ubar;
}

-(void)showRight:(UIButton *)sender{
    
    
    MainMusicViewController *mmvc=[MainMusicViewController sharedInstance];
    mmvc.canWork=YES;
    mmvc.permodelArray=self.connectperipherals;
//    for (PeripheralModel *m in self.connectperipherals) {
//        if(m.switchNumber==0)
//        {
//            mmvc.permodel = m;
//            break;
//        }
//    }
    [self.navigationController pushViewController:mmvc animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createRightBar];
    
    isScan=false;
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    NSLog(@"print %f,%f",width,height);
    
    self.BLENameHelper = [[SettingsHelper alloc] init];
//    NSLog(@"%@",[self.BLENameHelper GetValueByKey:@"111"]);
//    [self.BLENameHelper AddValue:@"222" Value:@"333"];
    
    self.isAllLightOn = NO;
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mainbg2.png"]]];
    
    CGFloat x = (width-150)/2;
    CGFloat y = height - 160;
    
    self.LightOnOff = [[RSCameraRotator alloc] initWithFrame:CGRectMake(x, y, 150, 50)];
    self.LightOnOff.tintColor = [UIColor blackColor];
    self.LightOnOff.offColor = [[self class] colorWithARGBHex:0xff498e14];
    self.LightOnOff.onColorLight = [[self class] colorWithARGBHex:0xff9dd32a];
    self.LightOnOff.onColorDark = [[self class] colorWithARGBHex:0xff66a61b];
    self.LightOnOff.delegate = self;
    
    [self.tableview1 addSubview:self.LightOnOff];
    [self.tableview1 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    ble = [[BLEHelper alloc]init];
    ble.mydelegate = self;
    [ble Start];
    
}

-(void)submitChange:(PeripheralModel *)value
{
    switch (value.switchNumber+1) {
        case 1:
            if(value.bleName!=nil)
                self.lbName1.text = value.bleName;
            else
                self.lbName1.text = value.perName;
            break;
        case 2:
            if(value.bleName!=nil)
                self.lbName2.text = value.bleName;
            else
                self.lbName2.text = value.perName;
            break;
        case 3:
            if(value.bleName!=nil)
                self.lbName3.text = value.bleName;
            else
                self.lbName3.text = value.perName;
            break;
        case 4:
            if(value.bleName!=nil)
                self.lbName4.text = value.bleName;
            else
                self.lbName4.text = value.perName;
            break;
        case 5:
            if(value.bleName!=nil)
                self.lbName5.text = value.bleName;
            else
                self.lbName5.text = value.perName;
            break;
        case 6:
            if(value.bleName!=nil)
                self.lbName6.text = value.bleName;
            else
                self.lbName6.text = value.perName;
            break;
            
        default:
            break;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView *tempView =[[UIView alloc]init];
    [cell setBackgroundView:tempView];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.backgroundView=[[UIView alloc] initWithFrame:CGRectZero];
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    tableCellController *tab = [[tableCellController alloc]init];
//    
//    return tab;
//}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//    else {
//        
//    }
//}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    switch(interfaceOrientation)
    {
        case UIInterfaceOrientationLandscapeLeft:
            return NO;
        case UIInterfaceOrientationLandscapeRight:
            return NO;
        default:
            return YES;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showListView
{
    
    [ble ScanPeripherals];
    
    _options =[[NSMutableArray alloc] init];
    self.scansperipherals=[[NSMutableArray alloc] init];
    
    
    lplv = [[LeveyPopListView alloc] initWithTitle:@"请选择一个蓝牙连接..." options:_options];
    lplv.delegate = self;
    
    [lplv removeFromView:self.view];
    [lplv showInView:self.view animated:NO];
}



-(BOOL) containConnectPeripherals:(CBPeripheral *)p
{
    for (PeripheralModel *_p in self.connectperipherals) {
        if([_p.peripheral.identifier isEqual:p.identifier])
            return NO;
    }
    return YES;
}

#pragma mark - LeveyPopListView delegates
- (void)leveyPopListView:(LeveyPopListView *)popListView didSelectedIndex:(NSInteger)anIndex
{
    if(clickButtonNumber>0)
    {
        [ble connect:self.scansperipherals[anIndex]];
    }
}

-(void)GetPeripheral:(CBPeripheral *)p
{
    if(isScan)
    {
        isScan=false;
        return;
    }
    
    for (CBPeripheral *_p in self.scansperipherals) {
                if (p.identifier == _p.identifier) {
                    return;
                }
            }
    NSString *name = [self.BLENameHelper GetValueByKey:p.identifier.UUIDString];
    if(name==nil)
        name = [p name];
    
    [_options addObject:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"little.png"],@"img",name,@"text", nil]];
    
    [self.scansperipherals addObject:p];
    
    [lplv removeFromView:self.view];
    
    lplv = [[LeveyPopListView alloc] initWithTitle:@"请选择一个蓝牙连接..." options:_options];
    lplv.delegate = self;
    [lplv showInView:self.view animated:YES];
}

-(void)GetBLE
{
    NSLog(@"%@",[ble.peripheral description]);
    PeripheralModel *permodel=[[PeripheralModel alloc] init];
    permodel.switchNumber = clickButtonNumber-1;
    permodel.perName = [ble.peripheral name];
    permodel.UUID = [ble.peripheral identifier].UUIDString;
    permodel.bleName = [self.BLENameHelper GetValueByKey:permodel.UUID];
    permodel.peripheral = ble.peripheral;
    permodel.isOnOff = YES;
    permodel.characteristic1 = ble.characteristic1;
    permodel.characteristic2 = ble.characteristic2;
    permodel.characteristic3 = ble.characteristic3;
    
    if(self.connectperipherals==nil)
        self.connectperipherals = [[NSMutableArray alloc] initWithCapacity:6];
    
    [self.connectperipherals addObject:permodel];
    
    switch (clickButtonNumber) {
        case 1:
            if(permodel.bleName!=nil)
                self.lbName1.text = permodel.bleName;
            else
                self.lbName1.text = permodel.perName;
//            self.lbUUID1.text = permodel.UUID;
            break;
        case 2:
            if(permodel.bleName!=nil)
                self.lbName2.text = permodel.bleName;
            else
                self.lbName2.text = permodel.perName;
//            self.lbUUID2.text = permodel.UUID;
            break;
        case 3:
            if(permodel.bleName!=nil)
                self.lbName3.text = permodel.bleName;
            else
                self.lbName3.text = permodel.perName;
//            self.lbUUID3.text = permodel.UUID;
            break;
        case 4:
            if(permodel.bleName!=nil)
                self.lbName4.text = permodel.bleName;
            else
                self.lbName4.text = permodel.perName;
//            self.lbUUID5.text = permodel.UUID;
            break;
        case 5:
            if(permodel.bleName!=nil)
                self.lbName5.text = permodel.bleName;
            else
                self.lbName5.text = permodel.perName;
//            self.lbUUID5.text = permodel.UUID;
            break;
        case 6:
            if(permodel.bleName!=nil)
                self.lbName6.text = permodel.bleName;
            else
                self.lbName6.text = permodel.perName;
//            self.lbUUID6.text = permodel.UUID;
            break;
            
        default:
            break;
    }
    
    clickButtonNumber=0;
}


- (void)leveyPopListViewDidCancel
{
    [ActiveSender setOn:NO];
    ActiveSender = nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailController *del= [[DetailController alloc]initWithDelegate:self];
    
    
    if(indexPath.row == 0){
        for (PeripheralModel *m in self.connectperipherals) {
            if(m.switchNumber==0)
            {
                del.permodel = m;
                del.isOnOff = m.isOnOff;
            }
        }
        
        if(del.permodel!=nil){
            
            [MainMusicViewController sharedInstance].canWork=NO;
            [self.navigationController pushViewController:del
                                                 animated:NO];}
    }
    else if(indexPath.row ==1)
    {
        for (PeripheralModel *m in self.connectperipherals) {
            if(m.switchNumber==1)
            {
                del.permodel = m;
                del.isOnOff = m.isOnOff;
            }
        }
        if(del.permodel!=nil){
             [MainMusicViewController sharedInstance].canWork=NO;
            
            [self.navigationController pushViewController:del
                                                 animated:YES];
        }
        
    }
    else if(indexPath.row ==2)
    {
        for (PeripheralModel *m in self.connectperipherals) {
            if(m.switchNumber==2)
            {
                del.permodel = m;
                del.isOnOff = m.isOnOff;
            }
        }
        if(del.permodel!=nil){
            [MainMusicViewController sharedInstance].canWork=NO;
            
            [self.navigationController pushViewController:del
                                                 animated:YES];
        }
    }
    else if(indexPath.row ==3)
    {
        for (PeripheralModel *m in self.connectperipherals) {
            if(m.switchNumber==3)
            {
                del.permodel = m;
                del.isOnOff = m.isOnOff;
            }
        }
        if(del.permodel!=nil){
            [MainMusicViewController sharedInstance].canWork=NO;
            
            [self.navigationController pushViewController:del
                                                 animated:YES];
        }
    }
    else if(indexPath.row ==4)
    {
        for (PeripheralModel *m in self.connectperipherals) {
            if(m.switchNumber==4)
            {
                del.permodel = m;
                del.isOnOff = m.isOnOff;
            }
        }
        if(del.permodel!=nil){
            [MainMusicViewController sharedInstance].canWork=NO;
            
            [self.navigationController pushViewController:del
                                                 animated:YES];
        }
    }
    else if(indexPath.row ==5)
    {
        for (PeripheralModel *m in self.connectperipherals) {
            if(m.switchNumber==5)
            {
                del.permodel = m;
                del.isOnOff = m.isOnOff;
            }
        }
        if(del.permodel!=nil){
            [MainMusicViewController sharedInstance].canWork=NO;
            
            [self.navigationController pushViewController:del
                                                 animated:YES];
        }
    }
}


-(void)clicked:(BOOL)isFront
{
    // When using GPUImage, put [self.videoCamera rotateCamera]; here,
    // Otherwise do:
    NSData *d;
    if (!isFront) {
        self.isAllLightOn = YES;
        char b[] = {0x00,0x00,0x00,0xFF,0x64};
        d = [[NSData alloc] initWithBytes:b length:sizeof(b)];
    }
    else {
        self.isAllLightOn = NO;
        Byte b[] = {0x00,0x00,0x00,0x00,0x00};
        d = [[NSData alloc] initWithBytes:b length:sizeof(b) ];
    }
    
    for (PeripheralModel *p in self.connectperipherals) {
        if(p!=nil)
        {
            [p.peripheral writeValue:d forCharacteristic:p.characteristic1 type:CBCharacteristicWriteWithResponse];
            
            p.isOnOff = self.isAllLightOn;
        }
    }
}


-(IBAction)LightAllClick:(id)sender{
    NSData *d;
    
    if(!self.isAllLightOn)
    {
        Byte b[] = {0x00,0x00,0x00,0xFF,0x64};
        d =[[NSData alloc] initWithBytes:b length:5];
        self.isAllLightOn = YES;
        
        [sender setBackground:[UIImage imageNamed:@"poweroff.png"]];
//        [self.btnLightAll setImage:[UIImage imageNamed:@"lightOn.png"] forState:UIControlStateNormal];
    }
    else
    {
        Byte b[] = {0x00,0x00,0x00,0x00,0x00};
        d = [[NSData alloc] initWithBytes:b length:5];
        self.isAllLightOn = NO;
        [sender setBackground:[UIImage imageNamed:@"poweron.png"]];
//        [self.btnLightAll setImage:[UIImage imageNamed:@"lightOff.png"] forState:UIControlStateHighlighted];
    }
    
    for (PeripheralModel *p in self.connectperipherals) {
        if(p!=nil)
        {
            [p.peripheral writeValue:d forCharacteristic:p.characteristic1 type:CBCharacteristicWriteWithResponse];
            
            p.isOnOff = self.isAllLightOn;
        }
    }
}



-(IBAction)Lamp1Click:(id)sender{
    if([sender isOn])
    {
        ActiveSender = sender;
        clickButtonNumber=1;
        [self showListView];
    }
    else
    {
        clickButtonNumber = 0;
        
        for (PeripheralModel *m in self.connectperipherals) {
            if(m.switchNumber==0)
            {
                [ble.centralManager cancelPeripheralConnection:m.peripheral];
        
                [self.connectperipherals removeObject:m];
                
                self.lbName1.text = @"No BLE Light";
                break;
            }
        }
        [lplv removeFromView:self.view];
        isScan=true;
    }
}


-(IBAction)Lamp2Click:(id)sender{
    if([sender isOn])
    {
        ActiveSender = sender;
        clickButtonNumber=2;
        [self showListView];
    }
    else
    {
        clickButtonNumber = 0;
        
        for (PeripheralModel *m in self.connectperipherals) {
            if(m.switchNumber==1)
            {
                [ble.centralManager cancelPeripheralConnection:m.peripheral];
                
                [self.connectperipherals removeObject:m];
                
                self.lbName2.text = @"No BLE Light";
                break;
            }
        }
        [lplv removeFromView:self.view];
        isScan=true;
    }
}

-(IBAction)Lamp3Click:(id)sender{
    if([sender isOn])
    {
        ActiveSender = sender;
        clickButtonNumber=3;
        [self showListView];
    }
    else
    {
        clickButtonNumber = 0;
        
        for (PeripheralModel *m in self.connectperipherals) {
            if(m.switchNumber==2)
            {
                [ble.centralManager cancelPeripheralConnection:m.peripheral];
                
                [self.connectperipherals removeObject:m];
                
                self.lbName3.text = @"No BLE Light";
                break;
            }
        }
        
        [lplv removeFromView:self.view];
        isScan=true;
    }
}

-(IBAction)Lamp4Click:(id)sender{
    if([sender isOn])
    {
        ActiveSender = sender;
        clickButtonNumber=4;
        [self showListView];
    }
    else
    {
        clickButtonNumber = 0;
        
        for (PeripheralModel *m in self.connectperipherals) {
            if(m.switchNumber==3)
            {
                [ble.centralManager cancelPeripheralConnection:m.peripheral];
                
                [self.connectperipherals removeObject:m];
                
                self.lbName4.text = @"No BLE Light";
                break;
            }
        }
        
        [lplv removeFromView:self.view];
        isScan=true;
    }
}

-(IBAction)Lamp5Click:(id)sender{
    if([sender isOn])
    {
        ActiveSender = sender;
        clickButtonNumber=5;
        [self showListView];
    }
    else
    {
        clickButtonNumber = 0;
        
        for (PeripheralModel *m in self.connectperipherals) {
            if(m.switchNumber==4)
            {
                [ble.centralManager cancelPeripheralConnection:m.peripheral];
                
                [self.connectperipherals removeObject:m];
                
                self.lbName5.text = @"No BLE Light";
                break;
            }
        }
        
        [lplv removeFromView:self.view];
        isScan=true;
    }
}

-(IBAction)Lamp6Click:(id)sender{
    if([sender isOn])
    {
        ActiveSender = sender;
        clickButtonNumber=6;
        [self showListView];
    }
    else
    {
        clickButtonNumber = 0;
        
        for (PeripheralModel *m in self.connectperipherals) {
            if(m.switchNumber==5)
            {
                [ble.centralManager cancelPeripheralConnection:m.peripheral];
                
                [self.connectperipherals removeObject:m];
                
                self.lbName6.text = @"No BLE Light";
                break;
            }
        }
        
        [lplv removeFromView:self.view];
        isScan=true;
    }
}

-(IBAction)HelpButtonClick:(id)sender
{

}

-(IBAction)AddButtonClick:(id)sender
{
    
}
@end
