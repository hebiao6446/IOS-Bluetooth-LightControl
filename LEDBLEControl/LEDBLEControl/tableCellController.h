//
//  UITableViewCell+tableCellController.h
//  LEDBLEControl
//
//  Created by Developer on 14/12/17.
//  Copyright (c) 2014年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerModel.h"

@interface tableCellController:UITableViewCell
{
    PeripheralModel *perModel;
}

@property (strong, nonatomic) PeripheralModel *perModel;

@property (strong, nonatomic) IBOutlet UILabel *lbName;
@property (strong, nonatomic) IBOutlet UILabel *lbUUID;
@property (strong, nonatomic) IBOutlet UISwitch *btnScan;
@end
