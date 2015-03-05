//
//  URBNEnvironment.m
//  ANT
//
//  Created by Corey Floyd on 5/21/14.
//  Copyright (c) 2014 Urban Outfitters. All rights reserved.
//

#import "URBNEnvironment.h"

static NSString *const URBNEnvironmentNameKey = @"name";
static NSString *const URBNEnvironmentDisplayNameKey = @"displayName";
static NSString *const URBNEnvironmentDisplayDescriptionKey = @"displayDescription";
static NSString *const URBNEnvironmentSettingsKey = @"settings";

@interface URBNEnvironment ()

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *displayName;
@property (nonatomic, strong, readwrite) NSString *displayDescription;
@property (nonatomic, strong) NSDictionary *settings;

@end

@implementation URBNEnvironment

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.name = [dictionary objectForKey:URBNEnvironmentNameKey];
        self.displayName = [dictionary objectForKey:URBNEnvironmentDisplayNameKey];
        self.displayDescription = [dictionary objectForKey:URBNEnvironmentDisplayDescriptionKey];
        self.settings = [dictionary objectForKey:URBNEnvironmentSettingsKey];
    }
    
    return self;
}

- (id)objectForKey:(NSString *)key {
    return [self.settings objectForKey:key];
}

- (NSString *)stringForKey:(NSString *)key {
    return [self objectForKey:key];
}

- (NSURL *)URLForKey:(NSString *)key {
    NSString *string = [self objectForKey:key];

    if (!string) {
        return nil;
    }

    return [NSURL URLWithString:string];
}

- (NSInteger)integerForKey:(NSString *)key {
    return [[self objectForKey:key] integerValue];
}

- (NSTimeInterval)intervalForKey:(NSString *)key {
    return [[self objectForKey:key] doubleValue];
}

- (double)doubleForKey:(NSString *)key {
    return [[self objectForKey:key] doubleValue];
}

- (BOOL)boolForKey:(NSString *)key {
    return [[self objectForKey:key] boolValue];
}

- (NSArray *)arrayForKey:(NSString *)key {
    return [self objectForKey:key];
}

@end
