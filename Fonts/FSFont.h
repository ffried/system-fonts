//
//  FSFont.h
//  Fonts
//
//  Created by Florian Friedrich on 28.12.13.
//  Copyright (c) 2013 FrieSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSFontFamily.h"

@interface FSFont : NSObject <NSCopying, NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, weak) FSFontFamily *fontFamily;

- (instancetype)initWithName:(NSString *)name FF_DESIGNATED_INITIALIZER;

- (UIFont *)font;
- (UIFont *)fontWithSize:(CGFloat)size;

- (BOOL)hasPreviousFont;
- (BOOL)hasNextFont;

- (FSFont *)previousFont;
- (FSFont *)nextFont;

@end
