//
//  MyOrderModel.h
//  me
//
//  Created by jam on 2018/1/12.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,MyOrderType)
{
    MyOrderTypeNotPaid=0,
    MyOrderTypeNotSent=1,
    MyOrderTypeNotReceived=2,
    MyOrderTypeFinished=3,
    MyOrderTypeExchanging=4,
    MyOrderTypeDeleted=5,
    
    MyOrderTypeAll=11,
};

@interface MyOrderProductModel : NSObject

@property (nonatomic,strong) NSString* goodsid;
@property (nonatomic,strong) NSNumber* total;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* thumb;
@property (nonatomic,strong) NSNumber* status;
@property (nonatomic,strong) NSNumber* price;
@property (nonatomic,strong) NSString* optiontitle;
@property (nonatomic,strong) NSString* optionid;
@property (nonatomic,strong) NSString* specs;
@property (nonatomic,strong) NSString* merchid;
@property (nonatomic,strong) NSString* seckill;
@property (nonatomic,strong) NSString* seckill_taskid;
@property (nonatomic,strong) NSNumber* sendtype;
@property (nonatomic,strong) NSString* expresscom;
@property (nonatomic,strong) NSString* expresssn;
@property (nonatomic,strong) NSString* express;
@property (nonatomic,strong) NSString* sendtime;
@property (nonatomic,strong) NSString* finishtime;
@property (nonatomic,strong) NSString* remarksend;
@property (nonatomic,strong) NSNumber* seckilltask;
@property (nonatomic,strong) NSString *storeids;


@end

@interface MyOrderModel : NSObject

+(MyOrderType)orderTypeForPagerIndex:(NSInteger)index;
+(NSInteger)pageIndexForOrderType:(MyOrderType)type;
+(NSString*)titleForOrderType:(MyOrderType)type;

@property (nonatomic,strong) NSString* idd;
@property (nonatomic,strong) NSString* addressid;
@property (nonatomic,strong) NSString* ordersn;
@property (nonatomic,strong) NSNumber* price;
@property (nonatomic,strong) NSNumber* dispatchprice;
@property (nonatomic,strong) NSNumber* status;
@property (nonatomic,strong) NSNumber* iscomment;
@property (nonatomic,strong) NSNumber* isverify;
@property (nonatomic,strong) NSNumber* verifyendtime;
@property (nonatomic,strong) NSNumber* verified;
@property (nonatomic,strong) NSString* verifycode;
@property (nonatomic,strong) NSNumber* verifytype;
@property (nonatomic,strong) NSString* refundid;
@property (nonatomic,strong) NSString* expresscom;
@property (nonatomic,strong) NSString* express;
@property (nonatomic,strong) NSString* expresssn;
@property (nonatomic,strong) NSString* finishtime;
@property (nonatomic,strong) NSString* virtuall;
@property (nonatomic,strong) NSNumber* sendtype;
@property (nonatomic,strong) NSNumber* paytype;
@property (nonatomic,strong) NSNumber* refundstate;
@property (nonatomic,strong) NSNumber* dispatchtype;
@property (nonatomic,strong) NSString* verifyinfo;
@property (nonatomic,strong) NSString* merchid;
@property (nonatomic,strong) NSNumber* isparent;
@property (nonatomic,strong) NSNumber* userdeleted;
@property (nonatomic,strong) NSNumber* goods_num;
@property (nonatomic,strong) NSString* statusstr;
@property (nonatomic,strong) NSString* statuscss;
@property (nonatomic,strong) NSNumber* canrefund;
@property (nonatomic,strong) NSNumber* canverify;

@property (nonatomic,strong) NSArray* products;

@end
