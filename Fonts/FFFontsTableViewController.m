//
//  FFFontsTableViewController.m
//  Fonts
//
//  Created by Florian Friedrich on 24.10.13.
//  Copyright (c) 2013 Florian Friedrich. All rights reserved.
//

#import "FFFontsTableViewController.h"
#import "FFFontDetailViewController.h"
#import "FFFontCell.h"
#import "FFFontFamily.h"
#import "FFMainViewController.h"

@interface FFFontsTableViewController ()
@property (nonatomic, strong) NSArray *fontFamilies;
@property (nonatomic, strong) NSArray *filteredFontFamiliesArray;
@property (nonatomic, strong) FFMainViewController *mainVC;
@end

static NSString *const FFFontCellIdentifier = @"FFFontCell";
static NSString *const FFPushFontDetailViewControllerSegueIdentifier = @"FFPushFontDetailViewController";
@implementation FFFontsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:YES];
    
    self.fontFamilies = [FFFontFamily allFontFamilies];
    
    [self.searchDisplayController.searchResultsTableView registerClass:[FFFontCell class] forCellReuseIdentifier:FFFontCellIdentifier];
    
    self.mainVC = FFFindMainViewController(self);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mainVC.statusBarView setHidden:NO animated:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    BOOL searchTableView = (tableView == self.searchDisplayController.searchResultsTableView);
    return (searchTableView) ? 1 : _fontFamilies.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    BOOL searchTableView = (tableView == self.searchDisplayController.searchResultsTableView);
    return (searchTableView) ? _filteredFontFamiliesArray.count : ((FFFontFamily *)_fontFamilies[section]).fonts.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    BOOL searchTableView = (tableView == self.searchDisplayController.searchResultsTableView);
    return (searchTableView) ? nil : ((FFFontFamily *)_fontFamilies[section]).name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL searchTableView = (tableView == self.searchDisplayController.searchResultsTableView);
    
    FFFontCell *cell = [tableView dequeueReusableCellWithIdentifier:FFFontCellIdentifier forIndexPath:indexPath];
    if (!cell) cell = [[FFFontCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FFFontCellIdentifier];
    
    FFFont *font = nil;
    if (!searchTableView) {
        font = ((FFFontFamily *)_fontFamilies[indexPath.section]).fonts[indexPath.row];
    } else {
        font = _filteredFontFamiliesArray[indexPath.row];
    }
    [cell configureWithFFFont:font];
    
    return cell;
}

#pragma mark - Navigation
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [self performSegueWithIdentifier:FFPushFontDetailViewControllerSegueIdentifier
                                  sender:[tableView cellForRowAtIndexPath:indexPath]];
    }
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

#pragma mark - Search
- (void)searchForFontsWithName:(NSString *)fontName
{
    NSMutableArray *foundFonts = [NSMutableArray new];
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", fontName];
    [_fontFamilies enumerateObjectsUsingBlock:^(FFFontFamily *fontFamily, NSUInteger idx, BOOL *stop) {
        [foundFonts addObjectsFromArray:[fontFamily.fonts filteredArrayUsingPredicate:filterPredicate]];
    }];
    
    _filteredFontFamiliesArray = [NSArray arrayWithArray:foundFonts];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self searchForFontsWithName:searchString];
    return YES;
}

@end
