//
//  URBNEnvironment.h
//  ANT
//
//  Created by Corey Floyd on 5/21/14.
//  Copyright (c) 2014 Urban Outfitters. All rights reserved.
//

@interface URBNEnvironment : NSObject

#pragma mark - Environment Properties
/**
 *  A name for the environment. This name should be unique for each environemnt you define.
 */
@property (nonatomic, strong, readonly) NSString *name;

/**
 *  A name for the environment which is suitable for display in the UI.
 */
@property (nonatomic, strong, readonly) NSString *displayName;

/**
 *  A (short) description that describes the environment which is suitable for display in the UI.
 */
@property (nonatomic, strong, readonly) NSString *displayDescription;

#pragma mark - Initalize

/**
 *  Initalize URBNEnvironment Object
 *
 *  @param Environment dictionary in URBNEnvironments.plist
 *
 *  @return The instancetype
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

#pragma mark - Get Settings

/**
 *  Get a setting for the specified key
 *
 *  @param key The key for the setting to fetch as defined in the plist
 *
 *  @return The setting
 */
- (id)objectForKey:(NSString *)key;

#pragma mark - Convienence Settings Getters

- (NSString *)stringForKey:(NSString *)key;

- (NSURL *)URLForKey:(NSString *)key;

- (BOOL)boolForKey:(NSString *)key;

- (NSArray *)arrayForKey:(NSString *)key;

- (NSInteger)integerForKey:(NSString *)key;

- (NSTimeInterval)intervalForKey:(NSString *)key;

- (double)doubleForKey:(NSString *)key;

@end
