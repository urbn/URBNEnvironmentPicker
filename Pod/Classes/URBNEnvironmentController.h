/*
 * This class allows the developer to change the environment of the application.
 *
 * You must include a file containing your environment settings called URBNEnvironments.plist in your bundle.
 * An example can be found here:
 *
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class URBNEnvironment;

extern NSString *const URBNEnvironmentWillChangeNotification;
extern NSString *const URBNEnvironmentDidChangeNotification;

extern NSString *const URBNEnvironmentChangeOldEnvironmentKey;
extern NSString *const URBNEnvironmentChangeNewEnvironmentKey;

@interface URBNEnvironmentController : NSObject

/**
 *  Returns the shared environemnt controller that is lazy loaded
 *
 *  @return The environment controller
 */
+ (URBNEnvironmentController *)sharedInstance;

/**
 *  Get a list of all environments (URBNEnvironment) loaded from the plist (in the same order)
 */
@property (nonatomic, strong, readonly) NSArray <URBNEnvironment *> *availableEnvironments;

/**
 *  The current environment of the app.
 *
 *  On launch, the current environemnt is determined by:
 *  1. If no environment was selected previously, then it will set the first environment in the plist as the currentEnvironment.
 *  2. If an environment was selected previously, then it will set the currentEnvironment to the previously selected environment.
 *
 *  Otherwise, the current environment can be changed using the changeToEnvironment: method.
 */
@property (nonatomic, strong, readonly) URBNEnvironment *currentEnvironment;

/**
 *  Setting this to YES calls abort() when the environment changes.
 * 
 *  By setting this to NO, you will be responsible for registering for notifications
 *  and updating any objects that depend on your environment settings (which can be a non-trival task).
 *
 *  By setting this to YES, you will not have to implement any code to respond to changes in the settings,
 *  and can simply perform your configuration in -application: didFinishLaunchingWithOptions:. This is 
 *  usually acceptable while developing an app and sharing it with beta testers.
 *
 *  It goes without saying, but you should not set this to YES in a production app.
 *
 *  Default = NO
 */
@property (nonatomic, assign) BOOL terminateAppOnEnvironemntChange;

/**
 *  Set the new environment. 
 *  
 *  If terminateAppOnEnvironemntChange is set to YES then then app will call abort()
 *  The new environment will be saved in NSUserDefaults.
 *
 *  @param newEnvironment The new environment
 */
- (void)changeToEnvironment:(URBNEnvironment *)newEnvironment;

@end

NS_ASSUME_NONNULL_END
