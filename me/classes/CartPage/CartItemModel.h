//
//  CartItemModel.h
//  me
//
//  Created by jam on 2018/1/7.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartItemModel : NSObject

@property NSString* idd;
@property NSNumber* total;
@property NSString* goodsid;
@property NSNumber* stock;
@property NSString* optionstock;
@property NSString* title;
@property NSString* thumb;
@property NSNumber* marketprice;
@property NSNumber* productprice;
@property NSString* optiontitle;
@property NSString* optionid;
@property NSString* specs;
@property NSNumber* minbuy;
@property NSString* unit;
@property NSString* merchid;
@property NSString* merchsale;
@property NSNumber* selected;
@property NSNumber* totalmaxbuy;

@end
