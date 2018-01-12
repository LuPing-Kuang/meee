//
//  NaviController.m
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "NaviController.h"

@interface NaviController ()<UINavigationControllerDelegate>

@end

@implementation NaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate=self;
    
    self.navigationBar.tintColor=gray_4;
    
    self.navigationBar.translucent=NO;
    
//    self.navigationBar.tintColor=[UIColor whiteColor];
    
//    self.navigationBar.shadowImage=[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(self.navigationBar.bounds.size.width, 0.5)];
    
    
    
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:gray_2,NSForegroundColorAttributeName, nil]];
//    // Do any additional setup after loading the view.
//    
//    [self setNavigationColorShowImage:YES];
//    
    [self.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"back"]];
    [self.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back"]];
//
//    if([[[UIDevice currentDevice]systemVersion]doubleValue]>=11){
//        [[UIBarButtonItem appearance] setTitlePositionAdjustment:UIOffsetMake(5, 0) forBarMetrics:UIBarMetricsDefault];
//    }
}

//-(void)setNavigationColorShowImage:(BOOL)showImage
//{
//    //custom draw image
//    CGFloat statusHeight=[[UIApplication sharedApplication] statusBarFrame].size.height;
//    
//    CGSize size=CGSizeMake(self.navigationBar.bounds.size.width, self.navigationBar.bounds.size.height+statusHeight);
//    UIImage* mainColorBg=[UIImage imageWithColor:_mainColor size:size];
//    
//    
//    UIGraphicsBeginImageContext(size);
//    [mainColorBg drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    
//    if (showImage) {
//        UIImage* cityImage=[UIImage imageNamed:@"buildings"];
//        [cityImage drawInRect:CGRectMake(0, statusHeight, size.width, size.height-statusHeight) blendMode:kCGBlendModeNormal alpha:0.2];
//    }
//    
//    UIImage *naviBgImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    [self.navigationBar setBackgroundImage:naviBgImage forBarMetrics:UIBarMetricsDefault];
//}

//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count!=0) {
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:animated];
    
//    UIBarButtonItem* ba=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    viewController.navigationItem.backBarButtonItem=ba;
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIBarButtonItem* ba=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    viewController.navigationItem.backBarButtonItem=ba;
}

@end
