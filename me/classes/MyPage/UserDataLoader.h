//
//  UserDataLoader.h
//  me
//
//  Created by KLP on 2018/1/25.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataLoader : NSObject

//获取个人信息
+ (void)getPersonalMsgwithCompleted:(LoadServerDataFinishedBlock)finish;

//获取手机验证码
/* temp 注册:sms_reg,忘记密码:sms_forget,绑定手机:sms_bind,修改密码:sms_changepwd */
+ (void)getCodeWithMobile:(NSString*)mobile WithTemp:(NSString*)temp withCompleted:(LoadServerDataFinishedBlock)finish;

//注册提交
+ (void)registerWithMobile:(NSString*)mobile WithPwd:(NSString*)pwd WithVerifycode:(NSString*)verifycode withCompleted:(LoadServerDataFinishedBlock)finish;

//登陆提交
+ (void)loginWithMobile:(NSString*)mobile WithPwd:(NSString*)pwd withCompleted:(LoadServerDataFinishedBlock)finish;

//退出登陆
+ (void)logoutwithCompleted:(LoadServerDataFinishedBlock)finish;


#pragma mark -
#pragma mark - 地址模块
//添加和修改地址
+ (void)addAddressData:(NSDictionary*)addressdata withCompleted:(LoadServerDataFinishedBlock)finish;

//删除地址
+ (void)deleteAddress:(NSString*)addressId withCompleted:(LoadServerDataFinishedBlock)finish;

//设为默认地址
+ (void)setDefaultAddress:(NSString*)addressId withCompleted:(LoadServerDataFinishedBlock)finish;



@end
