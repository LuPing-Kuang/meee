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

@property NSString* avatar;
@property NSString* nickname;
@property NSString* levelname;
@property NSString* money;
@property NSNumber* credit;

@end
