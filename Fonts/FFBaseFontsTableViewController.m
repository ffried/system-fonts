//
//  FFBaseFontsTableViewController.m
//  Fonts
//
//  Created by Florian Friedrich on 20/03/2017.
//  Copyright © 2017 Florian Friedrich. All rights reserved.
//

#import "FFBaseFontsTableViewController.h"
#import "FFMainViewController.h"
#import "FFFontCell.h"
#import "FFFontFamily.h"
#import "FFFont.h"
#import "FFFontDetailViewController.h"

@interface FFBaseFontsTableViewController ()
@property (nonatomic, strong) FFMainViewController *mainVC;
@end

static NSString *const FFFontCellIdentifier = @"FFFontCell";
static NSString *const FFPushFontDetailViewControllerSegueIdentifier = @"FFPushFontDetailViewController";

@implementation FFBaseFontsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.mainVC = FFFindMainViewController(self);
    
    [self.tableView registerClass:[FFFontCell class] forCellReuseIdentifier:FFFontCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mainVC.statusBarView setHidden:NO animated:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark - Properties
- (void)setFontFamilies:(NSArray<FFFontFamily *> *)fontFamilies {
    _fontFamilies = fontFamilies;
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fontFamilies.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fontFamilies[section].fonts.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.fontFamilies[section].name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FFFontCell *cell = [tableView dequeueReusableCellWithIdentifier:FFFontCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    FFFont *font = self.fontFamilies[indexPath.section].fonts[indexPath.row];
    [cell configureWithFFFont:font];
    
    return cell;
}

#pragma mark - Navigation
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:FFPushFontDetailViewControllerSegueIdentifier
                              sender:[tableView cellForRowAtIndexPath:indexPath]];
    
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:FFPushFontDetailViewControllerSegueIdentifier]) {
        FFFontDetailViewController *fontDetail = segue.destinationViewController;
        if ([sender isKindOfClass:[FFFontCell class]]) {
            fontDetail.font = [(FFFontCell *)sender font];
        }
    }
}

@end
