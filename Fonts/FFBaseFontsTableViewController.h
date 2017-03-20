//
//  FFBaseFontsTableViewController.h
//  Fonts
//
//  Created by Florian Friedrich on 20/03/2017.
//  Copyright © 2017 Florian Friedrich. All rights reserved.
//

@import UIKit;
@class FFFontFamily;

@interface FFBaseFontsTableViewController : UITableViewController

@property (nonatomic, strong) NSArray<FFFontFamily *> *fontFamilies;

@end
