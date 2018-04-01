//
//  AppDelegate.m
//  me
//
//  Created by jam on 2017/12/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "AppDelegate.h"
#import "WechatHandler.h"
#import "BaseWebViewController.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    BaseWebViewController* preloadWeb=[[BaseWebViewController alloc]initWithUrl:nil];
    preloadWeb.view.backgroundColor=[UIColor whiteColor];
    
    [WXApi registerApp:kWechatAppKey];
   
    [Bugly startWithAppId:kbuglyAppid];
    [[BaiduNavManager sharedInstance] startWithAppKey:kbaiduNavAppKey];
    
    [HUDManager changeHudToBlack];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToLogin:) name:UserNeed_Login_Notification object:nil];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    if ([WXApi handleOpenURL:url delegate:[WechatHandler sharedInstance]]) {
        return YES;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if ([WXApi handleOpenURL:url delegate:[WechatHandler sharedInstance]]) {
        return YES;
    }
    return YES;
}


- (void)goToLogin:(NSNotification*)notifcation{
    NSDictionary *dic = notifcation.object;
    
    [UserModel saveToken:nil];
    AccountManager.sharedInstance.currentUser = nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UserLogin_Notification object:nil];
    
    if ([[dic valueForKey:@"needMsg"] isKindOfClass:[NSString class]] && [[dic valueForKey:@"needMsg"] isEqualToString:@"1"]) {
        [HUDManager showErrorMsg:@"登录已失效，请重新登录！"];
    }
    
    UINavigationController *nav = (UINavigationController*)self.window.rootViewController;
    
    if ([nav.presentedViewController isKindOfClass:[LoginViewController class]] || [nav.presentingViewController isKindOfClass:[LoginViewController class]]) {
        return;
    }
    
    LoginViewController *vc = [[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    [nav presentViewController:vc animated:YES completion:nil];
    
}

@end
