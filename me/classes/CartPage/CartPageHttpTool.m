//
//  CartPageHttpTool.m
//  me
//
//  Created by jam on 2018/1/7.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "CartPageHttpTool.h"

@implementation CartPageHttpTool

+(void)getCartPageCache:(BOOL)cache token:(NSString*)access_token success:(void(^)(NSArray* result,BOOL selectedAll))success failure:(void(^)(NSError* error))failure;
{
    NSMutableDictionary* par=[NSMutableDictionary dictionary];
    if (access_token.length>0) {
        [par setValue:access_token forKey:@"access_token"];
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member.cart.get_cart"];
    [self get:str params:par usingCache:cache success:^(NSDictionary *dict) {
        
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];         //调试中
//        NSArray* list=@[];
        NSMutableArray* res=[NSMutableArray array];
        
        BOOL ischeckall=YES;
        for (NSDictionary* di in list) {
            
            CartItemModel* ca=[CartItemModel yy_modelWithDictionary:di];
            if (ca.selected.boolValue==NO) {
                ischeckall=NO;
            }
            [res addObject:ca];
        }
        
        if (success) {
            success(res,ischeckall);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

+(void)postChangeCartCount:(NSInteger)count cartId:(NSString *)cartId token:(NSString *)token
{
    NSMutableDictionary* par=[NSMutableDictionary dictionary];
    [par setValue:token forKey:@"access_token"];
    [par setValue:[NSNumber numberWithInteger:count] forKey:@"total"];
    [par setValue:cartId forKey:@"id"];
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member.cart.update"];
    [self post:str params:par success:nil failure:nil];
}

+(void)postDeleteCarts:(NSArray*)cartItems token:(NSString*)token complete:(void(^)(BOOL result, NSArray* deletedItems, NSString* msg))complete
{
    if(cartItems.count==0)
    {
        if (complete) {
            complete(YES,nil,@"没有选择商品");
        }
        return;
    }
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member.cart.remove"];
    for (NSInteger i=0;i<cartItems.count;i++) {
        CartItemModel* ca =[cartItems objectAtIndex:i];
        NSString* idd=ca.idd;
        str=[NSString stringWithFormat:@"%@&ids[%ld]=%@",str,(long)i,idd];
    }
    str=[NSString stringWithFormat:@"%@&access_token=%@",str,token];
    
    [self post:str params:nil success:^(NSDictionary *responseObject) {
        BOOL result=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (complete) {
            complete(result,cartItems,msg);
        }
    } failure:^(NSError *error) {
        if (complete) {
            complete(NO,cartItems,BadNetworkDescription);
        }
    }];
}

+(void)postAttentionCarts:(NSArray*)cartItems token:(NSString*)token complete:(void(^)(BOOL result, NSArray* deletedItems, NSString* msg))complete
{
    if(cartItems.count==0)
    {
        if (complete) {
            complete(YES,nil,@"没有选择商品");
        }
        return;
    }
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member.cart.tofavorite"];
    for (NSInteger i=0;i<cartItems.count;i++) {
        CartItemModel* ca =[cartItems objectAtIndex:i];
        NSString* idd=ca.idd;
        str=[NSString stringWithFormat:@"%@&ids[%ld]=%@",str,(long)i,idd];
    }
    str=[NSString stringWithFormat:@"%@&access_token=%@",str,token];
    
    [self post:str params:nil success:^(NSDictionary *responseObject) {
        BOOL result=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (complete) {
            complete(result,cartItems,msg);
        }
    } failure:^(NSError *error) {
        if (complete) {
            complete(NO,cartItems,BadNetworkDescription);
        }
    }];
}

+(void)postSelectCartsId:(NSString*)idd token:(NSString*)token selected:(BOOL)selected
{
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=member.cart.select"];
    
    NSMutableDictionary* par=[NSMutableDictionary dictionary];
    [par setValue:idd forKey:@"id"];
    [par setValue:token forKey:@"access_token"];
    [par setValue:[NSNumber numberWithBool:selected] forKey:@"select"];
    
    [self post:str params:par success:nil failure:nil];
}

@end
