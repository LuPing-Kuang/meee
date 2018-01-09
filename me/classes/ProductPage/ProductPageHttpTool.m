//
//  ProductPageHttpTool.m
//  me
//
//  Created by jam on 2018/1/6.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ProductPageHttpTool.h"

@implementation ProductPageHttpTool

+(void)getProductPageCache:(BOOL)cache token:(NSString*)token page:(NSInteger)page pagesize:(NSInteger)pagesize keywords:(NSString*)keywords cate:(NSString*)cate recommand:(BOOL)isrecommand new:(BOOL)isnew hot:(BOOL)ishot discount:(BOOL)isdiscount sendfree:(BOOL)issendfree time:(BOOL)istime order:(NSString*)order by:(NSString*)by success:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=goods.get_list"];
    
    NSMutableDictionary* par=[self pageParamsWithPage:page size:pagesize];
    if(token.length>0)
    {
        [par setValue:token forKey:@"access_token"];
    }
    if(keywords.length>0)
    {
        [par setValue:keywords forKey:@"keywords"];
    }
    if (cate.length>0) {
        [par setValue:cate forKey:@"cate"];
    }
    
    [par setValue:@(isrecommand) forKey:@"isrecomand"];
    [par setValue:@(isnew) forKey:@"isnew"];
    [par setValue:@(ishot) forKey:@"ishot"];
    [par setValue:@(isdiscount) forKey:@"isdiscount"];
    [par setValue:@(issendfree) forKey:@"issendfree"];
    [par setValue:@(istime) forKey:@"istime"];
    
    if (order.length>0) {
        [par setValue:order forKey:@"order"];
    }
    else
    {
        by=@"desc";
    }
    if (by.length>0) {
        [par setValue:by forKey:@"by"];
    }
    [self get:str params:par usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* resu=[NSMutableArray array];
        for (NSDictionary* di in list) {
            ProductionModel* pro=[ProductionModel yy_modelWithDictionary:di];
            [resu addObject:pro];
        }
        if (success) {
            success(resu);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

+(void)getCreateOrderDetailCache:(BOOL)cache token:(NSString*)token idd:(NSString*)idd optionid:(NSString*)optionid total:(NSString*)total gdid:(NSString*)gdid giftid:(NSString*)giftid liveid:(NSString*)liveid success:(void(^)(NSArray* goods,ProductionOrderAddressModel* address,ProductionOrderDetailPriceModel* pricedetail))success failure:(void(^)(NSError* error))failure;
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=order.create"];
    NSMutableDictionary* par=[NSMutableDictionary dictionary];
    [par setValue:token forKey:@"access_token"];
    [par setValue:idd forKey:@"id"];
    [par setValue:optionid forKey:@"optionid"];
    [par setValue:total forKey:@"total"];
    [par setValue:gdid forKey:@"gdid"];
    [par setValue:giftid forKey:@"giftid"];
    [par setValue:liveid forKey:@"liveid"];
    
    [self get:str params:par usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* goods=[data valueForKey:@"goods"];
        NSDictionary* addr=[data valueForKey:@"address"];
        
        NSMutableArray* goodsRes=[NSMutableArray array];
        for (NSDictionary* g1d in goods) {
            NSArray* g2oods=[g1d valueForKey:@"goods"];
            for (NSDictionary* g2d in g2oods) {
                ProductionOrderGoodModel* goodmodel=[ProductionOrderGoodModel yy_modelWithDictionary:g2d];
                [goodsRes addObject:goodmodel];
            }
        }
        
        ProductionOrderAddressModel* addressmodel=[ProductionOrderAddressModel yy_modelWithDictionary:addr];
        ProductionOrderDetailPriceModel* detailmodel=[ProductionOrderDetailPriceModel yy_modelWithDictionary:data];
        
        if (success) {
            success(goodsRes,addressmodel,detailmodel);
        }
        
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

@end
