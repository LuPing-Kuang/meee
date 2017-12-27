//
//  UINavigationController+Children.m
//  zhanmao
//
//  Created by jam on 2017/12/14.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "UINavigationController+Children.h"

@implementation UINavigationController (Children)

-(void)removeViewController:(UIViewController *)controller
{
    NSMutableArray* arr=[NSMutableArray arrayWithArray:self.viewControllers];
    if ([arr containsObject:controller]) {
        [arr removeObject:controller];
    }
    self.viewControllers=arr;
}

-(void)removeViewControllersKindOfClass:(Class)someClass
{
    NSMutableArray* arr=[NSMutableArray arrayWithArray:self.viewControllers];
    NSMutableArray* toDelete=[NSMutableArray array];
    for (UIViewController* vc in arr) {
        if ([vc isKindOfClass:someClass]) {
            [toDelete addObject:vc];
        }
    }
    [arr removeObjectsInArray:toDelete];
    self.viewControllers=arr;
}

@end
