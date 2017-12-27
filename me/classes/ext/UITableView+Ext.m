//
//  UITableView+Ext.m
//  zhanmao
//
//  Created by bangju on 2017/11/1.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "UITableView+Ext.h"

@implementation UITableView (Ext)

-(void)registerNibName:(NSString *)nibName
{
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
}

-(void)registerClassName:(NSString *)className
{
    [self registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
}

@end
