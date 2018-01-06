//
//  ProductPageHttpTool.h
//  me
//
//  Created by jam on 2018/1/6.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ZZHttpTool.h"
#import "ProductionModel.h"

@interface ProductPageHttpTool : ZZHttpTool

+(void)getProductPageCache:(BOOL)cache token:(NSString*)token page:(NSInteger)page pagesize:(NSInteger)pagesize keywords:(NSString*)keywords cate:(NSString*)cate recommand:(BOOL)isrecommand new:(BOOL)isnew hot:(BOOL)ishot discount:(BOOL)isdiscount sendfree:(BOOL)issendfree time:(BOOL)istime order:(NSString*)order by:(NSString*)by success:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

@end
