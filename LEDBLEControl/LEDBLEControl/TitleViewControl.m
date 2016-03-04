//
//  UIView+TitleView.m
//  LEDBLEControl
//
//  Created by Developer on 15/1/5.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import "TitleViewControl.h"

@implementation TitleViewControl:UIView


- (id) initWithTitleText:(NSString *)titleText titlesize:(CGSize)titlesize delegate:(NSObject<TitleViewControlDelegate> *)titleViewControlDelegate
{
    if (self = [super init])
    {
        // Set the delegate
        delegate = titleViewControlDelegate;
        
        // Adjust our width based on the number of segments & the width of each segment and the sepearator
        self.frame = CGRectMake(0, 0, titlesize.width, titlesize.height);
        
        self.titleTextField = [[UITextField alloc]init];
        self.titleTextField.text = titleText;
        self.titleTextField.textColor = [UIColor whiteColor];
        self.titleTextField.textAlignment = UIControlContentHorizontalAlignmentCenter; 
        self.titleTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.titleTextField.frame = self.frame;
        self.titleTextField.keyboardType = UIKeyboardTypeDefault;
        self.titleTextField.keyboardAppearance = UIKeyboardAppearanceAlert;
        self.titleTextField.returnKeyType = UIReturnKeySend;
        self.titleTextField.delegate = self;
        
        [self addSubview:self.titleTextField];
    }
    
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.titleTextField resignFirstResponder];
    [delegate submitChange:self.titleTextField.text];
    return YES;
}

@end
