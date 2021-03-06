//
//  FFKeyboardConstraintHandler.m
//  Fonts
//
//  Created by Florian Friedrich on 15.7.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFKeyboardConstraintHandler.h"

@implementation FFKeyboardConstraintHandler

- (instancetype)initWithConstraint:(NSLayoutConstraint *)constraint containingView:(UIView *)view {
    self = [super init];
    if (self) {
        self.constraint = constraint;
        self.containingView = view;
        [self addKeyboardObservers];
    }
    return self;
}

- (instancetype)init { return [self initWithConstraint:nil containingView:nil]; }

- (void)dealloc {
    [self removeKeyboardObservers];
}

- (void)addKeyboardObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrame:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}

- (void)removeKeyboardObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
}

#pragma mark - Notification handling
- (void)keyboardWillShow:(NSNotification *)note {
}

- (void)keyboardDidShow:(NSNotification *)note {
}

- (void)keyboardWillHide:(NSNotification *)note {
}

- (void)keyboardDidHide:(NSNotification *)note {
}

- (void)keyboardWillChangeFrame:(NSNotification *)note {
    NSTimeInterval duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIViewAnimationOptions options = (UIViewAnimationOptionBeginFromCurrentState |
                                      UIViewAnimationOptionAllowAnimatedContent |
                                      UIViewAnimationOptionOverrideInheritedCurve |
                                      curve << 16);
    CGRect endFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat height = 0.0;
    if (self.containingView.window != nil) {
        UIWindow *window = self.containingView.window;
        CGRect windowFrame = [window convertRect:self.containingView.bounds fromView:self.containingView];
        CGRect keyboardFrame = CGRectIntersection(windowFrame, endFrame);
        CGRect coveredFrame = [window convertRect:keyboardFrame toView:self.containingView];
        height = coveredFrame.size.height;
    }
    [self.containingView layoutIfNeeded];
    [UIView animateWithDuration:duration delay:0.0 options:options animations:^{
        self.constraint.constant = height;
        [self.containingView layoutIfNeeded];
    } completion:^(BOOL finished) {}];
}

- (void)keyboardDidChangeFrame:(NSNotification *)note {
}

@end
