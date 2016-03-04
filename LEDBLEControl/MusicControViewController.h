//
//  MusicControViewController.h
//  LEDBLEControl
//
//  Created by hebiao on 15-6-17.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicControViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    
    UITableView *table;
    
    
    BOOL mainPower;
    
    
    NSMutableArray *switchList;
    
    UISwitch *switchView1,*switchView2,*switchView3,*switchView4,*switchView5,*switchView6;
    
}

@property BOOL lightStatus;

//@property (strong,nonatomic) NSArray *permodelArray;

@end
