//
//  FFKeyboardConstraintHandler.h
//  Fonts
//
//  Created by Florian Friedrich on 15.7.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

@import Foundation;

@interface FFKeyboardConstraintHandler : NSObject

@property (nonatomic, strong) NSLayoutConstraint *constraint;
@property (nonatomic, strong) UIView *containingView;

- (instancetype)initWithConstraint:(NSLayoutConstraint *)constraint containingView:(UIView *)view;

@end
