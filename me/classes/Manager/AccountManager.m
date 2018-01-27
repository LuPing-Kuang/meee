//
//  AccountManager.m
//  me
//
//  Created by KLP on 2018/1/27.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "AccountManager.h"

@implementation AccountManager

+ (instancetype)sharedInstance{
    static AccountManager *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        obj = [[AccountManager alloc]init];
        
    });
    return obj;
}

@end
