//
//  GetCashRealDetailModel.m
//  me
//
//  Created by HeYang on 2018/5/2.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "GetCashRealDetailModel.h"

@implementation GetCashRealDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"goods" : [GetCashRealDetailGoodModel class],
             };
}

@end


@implementation GetCashRealDetailGoodModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

@end
