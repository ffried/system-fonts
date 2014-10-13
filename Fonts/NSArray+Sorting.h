//
//  NSArray+Sorting.h
//  Fonts
//
//  Created by Florian Friedrich on 28.12.13.
//  Copyright (c) 2013 Florian Friedrich. All rights reserved.
//

@import Foundation;

@interface NSArray (Sorting)

- (NSArray *)arraySortedByKey:(NSString *)key ascending:(BOOL)ascending;

- (NSArray *)arraySortedByKeyAndAscendingDictionary:(NSDictionary *)keyAscDict;

@end
