//
//  URBNEnvironmentTests.m
//  URBNEnvironmentPicker
//
//  Created by Jason Grandelli on 3/31/15.
//  Copyright (c) 2015 Dustin Bergman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <URBNEnvironmentPicker/URBNEnvironmentController.h>
#import <URBNEnvironmentPicker/URBNEnvironment.h>

@interface URBNEnvironmentTests : XCTestCase

@property (nonatomic, strong) URBNEnvironmentController *ec;

@end

@implementation URBNEnvironmentTests

- (void)setUp {
    [super setUp];
    
    self.ec = [URBNEnvironmentController sharedInstance];
}

- (void)tearDown {
    self.ec = nil;
    
    [super tearDown];
}

- (void)testEnvironmentsLoads {
    NSURL *plistURL = [[NSBundle mainBundle] URLForResource:@"URBNEnvironments" withExtension:@"plist"];
    XCTAssertNotNil(plistURL);

    NSArray *environments = [NSArray arrayWithContentsOfURL:plistURL];
    XCTAssertNotNil(environments);
    XCTAssertGreaterThan(environments.count, 0);
    XCTAssert([environments isKindOfClass:[NSArray class]]);
}

- (void)testEnvironmentController {
    XCTAssertNotNil(self.ec.availableEnvironments);
    XCTAssertGreaterThan(self.ec.availableEnvironments.count, 0);
    XCTAssertNotNil(self.ec.currentEnvironment);
}

- (void)testCurrentEnvironment {
    self.ec.terminateAppOnEnvironemntChange = NO;
    [self.ec changeToEnvironment:[self.ec.availableEnvironments firstObject]];
    URBNEnvironment *e = self.ec.currentEnvironment;
    
    XCTAssertEqualObjects(e, [self.ec.availableEnvironments firstObject]);
}

- (void)testEnvironmentValues {
    URBNEnvironment *e = [self.ec.availableEnvironments firstObject];
    XCTAssert([e.name isEqualToString:@"Development"]);
    XCTAssert([e.displayName isEqualToString:@"Development Environment"]);
    XCTAssert([e.displayDescription isEqualToString:@"Uses dev.sample.com"]);
}

- (void)testProperReturnValues {
    URBNEnvironment *dev = self.ec.availableEnvironments.firstObject;
    XCTAssertEqualObjects([dev URLForKey:@"URL"], [NSURL URLWithString:@"http://dev.sample.com"]);
    XCTAssertEqualObjects([dev stringForKey:@"AnalyticsAPIKey"], @"8675309");
    XCTAssertEqualObjects([dev stringForKey:@"BackgroundColor"], @"blue");
    XCTAssertEqual([dev integerForKey:@"numberValue"], 10);
    XCTAssertNil([dev stringForKey:@"numberValue"]);
    XCTAssertNil([dev URLForKey:@"numberValue"]);

    URBNEnvironment *prod = self.ec.availableEnvironments[1];
    XCTAssertEqualObjects([prod URLForKey:@"URL"], [NSURL URLWithString:@"http://www.sample.com"]);
    XCTAssertEqualObjects([prod stringForKey:@"AnalyticsAPIKey"], @"9091");
    XCTAssertEqualObjects([prod stringForKey:@"BackgroundColor"], @"yellow");
    XCTAssertEqual([prod integerForKey:@"numberValue"], 0);
    XCTAssertNil([prod objectForKey:@"numberValue"]);
    XCTAssertNil([prod stringForKey:@"numberValue"]);
    XCTAssertNil([prod URLForKey:@"numberValue"]);
}

@end
