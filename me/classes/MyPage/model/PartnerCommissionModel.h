//
//  PartnerCommissionModel.h
//  me
//
//  Created by KLP on 2018/1/19.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PartnerCommissionSetModel;

@interface PartnerCommissionModel : NSObject
/*累计佣金 */
@property (nonatomic, copy) NSString *commission_total;
/*可提现佣金 */
@property (nonatomic, copy) NSString *commission_ok;
/*已申请佣金 */
@property (nonatomic, copy) NSString *commission_apply;
/*代打款佣金 */
@property (nonatomic, copy) NSString *commission_check;
/*无效佣金 */
@property (nonatomic, copy) NSString *commission_fail;
/*成功提现佣金 */
@property (nonatomic, copy) NSString *commission_pay;
/*扣除提现手续费 */
@property (nonatomic, copy) NSString *commission_charge;
/*待收货佣金 */
@property (nonatomic, copy) NSString *commission_wait;
/*未结算佣金 */
@property (nonatomic, copy) NSString *commission_lock;

@property (nonatomic, strong) PartnerCommissionSetModel *set;
@property (nonatomic, assign) BOOL cansettle;

@end



@interface PartnerCommissionSetModel : NSObject
/*多少天后可以提现 */
@property (nonatomic, copy) NSString *settledays;
/*可提现佣金 */
@property (nonatomic, copy) NSString *withdraw;


@end














