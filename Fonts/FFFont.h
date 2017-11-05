//
//  FFFont.h
//  Fonts
//
//  Created by Florian Friedrich on 28.12.13.
//  Copyright (c) 2013 Florian Friedrich. All rights reserved.
//

@import Foundation;
#import "FFFontFamily.h"

@interface FFFont : NSObject <NSCopying, NSCoding>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, weak, readonly) FFFontFamily *fontFamily;

- (instancetype)initWithName:(NSString *)name NS_DESIGNATED_INITIALIZER;

- (UIFont *)font;
- (UIFont *)fontWithSize:(CGFloat)size;

- (BOOL)hasPreviousFont;
- (BOOL)hasNextFont;

- (FFFont *)previousFont;
- (FFFont *)nextFont;

@end
