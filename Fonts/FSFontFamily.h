//
//  FSFontFamily.h
//  Fonts
//
//  Created by Florian Friedrich on 28.12.13.
//  Copyright (c) 2013 FrieSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSFontFamily : NSObject <NSCopying, NSCoding>

+ (NSArray *)allFontFamilies;

- (instancetype)initWithName:(NSString *)name NS_DESIGNATED_INITIALIZER;

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSArray *fonts;

@end
