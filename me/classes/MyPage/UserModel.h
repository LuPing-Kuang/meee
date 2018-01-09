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

@end
