//
//  MyOrderDetailModel.m
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyOrderDetailModel.h"

@implementation MyOrderDetailModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"goods" : [OrderGoodDetailModel class],
             @"express" : [TransportMsgListModel class]
             };
}

@end


@implementation OrderDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id",
             @"virtuall" : @"virtual"
             };
}



- (MyOrderStatusType)statusType {
    if ([self.status isEqualToString:@"-1"]) {
        return MyOrderStatusType_Cancel;
    }else if ([self.status isEqualToString:@"0"]){
        return MyOrderStatusType_WaitPay;
    }else if ([self.status isEqualToString:@"1"]){
        return MyOrderStatusType_WaitSend;
    }else if ([self.status isEqualToString:@"2"]){
        return MyOrderStatusType_WaitGet;
    }else if ([self.status isEqualToString:@"3"]){
        return MyOrderStatusType_Finish;
    }else if ([self.status isEqualToString:@"4"]){
        return MyOrderStatusType_Refund;
    }else{
        return MyOrderStatusType_Delete;
    }
}

@end


@implementation OrderGoodDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"diyformfields" : [OrderGoodFieldModel class]
             };
}

@end


@implementation OrderGoodFieldModel



@end







