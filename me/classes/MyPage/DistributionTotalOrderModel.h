//
//  DistributionTotalOrderModel.h
//  me
//
//  Created by KLP on 2018/1/20.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DistributionOrderModel.h"

typedef NS_ENUM(NSInteger,DistributionOrderType)
{
    DistributionOrderTypeWaitPay = 0,
    DistributionOrderTypeAlreadyPay = 1,
    DistributionOrderTypeAlreadyFinish = 3,
    
    DistributionOrderTypeAll = 11,
};

@interface DistributionTotalOrderModel : NSObject

+(DistributionOrderType)orderTypeForPagerIndex:(NSInteger)index;
+(NSInteger)pageIndexForOrderType:(DistributionOrderType)type;
+(NSString*)titleForOrderType:(DistributionOrderType)type;

@property (nonatomic, copy) NSString *pagesize;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *pagecount;
@property (nonatomic, copy) NSString *comtotal;
@property (nonatomic, copy) NSString *textyuan;
@property (nonatomic, copy) NSString *textorder;
@property (nonatomic, copy) NSString *textctotal;
@property (nonatomic, copy) NSString *openorderdetail;
@property (nonatomic, copy) NSString *openorderbuyer;

@property (nonatomic, strong) NSArray <DistributionOrderModel*>*list;



@end




