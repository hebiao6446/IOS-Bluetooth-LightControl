//
//  RandomColorNumber.m
//  LEDBLEControl
//
//  Created by hebiao on 15-7-11.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import "RandomColorNumber.h"






@implementation RandomColorNumber

int rColor=0;
int gColor=0;
int bColor=0;

int step=1;

-(void)resetRandom{
    
      rColor=0;
      gColor=0;
      bColor=0;
}
-(void)resetStep{
    
    step=arc4random()%25;
   
    
}




-(NSDictionary *)getRandomColor{
    //    return [self getRandomColor:NO];
    
    
    int r= arc4random()%256;
    int g= arc4random()%256;
    int b= arc4random()%256;
    
    if (rColor+gColor+bColor==0) {
        rColor=r;
        gColor=g;
        bColor=b;
    }
    
    
//    if (step<1||step>5) {
//        step=1;
//    }
    
    rColor=rColor+step;
     gColor=gColor+step;
    bColor=bColor+step;
    
    
    if (rColor>=255) {
        rColor=0;
    }
    
    if (gColor>=255) {
        gColor=0;
    }
    if (bColor>=255) {
        bColor=0;
    }
    
    
    
    return @{@"r":@(rColor),@"g":@(gColor),@"b":@(bColor)};
    
}

@end
