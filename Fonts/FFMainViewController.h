//
//  FFMainViewController.h
//  Fonts
//
//  Created by Florian Friedrich on 15.7.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

@import UIKit;
#import "FFStatusBarView.h"

@class FFMainViewController;
extern FFMainViewController *FFFindMainViewController(UIViewController *vc);

@interface FFMainViewController : UIViewController

@property (nonatomic, weak) IBOutlet FFStatusBarView *statusBarView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
