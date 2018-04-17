//
//  MyOrderDetailModel.h
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransportMsgModel.h"
#import "ProductionOrderModel.h"
@class OrderDetailModel;
@class OrderGoodDetailModel;
@class OrderGoodFieldModel;

typedef NS_ENUM(NSInteger,MyOrderStatusType)
{
    MyOrderStatusType_Cancel = -1,
    MyOrderStatusType_WaitPay = 0,
    MyOrderStatusType_WaitSend = 1,
    MyOrderStatusType_WaitGet = 2,
    MyOrderStatusType_Finish = 3,
    MyOrderStatusType_Refund = 4,
    MyOrderStatusType_Delete = 5

};


@interface MyOrderDetailModel : NSObject

@property (nonatomic,strong) OrderDetailModel *order;
@property (nonatomic,strong) NSArray <OrderGoodDetailModel*>*goods;
@property (nonatomic,strong) ProductionOrderAddressModel *address;
@property (nonatomic,strong) NSArray <TransportMsgListModel*>*express;

@end


@interface OrderDetailModel : NSObject
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *sendtype;
@property (nonatomic,strong) NSString *ordersn;
@property (nonatomic,strong) NSString *createtime;
@property (nonatomic,strong) NSString *paytime;
@property (nonatomic,strong) NSString *sendtime;
@property (nonatomic,strong) NSString *finishtime;
//( 订单状态:-1已取消,0待支付,1待发货,2待收货,3已完成,4退换货,5已删除(回收站) )"status": "-1",
@property (nonatomic,assign) MyOrderStatusType statusType;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *statusstr;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *goodsprice;
@property (nonatomic,strong) NSString *dispatchprice;
@property (nonatomic,strong) NSString *deductenough;
@property (nonatomic,strong) NSString *couponprice;
@property (nonatomic,strong) NSString *discountprice;
@property (nonatomic,strong) NSString *isdiscountprice;
@property (nonatomic,strong) NSString *deductprice;
@property (nonatomic,strong) NSString *deductcredit2;
@property (nonatomic,strong) NSString *diyformfields;
@property (nonatomic,strong) NSString *diyformdata;
@property (nonatomic,strong) NSString *showverify;
@property (nonatomic,strong) NSString *verifytitle;
@property (nonatomic,strong) NSString *dispatchtype;
@property (nonatomic,strong) NSString *verifyinfo;
@property (nonatomic,strong) NSString *virtuall;
@property (nonatomic,strong) NSString *virtual_str;
@property (nonatomic,strong) NSString *isvirtualsend;
@property (nonatomic,strong) NSString *virtualsend_info;
@property (nonatomic,assign) BOOL canrefund;
@property (nonatomic,strong) NSString *refundtext;
@property (nonatomic,strong) NSString *cancancel;
@property (nonatomic,strong) NSString *canpay;
@property (nonatomic,strong) NSString *canverify;
@property (nonatomic,strong) NSString *candelete;
@property (nonatomic,strong) NSString *cancomment;
@property (nonatomic,strong) NSString *cancomment2;
@property (nonatomic,strong) NSString *cancomplete;
@property (nonatomic,strong) NSString *cancancelrefund;
@property (nonatomic,strong) NSString *candelete2;
@property (nonatomic,strong) NSString *canrestore;
@property (nonatomic,strong) NSString *verifytype;
// refundstate 1/0 1的话就是退款申请中
@property (nonatomic,strong) NSString *refundstate;
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *remark;

@end



@interface OrderGoodDetailModel : NSObject

@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *thumb;
@property (nonatomic,strong) NSString *total;
@property (nonatomic,strong) NSString *optionname;
@property (nonatomic,strong) NSDictionary *diyformdata;
@property (nonatomic,strong) NSArray <OrderGoodFieldModel*>*diyformfields;

@end


@interface OrderGoodFieldModel : NSObject

@property (nonatomic,strong) NSString *data_type;
@property (nonatomic,strong) NSString *tp_name;
@property (nonatomic,strong) NSString *tp_must;
@property (nonatomic,strong) NSArray *tp_text;
@property (nonatomic,strong) NSString *diy_type;

@end













