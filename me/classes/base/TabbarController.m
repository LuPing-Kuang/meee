//
//  TabbarController.m
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "TabbarController.h"
#import "HomePageCollectionViewController.h"
#import "ProductAllCollectionViewController.h"
#import "CartPageViewController.h"
#import "MyPageViewController.h"
#import "NaviController.h"
@interface TabbarController ()<UITabBarDelegate,UITabBarControllerDelegate>

@end

@implementation TabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.translucent=NO;
    
    self.tabBar.tintColor=_mainColor;
    self.delegate = self;
    
    NSArray* childs=self.childViewControllers;
    
    for (UIViewController* vc in childs) {
        UITabBarItem* item = vc.tabBarItem;
//        UIImage* img_n=item.image;
        UIImage* img_s=item.selectedImage;
//        item.image=img_n;
//        item.image=[img_n imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage=[img_s imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        if ([item respondsToSelector:@selector(setBadgeColor:)]) {
            [item setBadgeColor:_mainColor];
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            UINavigationController* nav=(UINavigationController*)vc;
            if (nav.topViewController) {
                nav.topViewController.view.backgroundColor=nav.topViewController.view.backgroundColor;
            }
        }
    }
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NaviController *vc = (NaviController*)viewController;
    UIViewController *myVc = vc.viewControllers[0];
    if ([myVc isKindOfClass:[MyPageViewController class]] || [myVc isKindOfClass:[CartPageViewController class]]) {
        if (has_login) {
            return YES;
        }else{
            
            UIViewController* log=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self presentViewController:log animated:YES completion:nil];
            
            return NO;
        }
        
    }
    
    return YES;
}





@end
