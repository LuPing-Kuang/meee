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

//生成订单
+(void)CreateOrderIdCache:(BOOL)cache token:(NSString*)token Param:(NSDictionary*)dic success:(void(^)(NSString*orderId))success failure:(void(^)(NSString* errorMsg))failure{
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [paramDic setValue:token forKey:@"access_token"];
    
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=order.create.submit" parameters:paramDic success_status_ok:^(NSURLSessionDataTask *task, id data) {
        if (success) {
            success(data[@"orderid"]);
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorMsg) {
        if (failure) {
            failure(errorMsg);
        }
    }];
    
}



//获取支付方式
+ (void)payOrderWithOrderNum:(NSString*)orderId withCompleted:(LoadServerDataFinishedBlock)finish{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserModel token] forKey:@"access_token"];
    [dic setValue:orderId forKey:@"id"];
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=order.pay" parameters:dic success_status_ok:^(NSURLSessionDataTask *task, id data) {
        if (finish) {
            NSLog(@"%@",data);
            if (data[@"order"] && data[@"paytype"]) {
                
                ProductionPayTypeModel *model = [ProductionPayTypeModel mj_objectWithKeyValues:data[@"order"]];
                
                myPayTypeModel *credit = [myPayTypeModel mj_objectWithKeyValues:data[@"paytype"][@"credit"]];
                myPayTypeModel *wechat = [myPayTypeModel mj_objectWithKeyValues:data[@"paytype"][@"wechat"]];
                myPayTypeModel *alipay = [myPayTypeModel mj_objectWithKeyValues:data[@"paytype"][@"alipay"]];
                myPayTypeModel *cash = [myPayTypeModel mj_objectWithKeyValues:data[@"paytype"][@"cash"]];
                
                model.credit = credit;
                model.wechat = wechat;
                model.alipay = alipay;
                model.cash = cash;
                
                finish(model,YES);
                
            }else{
                finish(SERVEERROR_WORD,NO);
            }
            
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorMsg) {
        if (finish) {
            finish(errorMsg,NO);
        }
    }];
    
}


//支付前检测
+ (void)checkOrderWithOrderNum:(NSString*)orderId withCompleted:(LoadServerDataFinishedBlock)finish{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserModel token] forKey:@"access_token"];
    [dic setValue:orderId forKey:@"id"];
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=order.pay.check" parameters:dic success_status_ok:^(NSURLSessionDataTask *task, id data) {
        if (finish) {
            NSLog(@"%@",data);
            finish(data,YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorMsg) {
        if (finish) {
            finish(errorMsg,NO);
        }
    }];
    
}

//支付请求
+ (void)getPayRequestWithtype:(NSString*)type WithOrderNum:(NSString*)orderId withCompleted:(LoadServerDataFinishedBlock)finish{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserModel token] forKey:@"access_token"];
    [dic setValue:orderId forKey:@"id"];
    [dic setValue:type forKey:@"type"];
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=order.pay.get_pay_qr" parameters:dic success_status_ok:^(NSURLSessionDataTask *task, id data) {
        if (finish) {
            NSLog(@"%@",data);
            finish(data[@"jumpurl"],YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorMsg) {
        if (finish) {
            finish(errorMsg,NO);
        }
    }];
}


//余额支付
+ (void)payWithOrdersn:(NSString*)ordersn WithOrderNum:(NSString*)orderId withCompleted:(LoadServerDataFinishedBlock)finish{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserModel token] forKey:@"access_token"];
    [dic setValue:orderId forKey:@"id"];
    [dic setValue:ordersn forKey:@"ordersn"];
    [dic setValue:@"credit" forKey:@"type"];
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=order.pay.complete" parameters:dic success_status_ok:^(NSURLSessionDataTask *task, id data) {
        if (finish) {
            NSLog(@"%@",data);
            finish(data[@"jumpurl"],YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorMsg) {
        if (finish) {
            finish(errorMsg,NO);
        }
    }];
    
}



//余额支付
+ (void)queryResultWithOrderNum:(NSString*)orderId WithCompleted:(LoadServerDataFinishedBlock)finish{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[UserModel token] forKey:@"access_token"];
    [dic setValue:orderId forKey:@"id"];
    
    [[NetworkManager getManager] postPath:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=order.pay.orderstatus" parameters:dic success_status_ok:^(NSURLSessionDataTask *task, id data) {
        if (finish) {
            NSLog(@"%@",data);
            finish(data,YES);
        }
    } failure:^(NSURLSessionDataTask *task, NSString *errorMsg) {
        if (finish) {
            finish(errorMsg,NO);
        }
    }];
    
    
}



@end
