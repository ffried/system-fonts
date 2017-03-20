//
//  FFFontViewController.m
//  Fonts
//
//  Created by Florian Friedrich on 24.10.13.
//  Copyright (c) 2013 Florian Friedrich. All rights reserved.
//

#import "FFFontDetailViewController.h"
@import QuartzCore;

#import "FFFontFamily.h"
#import "FFFont.h"
#import "FFKeyboardConstraintHandler.h"
#import "NSString+RegEx.h"
#import "FFMainViewController.h"

static NSString *const kDefaultPreviewText = @"The quick brown fox jumps over the lazy dog.";
static CGFloat const kDefaultFontSize = 12.0f;

static CGFloat const kMinimumFontSize = 5.0f;
static CGFloat const kMaximumFontSize = 72.0f;

@interface FFFontDetailViewController () <UITextFieldDelegate>
@property (nonatomic, assign) CGFloat currentFontSize;
@property (nonatomic, strong) FFKeyboardConstraintHandler *keyboardConstraintHandler;
@property (nonatomic, strong) FFMainViewController *mainVC;
@property (nonatomic, weak) UIAlertAction *fontAlertDoneAction;

- (void)setContents;

- (void)previousFont;
- (void)nextFont;
- (void)adjustFontSwitcher;
- (void)increaseFontSize;
- (void)decreaseFontSize;
- (void)adjustFontSizeChanger;
@end

@implementation FFFontDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.currentFontSize = kDefaultFontSize;
    
    self.fontPreview.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
    self.fontPreview.layer.borderWidth = 0.5f;
    self.fontPreview.layer.cornerRadius = 6.0f;
    self.fontPreview.textContainerInset = UIEdgeInsetsMake(10.0f, 5.0f, 10.0f, 5.0f);
    
    self.keyboardConstraintHandler = [[FFKeyboardConstraintHandler alloc] initWithConstraint:self.keyboardConstraint containingView:self.view];
    
    self.mainVC = FFFindMainViewController(self);
    
    [self resetToDefaults:self.resetButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.mainVC.statusBarView setHidden:YES animated:animated];
    
    if (self.font) [self setContents];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.fontPreview becomeFirstResponder];
}

- (void)setFont:(FFFont *)font
{
    if (![_font isEqual:font]) {
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
        [self adjustFontSizeChanger];
    }
}

- (void)showFontSizeAlert
{
    NSString *title = @"Font Size";
    NSString *message = @"Please enter the desired font size (between 5 and 72).";
    NSString *cancelButtonTitle = @"Cancel";
    NSString *doneButtonTitle = @"Done";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.keyboardType = UIKeyboardTypeDecimalPad;
        textField.delegate = self;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:nil]];
    UIAlertAction *fontAlertDoneAction = [UIAlertAction actionWithTitle:doneButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.currentFontSize = alertController.textFields.firstObject.text.floatValue;
    }];
    fontAlertDoneAction.enabled = NO;
    [alertController addAction:fontAlertDoneAction];
    self.fontAlertDoneAction = fontAlertDoneAction;
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)increaseFontSize
{
    [self setCurrentFontSize:(self.currentFontSize + 1.0f)];
}

- (void)decreaseFontSize
{
    [self setCurrentFontSize:(self.currentFontSize - 1.0f)];
}

- (void)adjustFontSizeChanger
{
    CGFloat fontSize = self.currentFontSize;
    [self.sizeChanger setEnabled:(fontSize > kMinimumFontSize) forSegmentAtIndex:0];
    [self.sizeChanger setEnabled:(fontSize < kMaximumFontSize) forSegmentAtIndex:2];
}

- (BOOL)validFontSize:(NSString *)fontSizeText
{
    if (fontSizeText.length <= 0) return NO;
    BOOL matches = [fontSizeText matchesPattern:@"[0-9]+(\\.[0-9]+)?"];
    if (!matches) return NO;
    CGFloat size = fontSizeText.floatValue;
    return size >= 5.0f && size <= 72.0f;
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

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL isValidFontSize = [self validFontSize:[textField.text stringByReplacingCharactersInRange:range withString:string]];
    self.fontAlertDoneAction.enabled = isValidFontSize;
    return YES;
}

@end
