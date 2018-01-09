//
//  CartItemModel.h
//  me
//
//  Created by jam on 2018/1/7.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartItemModel : NSObject

@property (nonatomic,strong) NSString* idd;
@property (nonatomic,strong) NSNumber* total;
@property (nonatomic,strong) NSString* goodsid;
@property (nonatomic,strong) NSNumber* stock;
@property (nonatomic,strong) NSString* optionstock;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* thumb;
@property (nonatomic,strong) NSNumber* marketprice;
@property (nonatomic,strong) NSNumber* productprice;
@property (nonatomic,strong) NSString* optiontitle;
@property (nonatomic,strong) NSString* optionid;
@property (nonatomic,strong) NSString* specs;
@property (nonatomic,strong) NSNumber* minbuy;
@property (nonatomic,strong) NSString* unit;
@property (nonatomic,strong) NSString* merchid;
@property (nonatomic,strong) NSString* merchsale;
@property (nonatomic,strong) NSNumber* selected;
@property (nonatomic,strong) NSNumber* totalmaxbuy;

@end
