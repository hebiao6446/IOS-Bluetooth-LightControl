//
//  BLEHelper.h
//  LEDBLEControl
//
//  Created by Developer on 14/12/12.
//  Copyright (c) 2014年 Developer. All rights reserved.
//

//引用
#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>


@protocol MyDelegate<NSObject>

-(void)GetBLE;
-(void) GetPeripheral:(CBPeripheral *)p;

@end


//遵守协议CBCentralManagerDelegate,CBPeripheralDelegate
@interface BLEHelper:NSObject<CBPeripheralDelegate,CBCentralManagerDelegate>

@property(nonatomic,retain) id<MyDelegate> mydelegate;
@property(nonatomic,strong) NSMutableData *mutableData;
@property(nonatomic,strong) CBPeripheral *peripheral;
@property (nonatomic, strong) CBCentralManager *centralManager;
@property(nonatomic,strong) CBCharacteristic *characteristic1;
@property(nonatomic,strong) CBCharacteristic *characteristic2;
@property(nonatomic,strong) CBCharacteristic *characteristic3;
@property (nonatomic, strong) NSMutableArray *scansperipherals;
@property int *scanCount;

-(void) Start;
-(void) ScanPeripherals;
-(void) connect:(CBPeripheral *)_peripheral;

@end
