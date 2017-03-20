//
//  FFFontFamily.m
//  Fonts
//
//  Created by Florian Friedrich on 28.12.13.
//  Copyright (c) 2013 Florian Friedrich. All rights reserved.
//

#import "FFFontFamily.h"
#import "FFFont.h"
#import "NSArray+Sorting.h"

@interface FFFontFamily ()
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray<FFFont *> *fonts;
@end

@implementation FFFontFamily
@synthesize fonts = _fonts;

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

- (instancetype)init { return [self initWithName:[UIFont systemFontOfSize:[UIFont systemFontSize]].familyName]; }

+ (NSArray<FFFontFamily *> *)allFontFamilies
{
    NSMutableArray<FFFontFamily *> *tempFonts = [NSMutableArray array];
    [[UIFont familyNames].copy enumerateObjectsUsingBlock:^(NSString *fontFamilyName, NSUInteger idx, BOOL *stop) {
        id family = [[self alloc] initWithName:fontFamilyName];
        [tempFonts addObject:family];
    }];
    
    return [[NSArray arrayWithArray:tempFonts] arraySortedByKey:FFProperty(name) ascending:YES];
}

- (NSArray<FFFont *> *)fonts
{
    if (!_fonts) {
        NSMutableArray<FFFont *> *fonts = [NSMutableArray array];
        [[UIFont fontNamesForFamilyName:self.name].copy enumerateObjectsUsingBlock:^(NSString *fontName, NSUInteger idx, BOOL *stop) {
            [fonts addObject:[[FFFont alloc] initWithName:fontName]];
        }];
        self.fonts = [[NSArray arrayWithArray:fonts] arraySortedByKey:FFProperty(name) ascending:YES];
    }
    return _fonts;
}

- (void)setFonts:(NSArray<FFFont *> *)fonts {
    if (![_fonts isEqualToArray:fonts]) {
        _fonts = fonts;
        [_fonts setValue:self forKey:FFProperty(fontFamily)];
    }
}

#pragma mark - Useful
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ (%p)> \"%@\", %lu fonts", NSStringFromClass([self class]), self, self.name, (unsigned long)self.fonts.count];
}

- (NSUInteger)hash
{
    return self.name.hash ^ self.fonts.hash;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[FFFontFamily class]]) {
        FFFontFamily *obj = object;
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
    self = [self initWithName:[aDecoder decodeObjectForKey:FFProperty(name)]];
    self.fonts = [aDecoder decodeObjectForKey:FFProperty(fonts)];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:FFProperty(name)];
    [aCoder encodeObject:self.fonts forKey:FFProperty(fonts)];
}

@end
