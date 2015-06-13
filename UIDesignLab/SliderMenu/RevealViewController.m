//
//  RevealViewController.m
//  UIDesignLab
//
//  Created by Sebastian Qu on 15/6/10.
//  Copyright (c) 2015年 Sebastian Qu. All rights reserved.
//

#import "RevealViewController.h"
#import "MenuTableViewController.h"
#import "SliderMenuViewController.h"

@interface RevealViewController ()

@end

@implementation RevealViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  self.centerController = (SliderMenuViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
  self.leftController = (MenuTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
  
  [self.view addSubview:self.centerController.view];
  [self.centerController.view setTag:1];
  [self.centerController.view setFrame:self.view.bounds];
  
  [self.view addSubview:self.leftController.view];
  [self.leftController.view setTag:2];
  [self.leftController.view setFrame:self.view.bounds];
  
  [self.view bringSubviewToFront:self.centerController.view];
  
  // 添加右移滑动手势
  UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
  [swipeGestureRight setDirection:UISwipeGestureRecognizerDirectionRight];
  [self.centerController.view addGestureRecognizer:swipeGestureRight];

  // 添加左移滑动手势
  UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
  [swipeGestureLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
  [self.centerController.view addGestureRecognizer:swipeGestureLeft];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

#pragma mark - Public

#pragma mark - Private

-(void)swipeGesture:(UISwipeGestureRecognizer *)swipeGesture {
  CALayer *layer = [self.centerController.view layer];
  layer.shadowColor = [[UIColor blackColor] CGColor];
  layer.shadowOffset = CGSizeMake(1, 1);
  layer.shadowOpacity = 1;
  layer.shadowRadius = 20.0;
  
  
  if (swipeGesture.direction == UISwipeGestureRecognizerDirectionRight) {
    [self.leftController.view setHidden:NO];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
  
    if (self.centerController.view.frame.origin.x == self.view.frame.origin.x) {
      [self.centerController.view setFrame:CGRectMake(self.centerController.view.frame.origin.x + 100, self.centerController.view.frame.origin.y, self.centerController.view.frame.size.width, self.centerController.view.frame.size.height)];
    }
    
    [UIView commitAnimations];
  }
  
  if (swipeGesture.direction == UISwipeGestureRecognizerDirectionLeft) {
    [self.leftController.view setHidden:YES];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    if (self.centerController.view.frame.origin.x == 100) {
      [self.centerController.view setFrame:CGRectMake(self.centerController.view.frame.origin.x-100, self.centerController.view.frame.origin.y, self.centerController.view.frame.size.width, self.centerController.view.frame.size.height)];
    }
    
    [UIView commitAnimations];
  }
  
}

@end
