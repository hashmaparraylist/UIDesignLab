//
//  ViewController.m
//  UIDesignLab
//
//  Created by Sebastian Qu on 15/6/7.
//  Copyright (c) 2015年 Sebastian Qu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *demoOne;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.demoOne.layer.borderWidth = .5f;
  self.demoOne.layer.borderColor = [[UIColor blueColor] CGColor];
  [self.demoOne.layer setCornerRadius:5.0];
  self.demoOne.layer.masksToBounds = YES;
}


@end
