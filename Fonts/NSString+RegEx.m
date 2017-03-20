//
//  NSString+RegEx.m
//  Fonts
//
//  Created by Florian Friedrich on 08.04.14.
//  Copyright (c) 2014 Florian Friedrich. All rights reserved.
//

#import "NSString+RegEx.h"

@implementation NSString (RegEx)

- (NSRegularExpression *)regexWithPattern:(NSString *)pattern
{
    __autoreleasing NSError *error = nil;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern
                                                                      options:kNilOptions
                                                                        error:&error];
    if (error) NSLog(@"Regex: %@\nFailed: %@", pattern, error);
    return regex;
}

- (BOOL)matchesPattern:(NSString *)pattern
{
    NSRegularExpression *regex = [self regexWithPattern:pattern];
    BOOL match = [regex numberOfMatchesInString:self
                                        options:kNilOptions
                                          range:NSMakeRange(0, self.length)] == 1;
    return match;
}

- (BOOL)containsPattern:(NSString *)pattern
{
    NSRegularExpression *regex = [self regexWithPattern:pattern];
    BOOL match = [regex numberOfMatchesInString:self
                                        options:kNilOptions
                                          range:NSMakeRange(0, self.length)] > 0;
    return match;
}

@end
