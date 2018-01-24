//
//  GetCashDetailModel.h
//  me
//
//  Created by KLP on 2018/1/20.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCashDetailModel : NSObject

/* 提现明细id*/
@property (nonatomic, copy) NSString *ID;
/* 分销商id*/
@property (nonatomic, copy) NSString *mid;
/* type
 0:提现到余额,1:提现到微信红包,2:提现到支付宝,3:提现到银行卡
 */
@property (nonatomic, copy) NSString *type;
/* 申请佣金*/
@property (nonatomic, copy) NSString *commission;
/* 右上角的佣金*/
@property (nonatomic, copy) NSString *commission_pay;
/* (0:所有，1:待审核，2:待打款，3:已打款，4:无效)*/
@property (nonatomic, copy) NSString *status;
/* 状态*/
@property (nonatomic, copy) NSString *statusstr;
/* 交易时间*/
@property (nonatomic, copy) NSString *dealtime;
/* 实际金额*/
@property (nonatomic, copy) NSString *realmoney;
/* 手续费*/
@property (nonatomic, copy) NSString *deductionmoney;
/* 公众号id*/
@property (nonatomic, copy) NSString *uniacid;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *applytime;
@property (nonatomic, copy) NSString *checktime;
@property (nonatomic, copy) NSString *paytime;
@property (nonatomic, copy) NSString *invalidtime;
@property (nonatomic, copy) NSString *refusetime;
@property (nonatomic, copy) NSString *charge;
@property (nonatomic, copy) NSString *beginmoney;
@property (nonatomic, copy) NSString *applyno;
@property (nonatomic, copy) NSString *endmoney;
@property (nonatomic, copy) NSString *alipay;
@property (nonatomic, copy) NSString *bankname;
@property (nonatomic, copy) NSString *bankcard;
@property (nonatomic, copy) NSString *realname;
@property (nonatomic, copy) NSString *repurchase;
@property (nonatomic, copy) NSString *alipay1;
@property (nonatomic, copy) NSString *bankname1;
@property (nonatomic, copy) NSString *bankcard1;
@property (nonatomic, copy) NSString *sendmoney;
@property (nonatomic, copy) NSString *senddata;


@end



