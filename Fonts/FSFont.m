//
//  FSFont.m
//  Fonts
//
//  Created by Florian Friedrich on 28.12.13.
//  Copyright (c) 2013 FrieSoft. All rights reserved.
//

#import "FSFont.h"

@implementation FSFont

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.name = name;
    }
    return self;
}

- (instancetype)init { return [self initWithName:[UIFont systemFontOfSize:[UIFont systemFontSize]].fontName]; }

#pragma mark - UIFont generators
- (UIFont *)font
{
    return [self fontWithSize:[UIFont systemFontSize]];
}

- (UIFont *)fontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:self.name size:size];
}

#pragma mark - Previous / Next Fonts
- (BOOL)hasPreviousFont
{
    NSUInteger index = [self.fontFamily.fonts indexOfObject:self];
    if (index != NSNotFound) {
        NSInteger newIndex = index - 1;
        NSUInteger count = self.fontFamily.fonts.count;
        if (newIndex >= 0 && newIndex < count) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)hasNextFont
{
    NSUInteger index = [self.fontFamily.fonts indexOfObject:self];
    if (index != NSNotFound) {
        NSInteger newIndex = index + 1;
        NSUInteger count = self.fontFamily.fonts.count;
        if (newIndex >= 0 && newIndex < count) {
            return YES;
        }
    }
    return NO;
}

- (FSFont *)previousFont
{
    if (!self.hasPreviousFont) return nil;
    
    NSUInteger index = [self.fontFamily.fonts indexOfObject:self];
    return self.fontFamily.fonts[index - 1];
}

- (FSFont *)nextFont
{
    if (!self.hasNextFont) return nil;
    
    NSUInteger index = [self.fontFamily.fonts indexOfObject:self];
    return self.fontFamily.fonts[index + 1];
}

#pragma mark - Useful
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ (%p)> \"%@\"", NSStringFromClass([self class]), self, self.name];
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[FSFont class]]) {
        FSFont *obj = object;
        BOOL sameName = [obj.name isEqualToString:self.name];
        BOOL sameFamily = [obj.fontFamily.name isEqualToString:self.fontFamily.name];
        return sameFamily && sameName;
    }
    return NO;
}

#pragma mark - NSCopying
- (instancetype)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] initWithName:[self.name copyWithZone:zone]];
    [copy setFontFamily:self.fontFamily];
    return copy;
}

#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithName:[aDecoder decodeObjectForKey:@"name"]];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    //[aCoder encodeObject:self.fontFamily forKey:@"fontFamily"];
}

@end
