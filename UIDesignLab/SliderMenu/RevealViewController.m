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

#define OFFSET 60

@interface RevealViewController () <SliderMenuViewControllerDelegate>

@end

@implementation RevealViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.centerNavigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
  self.centerController = (SliderMenuViewController *)self.centerNavigationController.topViewController;
  self.centerController.delegate = self;
  
  [self.view addSubview:self.centerNavigationController.view];
  [self addChildViewController:self.centerNavigationController];
  
  [self.centerNavigationController didMoveToParentViewController:self];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

#pragma mark - Public

#pragma mark - Private

- (void)addChildSidePannelController:(MenuTableViewController *) sidePannelController {
  [self.view insertSubview:sidePannelController.view atIndex:0];
  [self addChildViewController:sidePannelController];
  [sidePannelController didMoveToParentViewController:self];
}

- (void) animateCenterPannelXPostion:(CGFloat) targetPostion completion:(void (^)(BOOL finished)) completion {
  [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//    self.centerNavigationController.view.frame.origin
    CGRect frame = self.centerNavigationController.view.frame;
    frame.origin.x = targetPostion;
    [self.centerNavigationController.view setFrame:frame];
  } completion:completion];
}

- (BOOL) isLeftMenuAlreadyExpanded {
  return (self.centerNavigationController.view.frame.origin.x != 0);
}

#pragma mark - SliderMenuViewControllerDelegate

-(void)closeViewController {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)toggleLeftMenu {
  BOOL notAlreadyExpanded = ![self isLeftMenuAlreadyExpanded];
  if (notAlreadyExpanded) {
    [self addLeftMenuViewController];
  }
  [self animatedLeftMenu:notAlreadyExpanded];
}

- (void)addLeftMenuViewController {
  if (self.leftController == nil) {
    self.leftController = (MenuTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    [self addChildSidePannelController:self.leftController];
  }
}

- (void)animatedLeftMenu:(BOOL)shouldExpand {
  if (shouldExpand) {
    [self animateCenterPannelXPostion:CGRectGetWidth(self.centerNavigationController.view.frame) - OFFSET completion:nil];
  } else {
    [self animateCenterPannelXPostion:0 completion:^(BOOL finished) {
      [self.leftController.view removeFromSuperview];
      self.leftController = nil;
    }];
  }
}
@end
