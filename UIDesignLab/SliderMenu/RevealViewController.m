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

@interface RevealViewController () <SliderMenuViewControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation RevealViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // 添加主画面
  self.centerNavigationController = (UINavigationController *)[self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
  self.centerController = (SliderMenuViewController *)self.centerNavigationController.topViewController;
  self.centerController.delegate = self;
  
  [self.view addSubview:self.centerNavigationController.view];
  [self addChildViewController:self.centerNavigationController];
  
  [self.centerNavigationController didMoveToParentViewController:self];
  
  self.currentState = BothCollapsed;
  
  // 添加手势
  UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
  [self.centerNavigationController.view addGestureRecognizer:panGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Accessors

-(void)setCurrentState:(SlideOutState)currentState {
  _currentState = currentState;
  BOOL shouldShowShadow = (self.currentState != BothCollapsed);
  [self showShadowForCenterViewController:shouldShowShadow];
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

- (void)showShadowForCenterViewController:(BOOL)shouldShowShadow {
  if (shouldShowShadow) {
    self.centerNavigationController.view.layer.shadowOpacity = 0.8;
  } else {
    self.centerNavigationController.view.layer.shadowOpacity = 0;
  }
}

#pragma mark - UIGestureRecognizerDelegate

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer {
  BOOL gestureIsDraggingFromLeftToRight = ([recognizer velocityInView:self.view].x > 0);
  if (recognizer.state == UIGestureRecognizerStateBegan) {
    if (self.currentState == BothCollapsed) {
      if (gestureIsDraggingFromLeftToRight) {
        [self addLeftMenuViewController];
      }
      
      [self showShadowForCenterViewController:YES];
    }
  } else if (recognizer.state == UIGestureRecognizerStateChanged) {
    CGPoint center = recognizer.view.center;
    center.x = center.x + [recognizer translationInView:self.view].x;
    recognizer.view.center = center;
    [recognizer setTranslation:CGPointZero inView:self.view];
  } else if (recognizer.state == UIGestureRecognizerStateEnded) {
    if (self.leftController != nil) {
      BOOL hasMovedGreaterThanHalfway = recognizer.view.center.x > recognizer.view.bounds.size.width;
      [self animatedLeftMenu:hasMovedGreaterThanHalfway];
    }
  }
}


#pragma mark - SliderMenuViewControllerDelegate

-(void)closeViewController {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)toggleLeftMenu {
  BOOL notAlreadyExpanded = (self.currentState != LeftPanelExpanded);
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
    self.currentState = LeftPanelExpanded;
    [self animateCenterPannelXPostion:CGRectGetWidth(self.centerNavigationController.view.frame) - OFFSET completion:nil];
  } else {
    [self animateCenterPannelXPostion:0 completion:^(BOOL finished) {
      self.currentState = BothCollapsed;
      [self.leftController.view removeFromSuperview];
      self.leftController = nil;
    }];
  }
}
@end
