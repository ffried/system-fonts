//
//  FSMainViewController.m
//  Fonts
//
//  Created by Florian Friedrich on 15.7.14.
//  Copyright (c) 2014 FrieSoft. All rights reserved.
//

#import "FSMainViewController.h"

FSMainViewController *FSFindMainViewController(UIViewController *vc) {
    UIViewController *parent = vc.parentViewController;
    while (parent) {
        if ([parent isKindOfClass:[FSMainViewController class]]) {
            return (FSMainViewController *)parent;
        }
        parent = parent.parentViewController;
    }
    return nil;
}

@implementation FSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.statusBarView setHidden:YES];
}

@end
