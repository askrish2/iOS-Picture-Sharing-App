//
//  AppDelegate.m
//  PictureSharing
//
//  Created by Ashwini Krishnan on 8/4/16.
//  Copyright (c) 2016 Ash Krishnan. All rights reserved.
//

#import "AppDelegate.h"
#import "FeedViewController.h"
#import "PhotoViewController.h"
#import <GGTabBar/GGTabBar.h>
#import "GGTabBar/GGTabBarController.h"
//#import <GGTabBarController/GGTabBarController.h>
//#import <GGTabBarController/GGTabBarController.h>
#import <SimpleAuth/SimpleAuth.h>
#import "CLImageEditor.h"
//#import "Pods/imglyKit/IMGLYMainEditorViewController.h"
//#import "Pods/GGTabBar/GGTabBarController.h"

@interface AppDelegate ()
@property (nonatomic) NSString *input;
@property (nonatomic) UIView *view;
//@import imglyKit
@end
 
@implementation AppDelegate

//[SSKeychain setAccessibilityType:kSecAttrAccessibleWhenUnlocked];

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    self.input  = [[alertView textFieldAtIndex:0] text];
    NSLog(@"Entered: %@", self.input);

}

- (void) try {
    NSLog(@"rerew");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /**
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"This is an example alert!" delegate:self cancelButtonTitle:@"Hide" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
//[alert release];
     **/
    /**
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"INPUT BELOW" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    NSLog(@"YOOO");
    [self alertView:alert clickedButtonAtIndex:0];
    dispatch_async(dispatch_get_main_queue(), ^{
    
    
     NSLog(@"Entereddd: %@", self.input);
    if ([self.input  isEqual: @"tumblr"]) {
        NSLog(@"YOOO");
    }
    });
    **/
    SimpleAuth.configuration[@"tumblr"] = @{
      @"consumer_key" : @"YsYwy8V8FvlBGbHFV9OFWokio8MsO6AygeCOecN5ywyxTk0AM6",
      @"consumer_secret" : @"vIzLde141yKnVMRJH9mnftLGEmskFQ87MOZ5zcpILvGJS1jUPu",
      };
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //PhotoViewController *photoViewController = [[PhotoViewController alloc] init];
    
//    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:photoViewController];
//    UINavigationBar *navigationBar = navigationController.navigationBar;
//    navigationBar.barTintColor = [UIColor colorWithRed:242.0 / 255.0 green:122.0 / 255.0 blue:87.0 / 255.0 alpha:1.0];
//    navigationBar.barStyle = UIBarStyleBlackOpaque;
   
    //IMGLYMainEditorViewController *v1 = [[IMGLYMainEditorViewController alloc] initgroups(<#const char *#>, <#int#>)];
    
    //CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:[UIImage imageNamed:@"like"]];
    //editor.delegate = self;

    
    
    GGTabBarController *tabBar = [[GGTabBarController alloc] init];
    PhotoViewController *photoViewController1 = [[PhotoViewController alloc] init];
   // PhotoViewController *photoViewController2 = [[PhotoViewController alloc] init];
    PhotoViewController *photoViewController3 = [[PhotoViewController alloc] init];
   // PhotoViewController *photoViewController4 = [[PhotoViewController alloc] init];
    FeedViewController *f1 = [[FeedViewController alloc] init];
    //tabBar.tabBarAppearanceSettings = @{kTabBarAppearanceHeight : @(100.0)};
    
    tabBar.viewControllers = @[photoViewController1, f1];// photoViewController3, editor];
    
    
    tabBar.selectedIndex = 3;
    
    self.window.rootViewController = tabBar;
    
    //self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
