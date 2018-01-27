//
//  UserDataLoader.m
//  me
//
//  Created by KLP on 2018/1/25.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "UserDataLoader.h"
#import "MyfavouriteModel.h"
@implementation UserDataLoader

//获取个人信息
+ (void)getPersonalMsgwithCompleted:(LoadServerDataFinishedBlock)finish{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserModel token] forKey:@"access_token"];
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member.info.face" parameters:dic success_status_ok:^(NSURLSessionDataTask *task, id data) {
        UserModel *model = [UserModel mj_objectWithKeyValues:data];
        if (finish) {
            finish(model,YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorMsg) {
        if (finish) {
            finish(errorMsg,NO);
        }
    }];
}

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


//退出登陆
+ (void)logoutwithCompleted:(LoadServerDataFinishedBlock)finish{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserModel token] forKey:@"access_token"];
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=account.logout" parameters:dic success_status_ok:^(NSURLSessionDataTask *task, id data) {
        if (finish) {
            finish(data,YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorMsg) {
        if (finish) {
            finish(errorMsg,NO);
        }
    }];
}

//忘记密码
+ (void)forgetPsWithMobile:(NSString*)mobile WithPwd:(NSString*)pwd WithVerifycode:(NSString*)verifycode withCompleted:(LoadServerDataFinishedBlock)finish{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:mobile forKey:@"mobile"];
    [dic setValue:pwd forKey:@"pwd"];
    [dic setValue:verifycode forKey:@"verifycode"];
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=account.forget" parameters:dic success_status_ok:^(NSURLSessionDataTask *task, id data) {
        if (finish) {
            finish(data,YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorMsg) {
        if (finish) {
            finish(errorMsg,NO);
        }
    }];
}


//修改密码
+ (void)changePsWithMobile:(NSString*)mobile WithPwd:(NSString*)pwd WithVerifycode:(NSString*)verifycode withCompleted:(LoadServerDataFinishedBlock)finish{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserModel token] forKey:@"access_token"];
    [dic setValue:mobile forKey:@"mobile"];
    [dic setValue:pwd forKey:@"pwd"];
    [dic setValue:verifycode forKey:@"verifycode"];
    [dic setValue:pwd forKey:@"rpwd"];
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member.changepwd" parameters:dic success_status_ok:^(NSURLSessionDataTask *task, id data) {
        if (finish) {
            finish(data,YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorMsg) {
        if (finish) {
            finish(errorMsg,NO);
        }
    }];
    
}

//添加地址
+ (void)addAddressData:(NSDictionary*)addressdata withCompleted:(LoadServerDataFinishedBlock)finish{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserModel token] forKey:@"access_token"];
    [dic setValue:addressdata forKey:@"addressdata"];
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member.address.submit" parameters:dic success_status_ok:^(NSURLSessionDataTask *task, id data) {
        if (finish) {
            finish(data,YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorMsg) {
        if (finish) {
            finish(errorMsg,NO);
        }
    }];
    
}


//删除地址
+ (void)deleteAddress:(NSString*)addressId withCompleted:(LoadServerDataFinishedBlock)finish{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserModel token] forKey:@"access_token"];
    [dic setValue:addressId forKey:@"id"];
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member.address.delete" parameters:dic success_status_ok:^(NSURLSessionDataTask *task, id data) {
        if (finish) {
            finish(data,YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorMsg) {
        if (finish) {
            finish(errorMsg,NO);
        }
    }];
}


//设为默认地址
+ (void)setDefaultAddress:(NSString*)addressId withCompleted:(LoadServerDataFinishedBlock)finish{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserModel token] forKey:@"access_token"];
    [dic setValue:addressId forKey:@"id"];
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member.address.set_default" parameters:dic success_status_ok:^(NSURLSessionDataTask *task, id data) {
        if (finish) {
            finish(data,YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorMsg) {
        if (finish) {
            finish(errorMsg,NO);
        }
    }];
}


+ (void)getMyFavouriteProductPage:(NSInteger)page pagesize:(NSInteger)pagesize withCompleted:(LoadServerDataFinishedBlock)finish{
    
    NSMutableDictionary *dic = [ZZHttpTool pageParamsWithPage:page size:pagesize];
    [dic setValue:[UserModel token] forKey:@"access_token"];
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member.favorite.get_list" parameters:dic success_status_ok:^(NSURLSessionDataTask *task, id data) {
        if (finish) {
            NSArray *modelArr = [MyfavouriteModel mj_objectArrayWithKeyValuesArray:data[@"list"]];
            finish(modelArr,YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorMsg) {
        if (finish) {
            finish(errorMsg,NO);
        }
    }];
    
}



//取消收藏
+ (void)CancelFocusMyFavouriteProductIds:(NSString*)Ids withCompleted:(LoadServerDataFinishedBlock)finish{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserModel token] forKey:@"access_token"];
    [dic setValue:Ids forKey:@"ids"];
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member.favorite.remove" parameters:dic success_status_ok:^(NSURLSessionDataTask *task, id data) {
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
