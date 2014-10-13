//
//  FFFontFamily.h
//  Fonts
//
//  Created by Florian Friedrich on 28.12.13.
//  Copyright (c) 2013 Florian Friedrich. All rights reserved.
//

@import Foundation;

@interface FFFontFamily : NSObject <NSCopying, NSCoding>

+ (NSArray *)allFontFamilies;

- (instancetype)initWithName:(NSString *)name NS_DESIGNATED_INITIALIZER;

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSArray *fonts;

@end
