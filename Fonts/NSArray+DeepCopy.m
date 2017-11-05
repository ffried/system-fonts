//
//  NSArray+DeepCopy.m
//  Fonts
//
//  Created by Florian Friedrich on 05.11.17.
//  Copyright © 2017 Florian Friedrich. All rights reserved.
//

#import "NSArray+DeepCopy.h"

@implementation NSArray (DeepCopy)

- (id)deepCopy {
    return [self deepCopyWithZone:NSDefaultMallocZone()];
}

- (id)deepCopyWithZone:(NSZone *)zone {
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in self) {
        if ([obj isKindOfClass:[self class]]) {
            [mutableArray addObject:[obj deepCopyWithZone:zone]];
        } else {
            [mutableArray addObject:[obj copyWithZone:zone]];
        }
    }
    return [NSArray arrayWithArray:mutableArray];
}

@end
