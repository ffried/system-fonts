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

NS_ASSUME_NONNULL_BEGIN

extern FFMainViewController  * _Nullable FFFindMainViewController(UIViewController *vc);

@interface FFMainViewController : UIViewController

@property (nonatomic, weak, nullable) IBOutlet FFStatusBarView *statusBarView;
@property (nonatomic, weak, nullable) IBOutlet UIView *containerView;

@end

NS_ASSUME_NONNULL_END
