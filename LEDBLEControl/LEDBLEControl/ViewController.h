//
//  ViewController.h
//  LEDBLEControl
//
//  Created by Developer on 14/12/2.
//  Copyright (c) 2014年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import "RSCameraRotator.h"
#import "LeveyPopListView.h"
#import "PerModel.h"
#import "SettingsHelper.h"
#import "BLEHelper.h"
#import "DetailController.h"

@class DetailViewController;



@interface ViewController : UITableViewController<UIApplicationDelegate, LeveyPopListViewDelegate,MyDelegate,RSCameraRotatorDelegate,DetailControllerDelegate>
{
    BOOL buttonState;
}


-(IBAction)LightAllClick:(id)sender;
-(IBAction)Lamp1Click:(id)sender;
-(IBAction)Lamp2Click:(id)sender;
-(IBAction)Lamp3Click:(id)sender;
-(IBAction)Lamp4Click:(id)sender;
-(IBAction)Lamp5Click:(id)sender;
-(IBAction)Lamp6Click:(id)sender;
-(IBAction)HelpButtonClick :(id)sender;
-(IBAction)AddButtonClick:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tableview1;
@property (strong, nonatomic) IBOutlet UILabel *lbName1;
@property (strong, nonatomic) IBOutlet UILabel *lbName2;
@property (strong, nonatomic) IBOutlet UILabel *lbName3;
@property (strong, nonatomic) IBOutlet UILabel *lbName4;
@property (strong, nonatomic) IBOutlet UILabel *lbName5;
@property (strong, nonatomic) IBOutlet UILabel *lbName6;

@property (strong, nonatomic) SettingsHelper *BLENameHelper;
@property (strong, nonatomic) NSMutableArray *options;
@property (strong, nonatomic) NSMutableArray *connectperipherals;
@property (strong, nonatomic) NSMutableArray *scansperipherals;
@property (strong, nonatomic) id ActiveSender;
@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) LeveyPopListView *lplv;

@property (nonatomic, strong) RSCameraRotator *LightOnOff;
@property (nonatomic, strong) HYActivityView *activityView;

@property (strong,nonatomic) BLEHelper *ble;

@property Boolean isAllLightOn;

@end
