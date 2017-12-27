//
//  UINavigationController+Children.h
//  zhanmao
//
//  Created by jam on 2017/12/14.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Children)

-(void)removeViewController:(UIViewController*)controller;

-(void)removeViewControllersKindOfClass:(Class)someClass;

@end
