//
//  GetCashDetailTotalModel.m
//  me
//
//  Created by KLP on 2018/1/20.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "GetCashDetailTotalModel.h"

@implementation GetCashDetailTotalModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [GetCashDetailModel class]};
}






+(GetCashDetailType)cashTypeForPagerIndex:(NSInteger)index{
    switch (index) {
        case 0:
            return GetCashDetailTypeAll;
            break;
        case 1:
            return GetCashDetailTypeWaitAudit;
            break;
        case 2:
            return GetCashDetailTypeWaitPay;
            break;
        case 3:
            return GetCashDetailTypeAlreadyPay;
            break;
        case 4:
            return GetCashDetailTypeInvalid;
            break;
        default:
            break;
    }
    return 0;
}



+(NSInteger)pageIndexForOrderType:(GetCashDetailType)type
{
    switch (type) {
        case GetCashDetailTypeAll:
            return 0;
            break;
        case GetCashDetailTypeWaitAudit:
            return 1;
            break;
        case GetCashDetailTypeWaitPay:
            return 2;
            break;
        case GetCashDetailTypeAlreadyPay:
            return 3;
            break;
        case GetCashDetailTypeInvalid:
            return 4;
            break;
        default:
            break;
    }
    return 0;
}



+(NSString*)titleForCashType:(GetCashDetailType)type
{
    switch (type) {
        case GetCashDetailTypeAll:
            return @"所有";
            break;
        case GetCashDetailTypeWaitAudit:
            return @"待审核";
            break;
        case GetCashDetailTypeWaitPay:
            return @"待打款";
            break;
        case GetCashDetailTypeAlreadyPay:
            return @"已打款";
            break;
        case GetCashDetailTypeInvalid:
            return @"无效";
            break;
        default:
            break;
    }
    return @"";
}



@end
