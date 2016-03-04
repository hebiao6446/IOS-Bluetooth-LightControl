//
//  UtilFunction.h
//  LEDBLEControl
//
//  Created by hebiao on 15-6-29.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilFunction : NSObject



//// 播放歌曲获取随机歌曲， 前一曲 ， 后一曲 

+(NSDictionary *)getPrevDic:(NSDictionary *)data inArray:(NSArray *)arr;
+(NSDictionary *)getNextDic:(NSDictionary *)data inArray:(NSArray *)arr;
+(NSDictionary *)getRandomDic:(NSArray *)arr;




 




@end
