//
//  FSFontsTableViewController.m
//  Fonts
//
//  Created by Florian Friedrich on 24.10.13.
//  Copyright (c) 2013 FrieSoft. All rights reserved.
//

#import "FSFontsTableViewController.h"
#import "FSFontDetailViewController.h"
#import "FSFontCell.h"
#import "FSFontFamily.h"

@interface FSFontsTableViewController ()
@property (nonatomic, strong) NSArray *fontFamilies;
@property (nonatomic, strong) NSArray *filteredFontFamiliesArray;
@end


static NSString *FSFontCellIdentifier = @"FSFontCell";
@implementation FSFontsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:YES];
    
    self.fontFamilies = [FSFontFamily allFontFamilies];
    
    [self.searchDisplayController.searchResultsTableView registerClass:[FSFontCell class] forCellReuseIdentifier:FSFontCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    return (searchTableView) ? _filteredFontFamiliesArray.count : ((FSFontFamily *)_fontFamilies[section]).fonts.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    BOOL searchTableView = (tableView == self.searchDisplayController.searchResultsTableView);
    return (searchTableView) ? nil : ((FSFontFamily *)_fontFamilies[section]).name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BOOL searchTableView = (tableView == self.searchDisplayController.searchResultsTableView);
    
    FSFontCell *cell = [tableView dequeueReusableCellWithIdentifier:FSFontCellIdentifier forIndexPath:indexPath];
    if (!cell) cell = [[FSFontCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FSFontCellIdentifier];
    
    FSFont *font = nil;
    if (!searchTableView) {
        font = ((FSFontFamily *)_fontFamilies[indexPath.section]).fonts[indexPath.row];
    } else {
        font = _filteredFontFamiliesArray[indexPath.row];
    }
    [cell configureWithFSFont:font];
    
    return cell;
}

#pragma mark - Navigation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [self performSegueWithIdentifier:@"FSPushFontDetailViewController" sender:[tableView cellForRowAtIndexPath:indexPath]];
    }
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"FSPushFontDetailViewController"]) {
        FSFontDetailViewController *fontDetail = segue.destinationViewController;
        if ([sender isKindOfClass:[FSFontCell class]]) {
            fontDetail.font = [(FSFontCell *)sender font];
        }
    }
}

#pragma mark - Search

- (void)searchForFontsWithName:(NSString *)fontName
{
    NSMutableArray *foundFonts = [NSMutableArray new];
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", fontName];
    [_fontFamilies enumerateObjectsUsingBlock:^(FSFontFamily *fontFamily, NSUInteger idx, BOOL *stop) {
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
