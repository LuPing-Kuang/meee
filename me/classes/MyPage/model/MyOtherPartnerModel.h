//
//  MyOtherPartnerModel.h
//  me
//
//  Created by KLP on 2018/1/20.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOtherPartnerModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *uniacid;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *avatar;
/* (1:是分销商,0:不是) */
@property (nonatomic, copy) NSString *isagent;
/* 右边+后面的数字 */
@property (nonatomic, copy) NSString *commission_total;
/* 多少个成员 */
@property (nonatomic, copy) NSString *agentcount;
/* 订单数量 */
@property (nonatomic, copy) NSString *ordercount;
/* 消费 */
@property (nonatomic, copy) NSString *commission_pay;

//调试中 订单数量 消费金额

@end









