//
//  FFFontCell.h
//  Fonts
//
//  Created by Florian Friedrich on 24.10.13.
//  Copyright (c) 2013 Florian Friedrich. All rights reserved.
//

@import UIKit;
#import "FFFont.h"

@interface FFFontCell : UITableViewCell

@property (nonatomic, strong, readonly) FFFont *font;

- (void)configureWithFFFont:(FFFont *)font;

@end
