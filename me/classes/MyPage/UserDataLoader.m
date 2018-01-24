//
//  UserDataLoader.m
//  me
//
//  Created by KLP on 2018/1/25.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "UserDataLoader.h"

@implementation UserDataLoader
//获取手机验证码
+ (void)getCodeWithMobile:(NSString*)mobile WithTemp:(NSString*)temp withCompleted:(LoadServerDataFinishedBlock)finish{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:mobile forKey:@"mobile"];
    [dic setValue:@"0" forKey:@"imgcode"];
    [dic setValue:temp forKey:@"temp"];
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=account.verifycode" parameters:dic success_status_ok:^(NSURLSessionDataTask *task, id data) {
        if (finish) {
            finish(data,YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorMsg) {
        if (finish) {
            finish(errorMsg,NO);
        }
    }];
    
}

//注册提交
+ (void)registerWithMobile:(NSString*)mobile WithPwd:(NSString*)pwd WithVerifycode:(NSString*)verifycode withCompleted:(LoadServerDataFinishedBlock)finish{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:mobile forKey:@"mobile"];
    [dic setValue:pwd forKey:@"pwd"];
    [dic setValue:verifycode forKey:@"verifycode"];
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=account.register" parameters:dic success_status_ok:^(NSURLSessionDataTask *task, id data) {
        if (finish) {
            finish(data,YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorMsg) {
        if (finish) {
            finish(errorMsg,NO);
        }
    }];
}


//登陆提交
+ (void)loginWithMobile:(NSString*)mobile WithPwd:(NSString*)pwd withCompleted:(LoadServerDataFinishedBlock)finish{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:mobile forKey:@"mobile"];
    [dic setValue:pwd forKey:@"pwd"];
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=account.login" parameters:dic success_status_ok:^(NSURLSessionDataTask *task, id data) {
        if (finish) {
            finish(data,YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorMsg) {
        if (finish) {
            finish(errorMsg,NO);
        }
    }];
}


@end
