//
//  NSArray+Sorting.h
//  Fonts
//
//  Created by Florian Friedrich on 28.12.13.
//  Copyright (c) 2013 FrieSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Sorting)

- (NSArray *)arraySortedByKey:(NSString *)key ascending:(BOOL)ascending;

- (NSArray *)arraySortedByKeyAndAscendingDictionary:(NSDictionary *)keyAscDict;

@end
