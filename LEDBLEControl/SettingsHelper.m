//
//  SettingsHelper.m
//  LEDBLEControl
//
//  Created by Developer on 14/12/25.
//  Copyright (c) 2014年 Developer. All rights reserved.
//

#define _PListName "BLEName"
#define _PListPath "/var/mobile/Documents/BLEName.plist"

#import <Foundation/Foundation.h>
#import "SettingsHelper.h"

@implementation SettingsHelper

-(void) AddValue:(NSString *)key Value:(NSString *)value
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"BLEName.plist"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    
    if(!success)
    {
        // The writable database does not exist, so copy the default to the appropriate location.
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"BLEName.plist"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    }
    
    NSMutableDictionary *data = [[[NSMutableDictionary alloc]initWithContentsOfFile:writableDBPath]mutableCopy];
    
//    NSLog(@"%@",data);
    
    NSString *name = [data objectForKey:key];
    name = value;
    [data setObject:name forKey:key];
    
//    NSLog(@"%@",data);
    
    success = [data writeToFile:writableDBPath atomically:YES];
    
//    data = [[[NSMutableDictionary alloc]initWithContentsOfFile:writableDBPath]mutableCopy];
//    NSLog(@"%@",data);
}



-(NSString *) GetValueByKey:(NSString *)key
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"BLEName.plist"];
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:writableDBPath];
    return [data valueForKey:key];
}

@end