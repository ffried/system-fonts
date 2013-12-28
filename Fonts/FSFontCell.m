//
//  FSFontCell.m
//  Fonts
//
//  Created by Florian Friedrich on 24.10.13.
//  Copyright (c) 2013 FrieSoft. All rights reserved.
//

#import "FSFontCell.h"

@interface FSFontCell ()
@property (nonatomic, strong, readwrite) FSFont *font;
@end

@implementation FSFontCell

- (void)configureWithFSFont:(FSFont *)font
{
    self.font = font;
    self.textLabel.text = font.name;
}

@end
