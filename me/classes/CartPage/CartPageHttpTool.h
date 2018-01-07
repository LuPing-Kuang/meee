//
//  CartPageHttpTool.h
//  me
//
//  Created by jam on 2018/1/7.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ZZHttpTool.h"
#import "CartItemModel.h"

@interface CartPageHttpTool : ZZHttpTool

+(void)getCartPageCache:(BOOL)cache token:(NSString*)access_token success:(void(^)(NSArray* result,BOOL selectedAll))success failure:(void(^)(NSError* error))failure;

+(void)postChangeCartCount:(NSInteger)count cartId:(NSString*)cartId token:(NSString*)token;

+(void)postDeleteCarts:(NSArray*)cartItems token:(NSString*)token complete:(void(^)(BOOL result, NSArray* deletedItems,NSString* msg))complete;

+(void)postAttentionCarts:(NSArray*)cartItems token:(NSString*)token complete:(void(^)(BOOL result, NSArray* deletedItems, NSString* msg))complete;

@end
