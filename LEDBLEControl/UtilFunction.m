//
//  UtilFunction.m
//  LEDBLEControl
//
//  Created by hebiao on 15-6-29.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import "UtilFunction.h"

@implementation UtilFunction







+(NSDictionary *)getPrevDic:(NSDictionary *)data inArray:(NSArray *)arr{
    if ([arr count]==0) {
        return nil;
    }
    
    if ([arr count]==1) {
        return arr[0];
    }
    
    if ([[arr firstObject] isEqualToDictionary:data]) {
        
        return [arr lastObject];
    }
    
    int index=0;
    for (int i=1; i<[arr count]; i++) {
        
        if ([arr[i] isEqualToDictionary:data]) {
            index=i;
            break;
        }
    }
    
    
    return arr[index-1];
    
    
}
+(NSDictionary *)getNextDic:(NSDictionary *)data inArray:(NSArray *)arr{
    if ([arr count]==0) {
        return nil;
    }
    
    if ([arr count]==1) {
        return arr[0];
    }
    
    if ([[arr lastObject] isEqualToDictionary:data]) {
        
        return [arr firstObject];
    }
    
    
    int index=0;
    for (int i=0; i<[arr count]-1; i++) {
        
        if ([arr[i] isEqualToDictionary:data]) {
            index=i;
            break;
        }
    }
    
    
    return arr[index+1];
    
}
+(NSDictionary *)getRandomDic:(NSArray *)arr{
    if ([arr count]==0) {
        return nil;
    }
    
    if ([arr count]==1) {
        return arr[0];
    }
    
    
    
    
    
    return arr[arc4random()%[arr count]];
    
    
}




@end
