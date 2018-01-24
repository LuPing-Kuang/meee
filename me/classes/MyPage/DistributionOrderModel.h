//
//  DistributionOrderModel.h
//  me
//
//  Created by KLP on 2018/1/20.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

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






@end
