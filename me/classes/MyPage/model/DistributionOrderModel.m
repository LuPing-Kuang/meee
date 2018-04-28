//
//  DistributionOrderModel.m
//  me
//
//  Created by KLP on 2018/1/20.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "DistributionOrderModel.h"

@implementation DistributionOrderModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"order_goods" : [DisOrder_goodsModel class]};
}


@end


@implementation DisOrder_goodsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

@end


@implementation BuyerModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}





@end

