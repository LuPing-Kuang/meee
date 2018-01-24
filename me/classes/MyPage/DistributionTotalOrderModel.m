//
//  DistributionTotalOrderModel.m
//  me
//
//  Created by KLP on 2018/1/20.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "DistributionTotalOrderModel.h"

@implementation DistributionTotalOrderModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"list" : [DistributionOrderModel class]};
}

+(DistributionOrderType)orderTypeForPagerIndex:(NSInteger)index;
{
    switch (index) {
        case 0:
            return DistributionOrderTypeAll;
            break;
        case 1:
            return DistributionOrderTypeWaitPay;
            break;
        case 2:
            return DistributionOrderTypeAlreadyPay;
            break;
        case 3:
            return DistributionOrderTypeAlreadyFinish;
            break;
        default:
            break;
    }
    return 0;
}


+(NSInteger)pageIndexForOrderType:(DistributionOrderType)type
{
    switch (type) {
        case DistributionOrderTypeAll:
            return 0;
            break;
        case DistributionOrderTypeWaitPay:
            return 1;
            break;
        case DistributionOrderTypeAlreadyPay:
            return 2;
            break;
        case DistributionOrderTypeAlreadyFinish:
            return 3;
            break;
        default:
            break;
    }
    return 0;
}

+(NSString*)titleForOrderType:(DistributionOrderType)type;
{
    switch (type) {
        case DistributionOrderTypeAll:
            return @"所有";
            break;
        case DistributionOrderTypeWaitPay:
            return @"待付款";
            break;
        case DistributionOrderTypeAlreadyPay:
            return @"已付款";
            break;
        case DistributionOrderTypeAlreadyFinish:
            return @"已完成";
            break;
        default:
            break;
    }
    return @"";
}

@end
