//
//  DataViewController.h
//  PageViewControllerTest
//
//  Created by Developer on 15/1/4.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet UIView *imgview;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imgName;
@property NSUInteger *pageindex;
@end

