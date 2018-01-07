//
//  UserModel.m
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "UserModel.h"

#define UserKey @"CW5QPB0hXYfXt3zY8QKLI8ahj95yMPdF"
#define UserPasswordKey @"CW5QPB0hXYfXt3zY8QK99I8ahj95yMPdF"
#define UserTokenKey @"CW5QrB0hXYfXt3zY8QK99I8ahj95yMPdF"

@implementation UserModel

+(NSString*)token
{
//    #warning test user token
#if DEBUG
    return @"666";
#else
    NSString* to=[[NSUserDefaults standardUserDefaults]valueForKey:UserTokenKey];
    return to;
#endif
}

+(void)saveToken:(NSString *)token
{
    if (token.length==0) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:UserTokenKey];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setValue:token forKey:UserTokenKey];
    }
}

@end
