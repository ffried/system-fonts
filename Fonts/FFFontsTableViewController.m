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
@property (nonatomic, strong) FFBaseFontsTableViewController *searchResultsController;
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation FFFontsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.fontFamilies = [FFFontFamily allFontFamilies];
    
    self.searchResultsController = [[FFBaseFontsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.searchResultsController.tableView.delegate = self;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsController];
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.scopeButtonTitles = [NSArray array];
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.definesPresentationContext = YES;
}

#pragma mark - Search
- (NSArray *)fontsMatchingName:(NSString *)fontName
{
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", fontName];
    NSMutableArray<FFFontFamily *> *foundFamilies = [NSMutableArray new];
    [self.fontFamilies enumerateObjectsUsingBlock:^(FFFontFamily *fontFamily, NSUInteger idx, BOOL *stop) {
        NSArray *matchedFonts = [fontFamily.fonts filteredArrayUsingPredicate:filterPredicate];
        if (matchedFonts.count > 0) {
            FFFontFamily *family = [fontFamily copy];
            [family setValue:matchedFonts forKey:FFProperty(fonts)];
            [foundFamilies addObject:family];
        }
    }];
    
    return [NSArray arrayWithArray:foundFamilies];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    self.searchResultsController.fontFamilies = [self fontsMatchingName:searchController.searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    
}

@end
