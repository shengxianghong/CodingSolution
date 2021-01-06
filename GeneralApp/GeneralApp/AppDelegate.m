//
//  AppDelegate.m
//  GeneralApp
//
//  Created by zkworld on 2020/12/31.
//

#import "AppDelegate.h"
#import "TABAnimated.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[TABAnimated sharedAnimated] initWithOnlySkeleton];
    [TABAnimated sharedAnimated].openLog = YES;
    return YES;
}

@end
