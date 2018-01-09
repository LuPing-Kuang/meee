//
//  ProductionModel.h
//  me
//
//  Created by jam on 2018/1/6.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductionModel : NSObject

@property (nonatomic,strong) NSString* idd;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* subtitle;
@property (nonatomic,strong) NSString* thumb;
@property (nonatomic,strong) NSString* thumb_url;
@property (nonatomic,strong) NSNumber* minprice;
@property (nonatomic,strong) NSNumber* isdiscount;
@property (nonatomic,strong) NSNumber* isdiscount_time;
@property (nonatomic,strong) NSNumber* sales;
@property (nonatomic,strong) NSNumber* salesreal;
@property (nonatomic,strong) NSNumber* bargain;
@property (nonatomic,strong) NSNumber* type;
@property (nonatomic,strong) NSNumber* ispresell;
@property (nonatomic,strong) NSNumber* virtuall;
@property (nonatomic,strong) NSNumber* hasoption;

@end
