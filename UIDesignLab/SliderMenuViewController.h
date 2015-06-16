//
//  SliderMenuViewController.h
//  UIDesignLab
//
//  Created by Sebastian Qu. on 15/6/9.
//  Copyright (c) 2015年 Sebastian Qu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SliderMenuViewControllerDelegate <NSObject>
-(void)closeViewController;
-(void)toggleLeftMenu;
-(void)addLeftMenuViewController;
-(void)animatedLeftMenu:(BOOL) shouldExpand;
@end

@class MenuTableViewController;

@interface SliderMenuViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIBarButtonItem *menuButton;
@property (nonatomic, weak) NSObject<SliderMenuViewControllerDelegate> *delegate;
@end
