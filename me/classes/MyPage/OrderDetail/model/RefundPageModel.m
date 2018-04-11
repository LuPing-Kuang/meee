//
//  RefundPageModel.m
//  me
//
//  Created by 邝路平 on 2018/4/2.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "RefundPageModel.h"

@implementation RefundPageModel

@end


@implementation RefundPageOrderModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id",
             @"virtual1" : @"virtual",
             };
    
}


@end

@implementation RefundDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}


@end
