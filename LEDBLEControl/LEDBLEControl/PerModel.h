//
//  PerModel.h
//  LEDBLEControl
//
//  Created by Developer on 14/12/11.
//  Copyright (c) 2014年 Developer. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

@interface PeripheralModel : NSObject
{
    int switchNumber;
    NSString *perName;
    NSString *bleName;
    NSString *UUID;
    CBPeripheral *peripheral;
    Boolean isOnOff;
    CBCharacteristic *characteristic1;
    CBCharacteristic *characteristic2;
    CBCharacteristic *characteristic3;
}

@property int switchNumber;
@property (nonatomic,strong) NSString *perName;
@property (nonatomic,strong) NSString *bleName;
@property (nonatomic,strong) NSString *UUID;
@property (nonatomic,strong) CBPeripheral *peripheral;
@property (nonatomic) Boolean isOnOff;
@property (nonatomic,strong) CBCharacteristic *characteristic1;
@property (nonatomic,strong) CBCharacteristic *characteristic2;
@property (nonatomic,strong) CBCharacteristic *characteristic3;

@end
