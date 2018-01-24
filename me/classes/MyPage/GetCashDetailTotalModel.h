//
//  GetCashDetailTotalModel.h
//  me
//
//  Created by KLP on 2018/1/20.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetCashDetailModel.h"

typedef NS_ENUM(NSInteger,GetCashDetailType)
{
    GetCashDetailTypeAll = 0,
    GetCashDetailTypeWaitAudit = 1,
    GetCashDetailTypeWaitPay = 2,
    GetCashDetailTypeAlreadyPay = 3,
    GetCashDetailTypeInvalid = 4,
    
};

@interface GetCashDetailTotalModel : NSObject

+(GetCashDetailType)cashTypeForPagerIndex:(NSInteger)index;
+(NSInteger)pageIndexForCashType:(GetCashDetailType)type;
+(NSString*)titleForCashType:(GetCashDetailType)type;

/* 预计佣金*/
@property (nonatomic, copy) NSString *commissioncount;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *pagesize;
@property (nonatomic, copy) NSString *pagecount;
@property (nonatomic, copy) NSString *textyuan;
/* 佣金*/
@property (nonatomic, copy) NSString *textcomm;
/* 提现明细*/
@property (nonatomic, copy) NSString *textcomd;


@property (nonatomic, strong) NSArray <GetCashDetailModel*>*list;



@end


