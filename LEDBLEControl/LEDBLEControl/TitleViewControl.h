//
//  UIView+TitleView.h
//  LEDBLEControl
//
//  Created by Developer on 15/1/5.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TitleViewControl;
@protocol TitleViewControlDelegate

@optional
- (void) submitChange:(NSString *) value;
@end

@interface TitleViewControl:UIView<UITextFieldDelegate>
{
    NSObject <TitleViewControlDelegate> *delegate;
}

- (id) initWithTitleText:(NSString*)titleText titlesize:(CGSize)titlesize delegate:(NSObject <TitleViewControlDelegate>*)titleViewControlDelegate;

@property (strong, nonatomic) IBOutlet UITextField *titleTextField;

@end
