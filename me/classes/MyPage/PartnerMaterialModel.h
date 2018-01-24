//
//  PartnerMaterialModel.h
//  me
//
//  Created by KLP on 2018/1/22.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PartnerMaterialFieldModel.h"

@interface PartnerMaterialModel : NSObject

+ (instancetype)initWithf_dataDic:(NSDictionary*)f_data fields:(NSDictionary*)fields;

@property (nonatomic,copy) NSString* diyxingming;
@property (nonatomic,copy) NSString* diyweixinhao;
@property (nonatomic,copy) NSString* diyzhifubao;
@property (nonatomic,copy) NSString* diychangyongyinxingkahao;
@property (nonatomic,copy) NSString* diykaihuxinxi;
@property (nonatomic,copy) NSString* diysuozaidiqu;
@property (nonatomic,copy) NSString* province;
@property (nonatomic,copy) NSString* city;
@property (nonatomic,copy) NSString* area;
@property (nonatomic,copy) NSString* value;


@property (nonatomic,copy) NSString* diyxiangxidizhi;

@property (nonatomic, strong) NSArray *fieldArr;


@end



