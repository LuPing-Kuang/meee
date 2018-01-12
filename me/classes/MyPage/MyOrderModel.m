//
//  MyOrderModel.m
//  me
//
//  Created by jam on 2018/1/12.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyOrderModel.h"

@implementation MyOrderProductModel



@end

@implementation MyOrderModel

#pragma mark custom Titles and types

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"idd" : @"id",@"virtuall":@"virtual"};
}

+(MyOrderType)orderTypeForPagerIndex:(NSInteger)index;
{
    switch (index) {
        case 0:
            return MyOrderTypeAll;
            break;
        case 1:
            return MyOrderTypeNotPaid;
            break;
        case 2:
            return MyOrderTypeNotSent;
            break;
        case 3:
            return MyOrderTypeNotReceived;
            break;
        case 4:
            return MyOrderTypeFinished;
            break;
        default:
            break;
    }
    return 0;
}

+(NSInteger)pageIndexForOrderType:(MyOrderType)type
{
    switch (type) {
        case MyOrderTypeAll:
            return 0;
            break;
        case MyOrderTypeNotPaid:
            return 1;
            break;
        case MyOrderTypeNotSent:
            return 2;
            break;
        case MyOrderTypeNotReceived:
            return 3;
            break;
        case MyOrderTypeFinished:
            return 4;
            break;
        default:
            break;
    }
    return 0;
}

+(NSString*)titleForOrderType:(MyOrderType)type;
{
    switch (type) {
        case MyOrderTypeAll:
            return @"全部";
            break;
        case MyOrderTypeNotPaid:
            return @"待付款";
            break;
        case MyOrderTypeNotSent:
            return @"待发货";
            break;
        case MyOrderTypeNotReceived:
            return @"待收货";
            break;
        case MyOrderTypeFinished:
            return @"已完成";
            break;
        case MyOrderTypeExchanging:
            return @"退换货";
            break;
        case MyOrderTypeDeleted:
            return @"回收站";
            break;
        default:
            break;
    }
    return @"";
}

@end
