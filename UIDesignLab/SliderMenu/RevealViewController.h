//
//  RevealViewController.h
//  UIDesignLab
//
//  Created by Sebastian Qu. on 15/6/10.
//  Copyright (c) 2015年 Sebastian Qu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SliderMenuViewController;
@class MenuTableViewController;

typedef NS_ENUM(NSInteger, SlideOutState) {
  BothCollapsed,
  LeftPanelExpanded,
  RightPanelExpanded,
};

@interface RevealViewController : UIViewController

@property (nonatomic, strong) MenuTableViewController *leftController;
@property (nonatomic, strong) SliderMenuViewController *centerController;
@property (nonatomic, strong) UINavigationController *centerNavigationController;
@property (nonatomic, assign) SlideOutState currentState;

@end
