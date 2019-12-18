//
//  AppDelegate.m
//  JXBeautyTestDemo
//
//  Created by 张亚超 on 2019/12/17.
//  Copyright © 2019 KUWO. All rights reserved.
//

#import "AppDelegate.h"
#import "JXHomeViewController.h"
@interface AppDelegate ()
@property (nonatomic ,strong)UIWindow *mainWindow;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.mainWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.mainWindow.backgroundColor = [UIColor whiteColor];
    
    JXHomeViewController *homeViewController = [[JXHomeViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homeViewController];
//    homeViewController.title = @"Home";
    self.mainWindow.rootViewController = homeViewController;
    
    //
    [self.mainWindow makeKeyAndVisible];
    
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}
//

@end
