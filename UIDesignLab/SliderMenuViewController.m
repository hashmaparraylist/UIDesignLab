//
//  SliderMenuViewController.m
//  UIDesignLab
//
//  Created by 瞿盛 on 15/6/9.
//  Copyright (c) 2015年 Sebastian Qu. All rights reserved.
//

#import "SliderMenuViewController.h"

@interface SliderMenuViewController ()

@end

@implementation SliderMenuViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Custom Accessors

#pragma mark - IBActions

- (IBAction)close:(id)sender {
  [self.delegate closeSliderMenu];
}

#pragma mark - Public

#pragma mark - Private

@end
