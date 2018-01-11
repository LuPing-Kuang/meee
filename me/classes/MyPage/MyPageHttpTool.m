//
//  MyPageHttpTool.m
//  me
//
//  Created by jam on 2018/1/6.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyPageHttpTool.h"

@implementation MyPageHttpTool

+(void)getMyPageDataCache:(BOOL)cache token:(NSString*)token success:(void(^)(NSArray* myPageSections))success failure:(void(^)(NSError* error))failure;
{
    NSDictionary* d=[ZZHttpTool pageParams];
    [d setValue:token forKey:@"access_token"];;
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member"];
    [self get:str params:d usingCache:cache success:^(NSDictionary *dict) {
        
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* items=[data valueForKey:@"items"];
        
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
                    MyPageDataModel* mo=[MyPageDataModel modelWithType:MyPageDataTypeNormal imageName:iconclass title:text detail:nil badge:dotnum action:link associateObject:nil];
                    [thisOneSection addObject:mo];
                }
            }
            else if([idd isEqualToString:@"icongroup"])
            {
                NSMutableArray* collections=[NSMutableArray array];
                for (NSDictionary* but in subdata) {
                    NSString* iconclass=[but valueForKey:@"iconclass"];
                    NSString* text=[but valueForKey:@"text"];
                    NSString* link=[[but valueForKey:@"linkurl"]stringValueFromUrlParamsKey:@"r"];
                    NSInteger dotnum=[[but valueForKey:@"dotnum"]integerValue];
                    SimpleButtonModel* bm=[[SimpleButtonModel alloc]initWithTitle:text imageName:iconclass identifier:link type:0 badge:dotnum];
                    [collections addObject:bm];
                }
                MyPageDataModel* mo=[MyPageDataModel modelWithType:MyPageDataTypeCollection imageName:nil title:nil detail:nil badge:0 action:nil associateObject:collections];
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
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
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

@end
