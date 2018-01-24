//
//  MyPageHttpTool.m
//  me
//
//  Created by jam on 2018/1/6.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyPageHttpTool.h"

@implementation MyPageHttpTool

+(void)getMyPageDataCache:(BOOL)cache token:(NSString*)token local:(BOOL)local success:(void(^)(NSArray* myPageSections))success failure:(void(^)(NSString* errorMsg))failure;
{
    NSDictionary* d=[ZZHttpTool pageParams];
    [d setValue:token forKey:@"access_token"];;
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member"];
    
    void(^mysuccess)(NSDictionary*)=^(NSDictionary *dict) {
        
        if ([[dict valueForKey:@"code"] integerValue]!=0) {
            failure(dict[@"message"]);
            return;
        }
        
        NSDictionary* data=[dict valueForKey:@"data"];
    
        NSArray* items=[data valueForKey:@"items"];   //调试中
        
        NSMutableArray* totalSections=[NSMutableArray array];
        
        NSMutableArray* thisOneSection=nil;
        
        for (NSDictionary* d2 in items) {
            NSString* idd=[d2 valueForKey:@"id"];
            NSArray* subdata=[d2 valueForKey:@"data"];
            
            if (thisOneSection==nil) {
                thisOneSection=[NSMutableArray array];
            }
            
            if ([idd isEqualToString:@"member"]) {
                NSDictionary* info=[d2 valueForKey:@"info"];
                UserModel* us=[UserModel yy_modelWithDictionary:info];
                MyPageDataModel* mo=[MyPageDataModel modelWithType:MyPageDataTypeHeader imageName:nil title:nil detail:nil badge:0 action:nil associateObject:us];
                
                [thisOneSection addObject:mo];
            }
            else if([idd isEqualToString:@"listmenu"])
            {
                for (NSDictionary* menu in subdata) {
                    NSString* iconclass=[menu valueForKey:@"iconclass"];
                    NSString* text=[menu valueForKey:@"text"];
                    NSString* link=[[menu valueForKey:@"linkurl"]stringValueFromUrlParamsKey:@"r"];
                    NSInteger dotnum=[[menu valueForKey:@"dotnum"]integerValue];
                    if (![link containsString:@"sale.coupon.my"]) {   //不显示推荐凭证查询
                        MyPageDataModel* mo=[MyPageDataModel modelWithType:MyPageDataTypeNormal imageName:iconclass title:text detail:nil badge:dotnum action:link associateObject:nil];
                        [thisOneSection addObject:mo];
                    }
                    
                }
            }
            else if([idd isEqualToString:@"icongroup"])
            {
                NSMutableArray* collections=[NSMutableArray array];
                for (NSDictionary* but in subdata) {
                    NSString* linkUrl=[but valueForKey:@"linkurl"];
                    NSString* iconclass=[but valueForKey:@"iconclass"];
                    NSString* text=[but valueForKey:@"text"];
                    NSString* link=[linkUrl stringValueFromUrlParamsKey:@"r"];
                    NSInteger dotnum=[[but valueForKey:@"dotnum"]integerValue];
                    NSInteger status=[[linkUrl stringValueFromUrlParamsKey:@"status"]integerValue];
                    SimpleButtonModel* bm=[[SimpleButtonModel alloc]initWithTitle:text imageName:iconclass identifier:link type:status badge:dotnum];
                    [collections addObject:bm];
                }
                MyPageDataModel* mo=[MyPageDataModel modelWithType:MyPageDataTypeCollection imageName:nil title:nil detail:nil badge:0 action:nil associateObject:collections];
                [thisOneSection addObject:mo];
            }
            else if([idd isEqualToString:@"title"])   //合伙人资料完善
            {
                NSDictionary *params = [d2 valueForKey:@"params"];
                NSString* title=@"合伙人资料完善";
                NSString* link=[[params valueForKey:@"link"] stringValueFromUrlParamsKey:@"r"];
                
                //调试中
                MyPageDataModel* mo=[MyPageDataModel modelWithType:MyPageDataTypeNormal imageName:@"icon-fenxiao" title:title detail:nil badge:0 action:link associateObject:nil];
                [thisOneSection addObject:mo];
            }
            
            else if([idd isEqualToString:@"blank"])
            {
                thisOneSection=[NSMutableArray array];
            }
            
            
            if (![totalSections containsObject:thisOneSection]) {
                [totalSections addObject:thisOneSection];
            }
        }
        if(success)
        {
            success(totalSections);
        }
    };
    if (local) {
        NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"mypagejson.txt"];
        
        NSError* err=nil;
        NSString* json=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err];
        NSDictionary* di=[NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        if ([[di valueForKey:@"code"] integerValue]!=0) {
            failure(err.localizedDescription);
        }else{
            mysuccess(di);
        }
        
        return;
    }
    [self get:str params:d usingCache:cache success:mysuccess failure:^(NSError *err) {
        if (failure) {
            failure(err.localizedDescription);
        }
    }];
}

+(void)getMyAddressesCache:(BOOL)cache token:(NSString*)token page:(NSInteger)page pagesize:(NSInteger)pagesize success:(void(^)(NSArray* myAddress))success failure:(void(^)(NSError* error))failure;
{
    NSDictionary* d=[ZZHttpTool pageParamsWithPage:page size:pagesize];
    [d setValue:token forKey:@"access_token"];;
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member.address.get_list"];
    [self get:str params:d usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* res=[NSMutableArray array];
        for (NSDictionary* addict in list) {
            ProductionOrderAddressModel* ad=[ProductionOrderAddressModel yy_modelWithDictionary:addict];
            [res addObject:ad];
        }
        if (success) {
            success(res);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
     }];
}

+(void)getMyFootprintsCache:(BOOL)cache token:(NSString *)token page:(NSInteger)page pagesize:(NSInteger)pagesize success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSDictionary* d=[ZZHttpTool pageParamsWithPage:page size:pagesize];
    [d setValue:token forKey:@"access_token"];;
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member.history.get_list"];
    [self get:str params:d usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* res=[NSMutableArray array];
        for (NSDictionary* addict in list) {
            FootPrintModel* ad=[FootPrintModel yy_modelWithDictionary:addict];
            [res addObject:ad];
        }
        if (success) {
            success(res);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

+(void)postRemoveMyFootprints:(NSArray*)footprints token:(NSString*)token complete:(void(^)(BOOL result,NSString* msg))completion;
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member.history.remove"];
    NSMutableArray* ids=[NSMutableArray array];
    for (FootPrintModel* foo in footprints) {
        if (foo.idd.length>0) {
            [ids addObject:foo.idd];
        }
    }
    NSString* idsString=[ids componentsJoinedByString:@","];
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setValue:token forKey:@"access_token"];
    [dic setValue:idsString forKey:@"ids"];
    
    [self post:str params:dic success:^(NSDictionary *responseObject) {
        BOOL result=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (completion) {
            completion(result,msg);
        }
    } failure:^(NSError *error) {
        if (completion) {
            completion(NO,BadNetworkDescription);
        }
    }];
}

+(void)getMyOrdersCache:(BOOL)cache token:(NSString*)token status:(NSInteger)status page:(NSInteger)page pagesize:(NSInteger)pagesize merchid:(NSString*)merchid success:(void(^)(NSArray* myAddress))success failure:(void(^)(NSError* error))failure;
{
    NSDictionary* d=[ZZHttpTool pageParamsWithPage:page size:pagesize];
    [d setValue:token forKey:@"access_token"];
    if (merchid.length==0) {
        merchid=@"0";
    }
    [d setValue:merchid forKey:@"merchid"];
    [d setValue:[NSNumber numberWithInteger:status] forKey:@"status"];
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=order.get_list"];
    [self get:str params:d usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* res=[NSMutableArray array];
        for (NSDictionary* orderDictionary in list) {
            MyOrderModel* orderModel=[MyOrderModel yy_modelWithDictionary:orderDictionary];
            NSMutableArray* products=[NSMutableArray array];
            NSArray* goods=[orderDictionary valueForKey:@"goods"];
            for (NSDictionary* gd in goods) {
                NSArray* go2ods=[gd valueForKey:@"goods"];
                for (NSDictionary* g2d in go2ods) {
                    MyOrderProductModel* pro=[MyOrderProductModel yy_modelWithDictionary:g2d];
                    [products addObject:pro];
                }
            }
            orderModel.products=products;
            [res addObject:orderModel];
        }
        if (success) {
            success(res);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}


+(void)getMyPartnerCache:(BOOL)cache token:(NSString*)token  success:(void(^)(MyPartnerModel* partner))success failure:(void(^)(NSString* errorMsg))failure{
    
    NSDictionary* d=[NSMutableDictionary dictionary];
    [d setValue:token forKey:@"access_token"];
   
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=commission"];
    [self get:str params:d usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        if (success) {
            if ([dict[@"message"] isKindOfClass:[NSString class]] && [[dict[@"message"] lowercaseString] isEqualToString:@"ok"]) {
                MyPartnerModel* partner=[MyPartnerModel yy_modelWithDictionary:data];
                success(partner);
            }else{
                if (failure) {
                    NSString *msg = dict[@"message"];
                    failure(msg);
                }
            }
            
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err.localizedDescription);
        }
    }];
    
}



//合伙人佣金
+(void)getMyPartnerCommissionCache:(BOOL)cache token:(NSString*)token  success:(void(^)(PartnerCommissionModel* partner))success failure:(void(^)(NSString* errorMsg))failure{
    
    NSDictionary* d=[NSMutableDictionary dictionary];
    [d setValue:token forKey:@"access_token"];
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=commission.withdraw"];
    [self get:str params:d usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        if (success) {
            if ([dict[@"message"] isKindOfClass:[NSString class]] && [[dict[@"message"] lowercaseString] isEqualToString:@"ok"]) {
                PartnerCommissionModel* partner=[PartnerCommissionModel yy_modelWithDictionary:data[@"member"]];
                success(partner);
            }else{
                if (failure) {
                    NSString *msg = dict[@"message"];
                    failure(msg);
                }
            }
            
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err.localizedDescription);
        }
    }];
    
}


//佣金明细
+(void)getMyDistributionOrderCache:(BOOL)cache token:(NSString*)token status:(NSInteger)status page:(NSInteger)page pagesize:(NSInteger)pagesize success:(void(^)(DistributionTotalOrderModel* model))success failure:(void(^)(NSString* errorMsg))failure{
    
    NSDictionary* d=[ZZHttpTool pageParamsWithPage:page size:pagesize];
    [d setValue:token forKey:@"access_token"];

    [d setValue:[NSNumber numberWithInteger:status] forKey:@"status"];
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=commission.order.get_list"];
    [self get:str params:d usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
    
        DistributionTotalOrderModel *model = [DistributionTotalOrderModel mj_objectWithKeyValues:data];
        
        if (success) {
            success(model);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err.localizedDescription);
        }
    }];
    
}

//提现明细
+(void)getMyCashDetailCache:(BOOL)cache token:(NSString*)token status:(NSInteger)status page:(NSInteger)page pagesize:(NSInteger)pagesize success:(void(^)(GetCashDetailTotalModel* model))success failure:(void(^)(NSString* errorMsg))failure{
    
    NSDictionary* d=[ZZHttpTool pageParamsWithPage:page size:pagesize];
    [d setValue:token forKey:@"access_token"];
    
    [d setValue:[NSNumber numberWithInteger:status] forKey:@"status"];
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=commission.log.get_list"];
    [self get:str params:d usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        
        GetCashDetailTotalModel *model = [GetCashDetailTotalModel mj_objectWithKeyValues:data];
        
        if (success) {
            success(model);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err.localizedDescription);
        }
    }];
    
}

//我的下线
+(void)getMyOtherPartnerCache:(BOOL)cache token:(NSString*)token level:(NSInteger)level page:(NSInteger)page pagesize:(NSInteger)pagesize success:(void(^)(MyOtherPartnerTotalModel* model))success failure:(void(^)(NSString* errorMsg))failure{
    
    NSDictionary* d=[ZZHttpTool pageParamsWithPage:page size:pagesize];
    [d setValue:token forKey:@"access_token"];
    
    [d setValue:[NSNumber numberWithInteger:level] forKey:@"level"];
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=commission.down.get_list"];
    [self get:str params:d usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        
        MyOtherPartnerTotalModel *model = [MyOtherPartnerTotalModel mj_objectWithKeyValues:data];
        
        if (success) {
            success(model);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err.localizedDescription);
        }
    }];
    
}


//合伙人资料
+(void)getMyMaterialPartnerCache:(BOOL)cache token:(NSString*)token success:(void(^)(PartnerMaterialModel* model))success failure:(void(^)(NSString* errorMsg))failure{
    
    NSMutableDictionary* d=[NSMutableDictionary dictionary];
    [d setValue:token forKey:@"access_token"];
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member.info"];
    [self get:str params:d usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        

        if (data[@"diyform"]) {
            NSDictionary *f_dataDic = [data[@"diyform"] valueForKey:@"f_data"];
            NSDictionary *fieldsDic = [data[@"diyform"] valueForKey:@"fields"];
            
            PartnerMaterialModel *model = [PartnerMaterialModel initWithf_dataDic:f_dataDic fields:fieldsDic];
            
            if (success) {
                success(model);
            }
            
        }else{
            if (failure) {
                failure(@"没有数据");
            }
        }
        
    } failure:^(NSError *err) {
        if (failure) {
            failure(err.localizedDescription);
        }
    }];
    
}


//申请成为合伙人
+(void)applyPartnerCache:(BOOL)cache mid:(NSInteger)mid realname:(NSString*)realname mobile:(NSString*)mobile token:(NSString*)token success:(void(^)(PartnerMaterialModel* model))success failure:(void(^)(NSString* errorMsg))failure{
    
    NSMutableDictionary* d=[NSMutableDictionary dictionary];
    [d setValue:token forKey:@"access_token"];
    [d setValue:[NSNumber numberWithInteger:mid] forKey:@"mid"];
    [d setValue:realname forKey:@"realname"];
    [d setValue:mobile forKey:@"mobile"];
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=commission.register"];
    [self get:str params:d usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        
        if (success) {
            success(nil);
        }
        
        
    } failure:^(NSError *err) {
        if (failure) {
            failure(err.localizedDescription);
        }
    }];
    
}


@end
