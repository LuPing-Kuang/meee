//
//  AllEnums.h
//  me
//
//  Created by KLP on 2018/1/25.
//  Copyright © 2018年 bangju. All rights reserved.
//

#ifndef AllEnums_h
#define AllEnums_h

typedef void (^LoadServerDataFinishedBlock) (id result,BOOL success);

#pragma mark -
#pragma mark - 默认参数
static NSString *const LOADING_WORD = @"加载中...";
static NSString *const SERVEERROR_WORD = @"服务器返回错误";
static NSInteger const DefaultCountDownSecond = 60;
//

#pragma mark -
#pragma mark - 通知
static NSString *const UserLogin_Notification = @"UserLogin_Notification";

#pragma mark -
#pragma mark - 第三方sdk
//bugly崩溃日志记录
static NSString *const kbuglyAppid = @"acc2efc4be";
static NSString *const kbuglySecect = @"453870ab-e89e-40ee-ac8e-a0b18af4601a";

//百度地图
static NSString *const kbaiduNavAppid = @"10789711";
static NSString *const kbaiduNavAppKey = @"EQ82t7k8znhu5wxxwNqrCciC48bvNZgZ";



#endif /* AllEnums_h */
