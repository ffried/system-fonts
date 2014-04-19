//
//  NSString+RegEx.h
//  SWR3
//
//  Created by Florian Friedrich on 08.04.14.
//  Copyright (c) 2014 FrieSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegEx)

- (BOOL)matchesPattern:(NSString *)pattern;
- (BOOL)containsPattern:(NSString *)pattern;

@end
