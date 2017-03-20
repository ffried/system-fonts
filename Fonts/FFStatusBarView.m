//
//  FFStatusBarView.m
//  Fonts
//
//  Created by Florian Friedrich on 15.7.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "FFStatusBarView.h"

@interface FFStatusBarView ()
@property (nonatomic, strong) UIToolbar *blurBar;
@end

@implementation FFStatusBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:blurView];
    NSDictionary *views = @{@"blurView": blurView};
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[blurView]|" options:kNilOptions metrics:nil views:views];
    [self addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[blurView]|" options:kNilOptions metrics:nil views:views];
    [self addConstraints:constraints];
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated {
    if (!animated) return [self setHidden:hidden];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = (hidden) ? 0.0f : 1.0f;
    }];
}

@end
