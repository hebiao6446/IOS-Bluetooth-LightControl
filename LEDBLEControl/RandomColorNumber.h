//
//  RandomColorNumber.h
//  LEDBLEControl
//
//  Created by hebiao on 15-7-11.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>



// 获取渐变的随机颜色

@interface RandomColorNumber : NSObject


-(void)resetRandom;
-(void)resetStep;

-(NSDictionary *)getRandomColor;

@end
