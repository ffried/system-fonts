//
//  FSKeyboardConstraintHandler.h
//  Fonts
//
//  Created by Florian Friedrich on 15.7.14.
//  Copyright (c) 2014 FrieSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSKeyboardConstraintHandler : NSObject

@property (nonatomic, strong) NSLayoutConstraint *constraint;
@property (nonatomic, strong) UIView *containingView;

- (instancetype)initWithConstraint:(NSLayoutConstraint *)constraint containingView:(UIView *)view;

@end
