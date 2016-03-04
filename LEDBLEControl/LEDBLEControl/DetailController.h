//
//  UIViewController+DetailController.h
//  LEDBLEControl
//
//  Created by Developer on 14/12/2.
//  Copyright (c) 2014年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSColorPickerView.h"
#import "RSBrightnessSlider.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "PerModel.h"
#import "TimeModelController.h"
#import "TitleViewControl.h"
@protocol DetailControllerDelegate

@optional
- (void) submitChange:(PeripheralModel*) value;
@end

@interface DetailController :UIViewController <UIApplicationDelegate, RSColorPickerViewDelegate,RSCameraRotatorDelegate,TitleViewControlDelegate>
{
    RSColorPickerView *colorPicker;
    RSBrightnessSlider *brightnessSlider;
    UIView *colorPatch;
    UIView *colorPickerRadius;
    TimeModelController *timeView;
    NSObject <DetailControllerDelegate> *delegate;
}
- (id) initWithDelegate: (NSObject <DetailControllerDelegate>*)detailControllerDelegate;

@property (nonatomic, strong) NSDate *time;
@property (nonatomic, strong) TimeModelController *timeView;
@property (nonatomic, assign) int style;
@property (strong, nonatomic) NSArray *options;
@property (strong,nonatomic) PeripheralModel *permodel;
@property Boolean isOnOff;
@property (nonatomic, strong) RSCameraRotator *LightOnOff;
@property (nonatomic, strong) HYActivityView *activityView;

@end
