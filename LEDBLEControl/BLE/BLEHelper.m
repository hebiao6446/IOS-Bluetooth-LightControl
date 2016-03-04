//
//  BLEHelper.m
//  LEDBLEControl
//
//  Created by Developer on 14/12/12.
//  Copyright (c) 2014年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLEHelper.h"


@implementation BLEHelper
@synthesize mutableData;
@synthesize peripheral;
@synthesize characteristic1;
@synthesize characteristic2;
@synthesize characteristic3;
@synthesize scansperipherals;
@synthesize scanCount;

-(void)Start
{
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}


- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSMutableString* nsmstring=[NSMutableString stringWithString:@"UpdateState:"];
    
    switch (central.state)
    {
            //判断状态开始扫瞄周围设备 第一个参数为空则会扫瞄所有的可连接设备  你可以
            //指定一个CBUUID对象 从而只扫瞄注册用指定服务的设备
            //scanForPeripheralsWithServices方法调用完后会调用代理CBCentralManagerDelegate的
            //- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI方法
        case CBCentralManagerStateUnknown:
            [nsmstring appendString:@"Unknown\n"];
            break;
        case CBCentralManagerStateUnsupported:
            [nsmstring appendString:@"Unsupported\n"];
            break;
        case CBCentralManagerStateUnauthorized:
            [nsmstring appendString:@"Unauthorized\n"];
            break;
        case CBCentralManagerStateResetting:
            [nsmstring appendString:@"Resetting\n"];
            break;
        case CBCentralManagerStatePoweredOn:
            [nsmstring appendString:@"PoweredOn\n"];
            //扫描  如果为nil代表扫描任何范围
            break;
            
        case CBCentralManagerStatePoweredOff:
            [nsmstring appendString:@"PoweredOff\n"];
            break;
            
        default:
            [nsmstring appendString:@"none\n"];
            break;
    }
    
    NSLog(@"%@",nsmstring);
}

-(void)ScanPeripherals
{
    if(self.centralManager!=nil)
        [self.centralManager scanForPeripheralsWithServices:nil options:    @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
    scansperipherals = [[NSMutableArray alloc] init];
    scanCount = 0;
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)_peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    //停止扫描周边
    if(scanCount>50)
        [self.centralManager stopScan];
    for (CBPeripheral *p in scansperipherals) {
        if (p.identifier == _peripheral.identifier) {
            scanCount++;
            return;
        }
    }
    [scansperipherals addObject:_peripheral];
    [_mydelegate GetPeripheral:_peripheral];
}

-(void)connect:(CBPeripheral *)_peripheral
{
    [self.centralManager connectPeripheral:_peripheral options:nil];
}


- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)_peripheral
{
    self.peripheral = _peripheral;
    [_peripheral setDelegate:self];
    
    [_peripheral discoverServices:@[[CBUUID UUIDWithString:@"0xFFF0"]]];
}


- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    //此时连接发生错误
    NSLog(@"connected periphheral failed.");
}

- (void)peripheral:(CBPeripheral *)aPeripheral didDiscoverServices:(NSError *)error
{
    if(error)
    {
        NSLog(@"ERROR discovering service:%@",[error localizedDescription]);
        //[self cleanup];
        return;
    }
    
    //在这个方法中我们要查找到我们需要的服务  然后调用discoverCharacteristics方法查找我们需要的特性
    //该discoverCharacteristics方法调用完后会调用代理CBPeripheralDelegate的
    //- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
    for (CBService *service in aPeripheral.services)
    {
        NSLog(@"Service found with UUID:%@",service.UUID);
        //发现给定服务的特点
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF0"]])
        {
            [aPeripheral discoverCharacteristics:nil forService:service];
        }
    }
    
}

-(void)peripheral:(CBPeripheral *)aPeripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if(error)
    {
        NSLog(@"ERROR discovering Characteristic:%@",[error localizedDescription]);
        //[self cleanup];
        return;
    }
    
    self.peripheral = aPeripheral;
    
    //在这个方法中我们要找到我们所需的服务的特性 然后调用setNotifyValue方法告知我们要监测这个服务特性的状态变化
    //当setNotifyValue方法调用后调用代理CBPeripheralDelegate的
    //- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    // if([service.UUID isEqual:[CBUUID UUIDWithString:kServiceUUID]])
    // {
    for(CBCharacteristic *characteristic in service.characteristics)
    {
        if([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF1"]])
            characteristic1 = characteristic;
        else if([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF2"]])
            characteristic2 = characteristic;
        else if([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF3"]])
            characteristic3 = characteristic;
    }
    
    [_mydelegate GetBLE];
}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
}


-(void)peripheral:(CBPeripheral *)aPeripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if(error)
    {
        NSLog(@"ERROR changing notification state:%@",[error localizedDescription]);
    }
    //如果不退出传输特性
    //if(![characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUID]])
    //{
    //   return;
    //}
    //调用下面的方法后 会调用到代理的
    //- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    //通知已经开始
    //if(characteristic.isNotifying)
    //{
    //    NSLog(@"Notification began on %@",characteristic);
    //    [aPeripheral readValueForCharacteristic:characteristic];
    //}
    //else
    //{
        //通知已经停止
        //所以从外围断开
        //NSLog(@"Notification stopped on %@.Disconnecting",characteristic);
        //[self.centralManager cancelPeripheralConnection:self.peripheral];
    //}
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
}


@end
