//
//  FSFontFamily.m
//  Fonts
//
//  Created by Florian Friedrich on 28.12.13.
//  Copyright (c) 2013 FrieSoft. All rights reserved.
//

#import "FSFontFamily.h"
#import "FSFont.h"
#import "NSArray+Sorting.h"

@implementation FSFontFamily

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

- (instancetype)init { return [self initWithName:[UIFont systemFontOfSize:[UIFont systemFontSize]].familyName]; }

+ (NSArray *)allFontFamilies
{
    NSMutableArray *tempFonts = [NSMutableArray new];
    [[UIFont familyNames].copy enumerateObjectsUsingBlock:^(NSString *fontFamilyName, NSUInteger idx, BOOL *stop) {
        id family = [[[self class] alloc] initWithName:fontFamilyName];
        [tempFonts addObject:family];
    }];
    
    return [tempFonts.copy arraySortedByKey:@"name" ascending:YES];
}

- (NSArray *)fonts
{
    if (!_fonts) {
        NSMutableArray *fonts = [[NSMutableArray alloc] init];
        [[UIFont fontNamesForFamilyName:self.name].copy enumerateObjectsUsingBlock:^(NSString *fontName, NSUInteger idx, BOOL *stop) {
            id font = [[FSFont alloc] initWithName:fontName];
            [font setFontFamily:self];
            [fonts addObject:font];
        }];
        
        self.fonts = [fonts.copy arraySortedByKey:@"name" ascending:YES];
    }
    return _fonts;
}

#pragma mark - Useful
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ (%p)> \"%@\"", NSStringFromClass([self class]), self, self.name];
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[FSFontFamily class]]) {
        FSFontFamily *obj = object;
        BOOL sameName = [obj.name isEqualToString:self.name];
        BOOL sameFontCount = obj.fonts.count == self.fonts.count;
        return sameName && sameFontCount;
    }
    return NO;
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] initWithName:[self.name copyWithZone:zone]];
    [copy setFonts:[self.fonts copyWithZone:zone]];
    return copy;
}

#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.fonts = [aDecoder decodeObjectForKey:@"fonts"];
        [self.fonts enumerateObjectsUsingBlock:^(FSFont *font, NSUInteger idx, BOOL *stop) {
            font.fontFamily = self;
        }];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.fonts forKey:@"fonts"];
}

@end
