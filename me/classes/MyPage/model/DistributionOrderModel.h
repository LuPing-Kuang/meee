//
//  DistributionOrderModel.h
//  me
//
//  Created by KLP on 2018/1/20.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DisOrder_goodsModel;
@class BuyerModel;

@interface DistributionOrderModel : NSObject
//订单ID
@property (nonatomic, copy) NSString *ID;
//订单号
@property (nonatomic, copy) NSString *ordersn;
@property (nonatomic, copy) NSString *openid;
//下单时间
@property (nonatomic, copy) NSString *createtime;
//status
@property (nonatomic, copy) NSString *status;
//预计佣金
@property (nonatomic, copy) NSString *commission;
//等级
@property (nonatomic, copy) NSString *level;
//goods
@property (nonatomic, strong) NSArray *order_goods;
//goods
@property (nonatomic, strong) BuyerModel *buyer;


@end


@interface DisOrder_goodsModel : NSObject
//订单ID
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


@end


@interface BuyerModel : NSObject
//订单ID
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *realname;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *nickname_wechat;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *avatar_wechat;


@end

