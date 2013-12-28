//
//  FSFontCell.h
//  Fonts
//
//  Created by Florian Friedrich on 24.10.13.
//  Copyright (c) 2013 FrieSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSFont.h"

@interface FSFontCell : UITableViewCell

@property (nonatomic, strong, readonly) FSFont *font;

- (void)configureWithFSFont:(FSFont *)font;

@end
