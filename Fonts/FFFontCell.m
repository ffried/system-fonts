//
//  FFFontCell.m
//  Fonts
//
//  Created by Florian Friedrich on 24.10.13.
//  Copyright (c) 2013 Florian Friedrich. All rights reserved.
//

#import "FFFontCell.h"

@interface FFFontCell ()
@property (nonatomic, strong) FFFont *font;
@end

@implementation FFFontCell

- (void)configureWithFFFont:(FFFont *)font
{
    self.font = font;
    self.textLabel.text = font.name;
}

@end
