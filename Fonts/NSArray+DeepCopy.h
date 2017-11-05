//
//  NSArray+DeepCopy.h
//  Fonts
//
//  Created by Florian Friedrich on 05.11.17.
//  Copyright © 2017 Florian Friedrich. All rights reserved.
//

@import Foundation;

@interface NSArray<ObjectType> (DeepCopy)

- (id)deepCopyWithZone:(NSZone *)zone;
- (id)deepCopy;

@end
