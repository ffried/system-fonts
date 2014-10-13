//
//  NSString+RegEx.h
//  Fonts
//
//  Created by Florian Friedrich on 08.04.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

@import Foundation;

@interface NSString (RegEx)

- (BOOL)matchesPattern:(NSString *)pattern;
- (BOOL)containsPattern:(NSString *)pattern;

@end
