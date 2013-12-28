//
//  NSArray+Sorting.m
//  Fonts
//
//  Created by Florian Friedrich on 28.12.13.
//  Copyright (c) 2013 FrieSoft. All rights reserved.
//

#import "NSArray+Sorting.h"

@implementation NSArray (Sorting)

- (NSArray *)arraySortedByKey:(NSString *)key ascending:(BOOL)ascending
{
    return [self arraySortedByKeyAndAscendingDictionary:@{key: @(ascending)}];
}

- (NSArray *)arraySortedByKeyAndAscendingDictionary:(NSDictionary *)keyAscDict
{
    NSMutableArray *sortDescriptors = [[NSMutableArray alloc] init];
    [keyAscDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:key ascending:[obj boolValue]];
        [sortDescriptors addObject:sortDescriptor];
    }];
    return [self sortedArrayUsingDescriptors:sortDescriptors.copy];
}

@end
