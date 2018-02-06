//
//  UserModel.h
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UserInfoDidUpdateNotification @"UserInfoDidUpdateNotification"

@interface UserModel : NSObject

+(NSString*)token;
+(void)saveToken:(NSString*)token;

@property (nonatomic,strong) NSString* avatar;
@property (nonatomic,strong) NSString* nickname;
@property (nonatomic,strong) NSString* levelname;
@property (nonatomic,strong) NSString* money;
@property (nonatomic,strong) NSNumber* credit;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *idd;


/*
 status:1,isagent:1 合伙人
 status:0,isagent:1 申请中，待审核
 status:0,isagent:0 未申请
 */
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *isagent;
@property (nonatomic, strong) NSString *weixin;




@end
