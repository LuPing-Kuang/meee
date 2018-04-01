//
//  ProductionOrderModel.h
//  me
//
//  Created by jam on 2018/1/9.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductionOrderGoodModel : NSObject

@property (nonatomic,strong) NSString* idd;
@property (nonatomic,strong) NSString* goodsid;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* thumb;
@property (nonatomic,strong) NSString* optionid;
@property (nonatomic,strong) NSString* optiontitle;
@property (nonatomic,strong) NSNumber* hasdiscount;
@property (nonatomic,strong) NSNumber* total;
@property (nonatomic,strong) NSNumber* price;
@property (nonatomic,strong) NSNumber* marketprice;
@property (nonatomic,strong) NSString* merchid;
@property (nonatomic,strong) NSString* cates;
@property (nonatomic,strong) NSString* unit;
@property (nonatomic,strong) NSNumber* totalmaxbuy;
@property (nonatomic,strong) NSNumber* minbuy;

@end

@interface ProductionOrderAddressModel : NSObject

@property (nonatomic,strong) NSString* idd;
@property (nonatomic,strong) NSString* uniacid;
@property (nonatomic,strong) NSString* openid;
@property (nonatomic,strong) NSString* realname;
@property (nonatomic,strong) NSString* mobile;
@property (nonatomic,strong) NSString* province;
@property (nonatomic,strong) NSString* city;
@property (nonatomic,strong) NSString* area;
@property (nonatomic,strong) NSString* address;
@property (nonatomic,strong) NSNumber* isdefault;
@property (nonatomic,strong) NSString* zipcode;
@property (nonatomic,strong) NSNumber* deleted;
@property (nonatomic,strong) NSString* street;
@property (nonatomic,strong) NSString* datavalue;
@property (nonatomic,strong) NSString* streetdatavalue;

@end

@interface ProductionOrderDetailPriceModel : NSObject

@property (nonatomic,strong) NSNumber* showTab;
@property (nonatomic,strong) NSNumber* showAddress;
@property (nonatomic,strong) NSNumber* isverify;
@property (nonatomic,strong) NSNumber* isvertual;

@property (nonatomic,strong) NSNumber* changenum;
@property (nonatomic,strong) NSNumber* hasinvoice;
@property (nonatomic,strong) NSNumber* invoicename;
@property (nonatomic,strong) NSNumber* deductcredit;
@property (nonatomic,strong) NSNumber* deductmoney;
@property (nonatomic,strong) NSNumber* deductcredit2;
@property (nonatomic,strong) NSArray* stores;
@property (nonatomic,strong) NSNumber* fields;
@property (nonatomic,strong) NSNumber* f_data;
@property (nonatomic,strong) NSNumber* dispatch_price;
@property (nonatomic,strong) NSNumber* goodsprice;
@property (nonatomic,strong) NSNumber* taskdiscountprice;
@property (nonatomic,strong) NSNumber* discountprice;
@property (nonatomic,strong) NSNumber* showenough;
@property (nonatomic,strong) NSNumber* enoughmoney;
@property (nonatomic,strong) NSNumber* enoughdeduct;
@property (nonatomic,strong) NSNumber* merch_showenough;
@property (nonatomic,strong) NSNumber* merch_enoughmoney;
@property (nonatomic,strong) NSNumber* merch_enoughdeduct;
@property (nonatomic,strong) NSArray* merchs;
@property (nonatomic,strong) NSNumber* realprice;
@property (nonatomic,strong) NSNumber* total;
@property (nonatomic,strong) NSNumber* buyagain;
@property (nonatomic,strong) NSNumber* fromcart;

@property (nonatomic,assign) BOOL shouldShowMemberDiscount;
@property (nonatomic,assign) NSInteger sectionShowingCount;

@end
