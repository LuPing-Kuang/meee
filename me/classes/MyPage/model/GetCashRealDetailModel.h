//
//  GetCashRealDetailModel.h
//  me
//
//  Created by HeYang on 2018/5/2.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GetCashRealDetailGoodModel;

@interface GetCashRealDetailModel : NSObject


@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *agentid;
@property (nonatomic, copy) NSString *ordersn;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *goodsprice;
@property (nonatomic, copy) NSString *dispatchprice;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *paytype;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *ordercommission;
@property (nonatomic, copy) NSString *orderpay;

@property (nonatomic, strong) NSArray <GetCashRealDetailGoodModel*>*goods;



@end


@interface GetCashRealDetailGoodModel : NSObject


@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *goodsid;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *optionname;
@property (nonatomic, copy) NSString *commission1;
@property (nonatomic, copy) NSString *commission2;
@property (nonatomic, copy) NSString *commission3;
@property (nonatomic, copy) NSString *commissions;
@property (nonatomic, copy) NSString *status1;
@property (nonatomic, copy) NSString *status2;
@property (nonatomic, copy) NSString *status3;
@property (nonatomic, copy) NSString *content1;
@property (nonatomic, copy) NSString *content2;
@property (nonatomic, copy) NSString *content3;
@property (nonatomic, copy) NSString *commission;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *level;


@end









