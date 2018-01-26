//
//  ProductPageHttpTool.h
//  me
//
//  Created by jam on 2018/1/6.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ZZHttpTool.h"
#import "ProductionModel.h"
#import "ProductionOrderModel.h"

@interface ProductPageHttpTool : ZZHttpTool

+(void)getProductPageCache:(BOOL)cache token:(NSString*)token page:(NSInteger)page pagesize:(NSInteger)pagesize keywords:(NSString*)keywords cate:(NSString*)cate recommand:(BOOL)isrecommand new:(BOOL)isnew hot:(BOOL)ishot discount:(BOOL)isdiscount sendfree:(BOOL)issendfree time:(BOOL)istime order:(NSString*)order by:(NSString*)by success:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

+(void)getCreateOrderDetailCache:(BOOL)cache token:(NSString*)token idd:(NSString*)idd optionid:(NSString*)optionid total:(NSString*)total gdid:(NSString*)gdid giftid:(NSString*)giftid liveid:(NSString*)liveid success:(void(^)(NSArray* goods,ProductionOrderAddressModel* address,ProductionOrderDetailPriceModel* pricedetail))success failure:(void(^)(NSError* error))failure;

//生成订单
+(void)CreateOrderIdCache:(BOOL)cache token:(NSString*)token Param:(NSDictionary*)dic success:(void(^)(NSString*orderId))success failure:(void(^)(NSString* errorMsg))failure;



@end
