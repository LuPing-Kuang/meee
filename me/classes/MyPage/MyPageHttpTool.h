//
//  MyPageHttpTool.h
//  me
//
//  Created by jam on 2018/1/6.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ZZHttpTool.h"
#import "MyPageDataModel.h"
#import "UserModel.h"

#import "SimpleButtonsTableViewCell.h"

#import "ProductionOrderModel.h"
#import "FootPrintModel.h"

#import "MyOrderModel.h"
#import "MyPartnerModel.h"
#import "PartnerCommissionModel.h"
#import "DistributionTotalOrderModel.h"
#import "GetCashDetailTotalModel.h"
#import "MyOtherPartnerTotalModel.h"
#import "PartnerMaterialModel.h"
#import "TransportMsgModel.h"
#import "BundlelistMsgModel.h"

@interface MyPageHttpTool : ZZHttpTool

+(void)getMyPageDataCache:(BOOL)cache token:(NSString*)token local:(BOOL)local success:(void(^)(NSArray* myPageSections))success failure:(void(^)(NSString* errorMsg))failure;

+(void)getMyAddressesCache:(BOOL)cache token:(NSString*)token page:(NSInteger)page pagesize:(NSInteger)pagesize success:(void(^)(NSArray* myAddress))success failure:(void(^)(NSError* error))failure;

+(void)getMyFootprintsCache:(BOOL)cache token:(NSString*)token page:(NSInteger)page pagesize:(NSInteger)pagesize success:(void(^)(NSArray* myAddress))success failure:(void(^)(NSError* error))failure;

+(void)postRemoveMyFootprints:(NSArray*)footprints token:(NSString*)token complete:(void(^)(BOOL result,NSString* msg))completion;

+(void)getMyOrdersCache:(BOOL)cache token:(NSString*)token status:(NSInteger)status page:(NSInteger)page pagesize:(NSInteger)pagesize merchid:(NSString*)merchid success:(void(^)(NSArray* myAddress))success failure:(void(^)(NSError* error))failure;

//取消订单
+ (void)cancelOrderId:(NSString*)oriderId withCompleted:(LoadServerDataFinishedBlock)finish;

//确认收货
+ (void)confirmGetProduct:(NSString*)oriderId withCompleted:(LoadServerDataFinishedBlock)finish;

//查看物流
+ (void)queryTransportWithOriderId:(NSString*)oriderId WithSendtype:(NSString*)sendtype IsFotBundel:(BOOL)isforBundle withCompleted:(LoadServerDataFinishedBlock)finish;


//删除订单或者恢复订单
+ (void)deleteOrderId:(NSString*)oriderId WithUserdeleted:(NSString*)userdeleted withCompleted:(LoadServerDataFinishedBlock)finish;

//合伙人信息
+(void)getMyPartnerCache:(BOOL)cache token:(NSString*)token  success:(void(^)(MyPartnerModel* partner))success failure:(void(^)(NSString* errorMsg))failure;

//合伙人佣金
+(void)getMyPartnerCommissionCache:(BOOL)cache token:(NSString*)token  success:(void(^)(PartnerCommissionModel* partner))success failure:(void(^)(NSString* errorMsg))failure;

//佣金明细
+(void)getMyDistributionOrderCache:(BOOL)cache token:(NSString*)token status:(NSInteger)status page:(NSInteger)page pagesize:(NSInteger)pagesize success:(void(^)(DistributionTotalOrderModel* model))success failure:(void(^)(NSString* errorMsg))failure;

//提现明细
+(void)getMyCashDetailCache:(BOOL)cache token:(NSString*)token status:(NSInteger)status page:(NSInteger)page pagesize:(NSInteger)pagesize success:(void(^)(GetCashDetailTotalModel* model))success failure:(void(^)(NSString* errorMsg))failure;

//我的下线
+(void)getMyOtherPartnerCache:(BOOL)cache token:(NSString*)token level:(NSInteger)level page:(NSInteger)page pagesize:(NSInteger)pagesize success:(void(^)(MyOtherPartnerTotalModel* model))success failure:(void(^)(NSString* errorMsg))failure;

//合伙人资料
+(void)getMyMaterialPartnerCache:(BOOL)cache token:(NSString*)token success:(void(^)(PartnerMaterialModel* model))success failure:(void(^)(NSString* errorMsg))failure;

//申请成为合伙人
+(void)applyPartnerCache:(BOOL)cache mid:(NSInteger)mid realname:(NSString*)realname mobile:(NSString*)mobile token:(NSString*)token success:(void(^)(PartnerMaterialModel* model))success failure:(void(^)(NSString* errorMsg))failure;

//编辑完善合伙人资料
+ (void)editPartnerMaterial:(NSDictionary*)param withCompleted:(LoadServerDataFinishedBlock)finish;

//上传个人头像
+ (void)uploadMyIcon:(UIImage*)image withCompleted:(LoadServerDataFinishedBlock)finish;

//绑定手机
+ (void)bindMyPhone:(NSString*)phone verifycode:(NSString*)verifycode withCompleted:(LoadServerDataFinishedBlock)finish;

//保存个人信息
+ (void)saveMyNickName:(NSString*)nickName avatar:(NSString*)avatar withCompleted:(LoadServerDataFinishedBlock)finish;



@end
