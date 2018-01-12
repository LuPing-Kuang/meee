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

@interface MyPageHttpTool : ZZHttpTool

+(void)getMyPageDataCache:(BOOL)cache token:(NSString*)token local:(BOOL)local success:(void(^)(NSArray* myPageSections))success failure:(void(^)(NSError* error))failure;

+(void)getMyAddressesCache:(BOOL)cache token:(NSString*)token page:(NSInteger)page pagesize:(NSInteger)pagesize success:(void(^)(NSArray* myAddress))success failure:(void(^)(NSError* error))failure;

+(void)getMyFootprintsCache:(BOOL)cache token:(NSString*)token page:(NSInteger)page pagesize:(NSInteger)pagesize success:(void(^)(NSArray* myAddress))success failure:(void(^)(NSError* error))failure;

+(void)postRemoveMyFootprints:(NSArray*)footprints token:(NSString*)token complete:(void(^)(BOOL result,NSString* msg))completion;

+(void)getMyOrdersCache:(BOOL)cache token:(NSString*)token status:(NSInteger)status page:(NSInteger)page pagesize:(NSInteger)pagesize merchid:(NSString*)merchid success:(void(^)(NSArray* myAddress))success failure:(void(^)(NSError* error))failure;

@end
