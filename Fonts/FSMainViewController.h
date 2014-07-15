//
//  FSMainViewController.h
//  Fonts
//
//  Created by Florian Friedrich on 15.7.14.
//  Copyright (c) 2014 FrieSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSStatusBarView.h"

@class FSMainViewController;
extern FSMainViewController *FSFindMainViewController(UIViewController *vc);

@interface FSMainViewController : UIViewController

@property (nonatomic, weak) IBOutlet FSStatusBarView *statusBarView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
