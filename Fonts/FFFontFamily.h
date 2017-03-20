//
//  FFFontFamily.h
//  Fonts
//
//  Created by Florian Friedrich on 28.12.13.
//  Copyright (c) 2013 Florian Friedrich. All rights reserved.
//

@import Foundation;
@class FFFont;

@interface FFFontFamily : NSObject <NSCopying, NSCoding>

+ (NSArray<FFFontFamily *> *)allFontFamilies;

- (instancetype)initWithName:(NSString *)name NS_DESIGNATED_INITIALIZER;

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSArray<FFFont *> *fonts;

@end
