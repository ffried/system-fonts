//
//  FFMainViewController.m
//  Fonts
//
//  Created by Florian Friedrich on 15.7.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFMainViewController.h"

FFMainViewController *FFFindMainViewController(UIViewController *vc) {
    UIViewController *parent = vc.parentViewController;
    while (parent) {
        if ([parent isKindOfClass:[FFMainViewController class]]) {
            return (FFMainViewController *)parent;
        }
        parent = parent.parentViewController;
    }
    return nil;
}

@implementation FFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.statusBarView setHidden:YES];
}

@end
