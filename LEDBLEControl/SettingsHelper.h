//
//  SettingsHelper.h
//  LEDBLEControl
//
//  Created by Developer on 14/12/25.
//  Copyright (c) 2014年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SettingsHelper:NSObject

-(void) AddValue:(NSString *) key Value:(NSString *) value;
-(NSString*) GetValueByKey:(NSString *) key ;

@end