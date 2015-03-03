//
//  URBNEnvironment.m
//  ANT
//
//  Created by Corey Floyd on 5/21/14.
//  Copyright (c) 2014 Urban Outfitters. All rights reserved.
//

#import "URBNEnvironment.h"

NSString *const URBNEnvironmentNameKey = @"name";
NSString *const URBNEnvironmentDisplayNameKey = @"displayName";
NSString *const URBNEnvironmentDisplayDescriptionKey = @"displayDescription";

@interface URBNEnvironment ()

@property (nonatomic, retain, readwrite) NSString *name;
@property (nonatomic, retain, readwrite) NSString *displayName;
@property (nonatomic, retain, readwrite) NSString *displayDescription;
@property (nonatomic, retain) NSDictionary *settings;

@end

@implementation URBNEnvironment

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.name = [dictionary objectForKey:URBNEnvironmentNameKey];
        self.displayName = [dictionary objectForKey:URBNEnvironmentDisplayNameKey];
        self.displayDescription = [dictionary objectForKey:URBNEnvironmentDisplayDescriptionKey];
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
