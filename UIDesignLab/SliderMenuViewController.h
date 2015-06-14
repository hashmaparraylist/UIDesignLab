//
//  SliderMenuViewController.h
//  UIDesignLab
//
//  Created by 瞿盛 on 15/6/9.
//  Copyright (c) 2015年 Sebastian Qu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SliderMenuViewControllerDelegate <NSObject>
-(void)closeSliderMenu;
@end

@interface SliderMenuViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIBarButtonItem *menuButton;
@property (nonatomic, weak) NSObject<SliderMenuViewControllerDelegate> *delegate;

@end
