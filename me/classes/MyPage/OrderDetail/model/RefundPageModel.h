//
//  RefundPageModel.h
//  me
//
//  Created by 邝路平 on 2018/4/2.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RefundPageOrderModel;
@class RefundDetailModel;

@interface RefundPageModel : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *refundtype;
@property (nonatomic,strong) NSString *refundreason;
@property (nonatomic,strong) NSString *refundexplain;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) RefundPageOrderModel *order;
@property (nonatomic,assign) BOOL refund;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSArray *imgs;
@property (nonatomic,strong) NSString *rtypeIndex;
@property (nonatomic,strong) NSString *reasonIndex;

@property (nonatomic,strong) RefundDetailModel *refundModel;

@end


@interface RefundPageOrderModel : NSObject

@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *refundid;
@property (nonatomic,strong) NSString *goodsprice;
@property (nonatomic,strong) NSString *dispatchprice;
@property (nonatomic,strong) NSString *deductprice;
@property (nonatomic,strong) NSString *deductcredit2;
@property (nonatomic,strong) NSString *finishtime;
@property (nonatomic,strong) NSString *isverify;
@property (nonatomic,strong) NSString *virtual1;
@property (nonatomic,strong) NSString *refundstate;
@property (nonatomic,strong) NSString *merchid;
@property (nonatomic,assign) BOOL cannotrefund;
@property (nonatomic,strong) NSString *refundprice;  //(最大退款金额)

@end



@interface RefundDetailModel : NSObject

@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *uniacid;
@property (nonatomic,strong) NSString *orderid;
@property (nonatomic,strong) NSString *refundno;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *reason;
@property (nonatomic,strong) NSString *images;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *createtime;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *reply;
@property (nonatomic,strong) NSString *refundtype;
@property (nonatomic,strong) NSString *orderprice;
@property (nonatomic,strong) NSString *applyprice;
@property (nonatomic,strong) NSArray *imgs;
@property (nonatomic,strong) NSString *rtype;
@property (nonatomic,strong) NSString *refundaddress;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *express;
@property (nonatomic,strong) NSString *expresscom;
@property (nonatomic,strong) NSString *expresssn;
@property (nonatomic,strong) NSString *operatetime;
@property (nonatomic,strong) NSString *sendtime;
@property (nonatomic,strong) NSString *returntime;
@property (nonatomic,strong) NSString *refundtime;
@property (nonatomic,strong) NSString *rexpress;
@property (nonatomic,strong) NSString *rexpresscom;
@property (nonatomic,strong) NSString *rexpresssn;
@property (nonatomic,strong) NSString *refundaddressid;
@property (nonatomic,strong) NSString *endtime;
@property (nonatomic,strong) NSString *realprice;
@property (nonatomic,strong) NSString *merchid;
@property (nonatomic,strong) NSString *text;


@end



