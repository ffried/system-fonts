//
//  FSFontViewController.m
//  Fonts
//
//  Created by Florian Friedrich on 24.10.13.
//  Copyright (c) 2013 FrieSoft. All rights reserved.
//

#import "FSFontDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

static NSString *const kDefaultPreviewText = @"The quick brown fox jumps over the lazy dog.";
static CGFloat const kDefaultFontSize = 12.0f;

static CGFloat const kMinimumFontSize = 5.0f;
static CGFloat const kMaximumFontSize = 72.0f;

@interface FSFontDetailViewController () <UIAlertViewDelegate>
@property (nonatomic, assign) CGFloat currentFontSize;

- (void)setContents;

- (void)previousFont;
- (void)nextFont;
- (void)adjustFontSwitcher;
- (void)increaseFontSize;
- (void)decreaseFontSize;
- (void)adjustFontSizeChanger;
@end


@implementation FSFontDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.currentFontSize = kDefaultFontSize;
    
    self.fontPreview.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
    self.fontPreview.layer.borderWidth = 0.5f;
    self.fontPreview.layer.cornerRadius = 6.0f;
    self.fontPreview.textContainerInset = UIEdgeInsetsMake(10.0f, 5.0f, 10.0f, 5.0f);
    
    [self resetToDefaults:self.resetButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    if (self.font) [self setContents];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.fontPreview becomeFirstResponder];
}

- (void)setFont:(FSFont *)font
{
    if (_font != font) {
        _font = font;
        [self setContents];
    }
}

- (void)setContents
{
    self.title = self.font.fontFamily.name;
    self.titleLabel.text = self.font.name;
    self.fontPreview.font = [self.font fontWithSize:self.currentFontSize];
    [self adjustFontSizeChanger];
    [self adjustFontSwitcher];
}

#pragma mark - Helpers
- (void)previousFont
{
    self.font = self.font.previousFont;
}

- (void)nextFont
{
    self.font = self.font.nextFont;
}

- (void)adjustFontSwitcher
{
    [self.fontChanger setEnabled:self.font.hasPreviousFont forSegmentAtIndex:0];
    [self.fontChanger setEnabled:self.font.hasNextFont forSegmentAtIndex:1];
}

- (CGFloat)currentFontSize
{
    NSString *fontSize = [self.sizeChanger titleForSegmentAtIndex:1];
    return (CGFloat)fontSize.floatValue;
}

- (void)setCurrentFontSize:(CGFloat)currentFontSize
{
    if (currentFontSize != self.currentFontSize) {
        CGFloat fontSize = currentFontSize;
        fontSize = MIN(fontSize, kMaximumFontSize);
        fontSize = MAX(fontSize, kMinimumFontSize);
        [self.sizeChanger setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)fontSize] forSegmentAtIndex:1];
        self.fontPreview.font = [self.font fontWithSize:fontSize];
        [self adjustFontSwitcher];
    }
}

- (void)showFontSizeAlert
{
    UIAlertView *alertView = [[UIAlertView alloc] init];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    alertView.title = @"Enter Font Size";
    alertView.message = @"Please enter the desired font size (between 5 and 72).\nNo check for correctness is made!";
    NSInteger cancelButton = [alertView addButtonWithTitle:@"Cancel"];
    alertView.cancelButtonIndex = cancelButton;
    [alertView addButtonWithTitle:@"Done"];
    alertView.delegate = self;
    [alertView show];
}

- (void)increaseFontSize
{
    [self setCurrentFontSize:(self.currentFontSize + 1)];
}

- (void)decreaseFontSize
{
    [self setCurrentFontSize:(self.currentFontSize - 1)];
}

- (void)adjustFontSizeChanger
{
    CGFloat fontSize = self.currentFontSize;
    [self.sizeChanger setEnabled:(fontSize > kMinimumFontSize) forSegmentAtIndex:0];
    [self.sizeChanger setEnabled:(fontSize < kMaximumFontSize) forSegmentAtIndex:2];
}

#pragma mark - Actions
- (void)resetToDefaults:(id)sender
{
    self.fontPreview.text = kDefaultPreviewText;
    self.currentFontSize = kDefaultFontSize;
    if (self.font) self.fontPreview.font = [self.font fontWithSize:kDefaultFontSize];
}

- (void)switchFont:(UISegmentedControl *)sender
{
    NSInteger selectedIndex = sender.selectedSegmentIndex;
    switch (selectedIndex) {
        case 0:
            [self previousFont];
            break;
        case 1:
            [self nextFont];
            break;
            
        default:
            break;
    }
}

- (void)changeSize:(UISegmentedControl *)sender
{
    NSInteger selectedIndex = sender.selectedSegmentIndex;
    switch (selectedIndex) {
        case 0:
            [self decreaseFontSize];
            break;
        case 1:
            [self showFontSizeAlert];
            break;
        case 2:
            [self increaseFontSize];
            break;
            
        default:
            break;
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Done"]) {
        self.currentFontSize = [alertView textFieldAtIndex:0].text.floatValue;
    }
}

@end
