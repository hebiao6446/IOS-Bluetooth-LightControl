//
//  DataViewController.m
//  PageViewControllerTest
//
//  Created by Developer on 15/1/4.
//  Copyright (c) 2015年 Developer. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataLabel.text = self.title;
    
    UIImage *img = [self reSizeImage:[UIImage imageNamed:self.imgName] toSize:self.imgview.frame.size];
    [self.imgview setBackgroundColor:[UIColor colorWithPatternImage:img]];
    [self.imgview setContentMode:UIViewContentModeScaleAspectFit];
    [self.imgview setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.imgview setClipsToBounds:YES];
    self.imgview.clipsToBounds = YES;
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}
@end
