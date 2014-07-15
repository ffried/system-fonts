//
//  FSStatusBarView.m
//  Fonts
//
//  Created by Florian Friedrich on 15.7.14.
//  Copyright (c) 2014 FrieSoft. All rights reserved.
//

#import "FSStatusBarView.h"

@interface FSStatusBarView ()
@property (nonatomic, strong) UIToolbar *blurBar;
@end

@implementation FSStatusBarView

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
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
#ifdef __IPHONE_8_0
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:blurView];
        NSDictionary *views = @{@"blurView": blurView};
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[blurView]|" options:kNilOptions metrics:nil views:views];
        [self addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[blurView]|" options:kNilOptions metrics:nil views:views];
        [self addConstraints:constraints];
#endif
    } else {
        self.blurBar = [[UIToolbar alloc] initWithFrame:self.bounds];
        [self.layer insertSublayer:self.blurBar.layer atIndex:0];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated {
    if (!animated) return [self setHidden:hidden];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = (hidden) ? 0.0f : 1.0f;
    }];
}

@end
