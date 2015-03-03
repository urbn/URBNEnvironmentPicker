//
//  ANTEnvironmentSettingsController.m
//  Anthropologie
//
//  Created by Corey Floyd on 12/23/13.
//  Copyright (c) 2013 Urban Outfitters, Inc. All rights reserved.
//

#import "URBNEnvironmentController.h"
#import "URBNEnvironment.h"

NSString *const URBNEnvironmentWillChangeNotification = @"URBNEnvironmentWillChangeNotification";
NSString *const URBNEnvironmentDidChangeNotification = @"URBNEnvironmentDidChangeNotification";
NSString *const URBNEnvironmentChangeOldEnvironmentKey = @"URBNEnvironmentChangeOldEnvironmentKey";
NSString *const URBNEnvironmentChangeNewEnvironmentKey = @"URBNEnvironmentChangeNewEnvironmentKey";

NSString *const URBNCurrentEnvironmentUserDefaultsKey = @"URBNCurrentEnvironmentUserDefaultsKey";

NSString *const URBNEnvironemntsPlistName = @"URBNEnvironments";
NSString *const URBNEnvironemntsPlistExtension = @"plist";

static URBNEnvironmentController *_instance = nil;

@interface URBNEnvironmentController ()

@property (nonatomic, retain, readwrite) NSArray *availableEnvironments;
@property (nonatomic, retain, readwrite) URBNEnvironment *currentEnvironment;

@end

@implementation URBNEnvironmentController

+ (URBNEnvironmentController *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
	    _instance = [[URBNEnvironmentController alloc] init];
    });
    
    return _instance;
}

#pragma mark - Setup
- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self loadEnvironemntsFromPlist];
        [self loadCurrentEnvironemnt];
    }
    
    return self;
}

- (void)loadCurrentEnvironemnt {
    URBNEnvironment *environment;
    NSString *saved = [self savedEnvironmentName];

    if (saved) {
        environment = [self environmentWithName:saved];
    }

    if (!environment) {
        environment = [self.availableEnvironments firstObject];
    }

    self.currentEnvironment = environment;
}

- (void)loadEnvironemntsFromPlist {
    NSURL *plistURL = [[NSBundle mainBundle] URLForResource:URBNEnvironemntsPlistName withExtension:URBNEnvironemntsPlistExtension];

    if (!plistURL) {
        return;
    }

    NSArray *environmentDictionaries = [NSArray arrayWithContentsOfURL:plistURL];

    if (![environmentDictionaries isKindOfClass:[NSArray class]]) {
        return;
    }


    NSMutableArray *environments = [NSMutableArray array];
    [environmentDictionaries enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        if (![obj isKindOfClass:[NSDictionary class]]) {
            return;
        }

        URBNEnvironment* environment = [[URBNEnvironment alloc] initWithDictionary:obj];
        
        if (environment) {
            [environments addObject:environment];
        }
    }];

    self.availableEnvironments = environments;
}

#pragma mark - Utility Methods
- (URBNEnvironment *)environmentWithName:(NSString *)name {
    NSUInteger index = [[self availableEnvironments] indexOfObjectPassingTest:^BOOL(URBNEnvironment *obj, NSUInteger idx, BOOL *stop) {
        if ([[obj name] isEqualToString:name]) {
            *stop = YES;
            return YES;
        }
        return NO;
    }];

    if (index == NSNotFound) {
        return nil;
    }

    return [self.availableEnvironments objectAtIndex:index];
}

#pragma mark - Saved Environment
- (NSString *)savedEnvironmentName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:URBNCurrentEnvironmentUserDefaultsKey];
}

- (void)saveEnvironmentName:(NSString *)name {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:name forKey:URBNCurrentEnvironmentUserDefaultsKey];
    [defaults synchronize];
}

#pragma mark - Switch Environments
- (void)changeToEnvironment:(URBNEnvironment *)newEnvironment {
    if (!newEnvironment) {
        return;
    }

    URBNEnvironment *oldEnvironment = [self currentEnvironment];

    if ([oldEnvironment isEqual:newEnvironment]) {
        return;
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:URBNEnvironmentWillChangeNotification object:self userInfo:@{URBNEnvironmentChangeOldEnvironmentKey : oldEnvironment, URBNEnvironmentChangeNewEnvironmentKey : newEnvironment}];

    self.currentEnvironment = newEnvironment;
    [self saveEnvironmentName:newEnvironment.name];

    [[NSNotificationCenter defaultCenter] postNotificationName:URBNEnvironmentDidChangeNotification object:self userInfo:@{URBNEnvironmentChangeOldEnvironmentKey : oldEnvironment, URBNEnvironmentChangeNewEnvironmentKey : newEnvironment}];

    if (self.terminateAppOnEnvironemntChange) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            abort();
        });
    }
}

@end
