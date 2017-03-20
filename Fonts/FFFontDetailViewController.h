//
//  FFFontViewController.h
//  Fonts
//
//  Created by Florian Friedrich on 24.10.13.
//  Copyright (c) 2013 Florian Friedrich. All rights reserved.
//

@import Foundation;
@class FFFont;

@interface FFFontDetailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UITextView *fontPreview;

@property (nonatomic, weak) IBOutlet UIView *toolsBarView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *fontChanger;
@property (nonatomic, weak) IBOutlet UISegmentedControl *sizeChanger;
@property (nonatomic, weak) IBOutlet UIButton *resetButton;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *keyboardConstraint;

@property (nonatomic, strong) FFFont *font;

- (IBAction)switchFont:(UISegmentedControl *)sender;
- (IBAction)changeSize:(UISegmentedControl *)sender;
- (IBAction)resetToDefaults:(id)sender;

@end
