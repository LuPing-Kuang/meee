//
//  PartnerMaterialModel.m
//  me
//
//  Created by KLP on 2018/1/22.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "PartnerMaterialModel.h"

@implementation PartnerMaterialModel

+ (instancetype)initWithf_dataDic:(NSDictionary*)f_data fields:(NSDictionary*)fields member:(NSDictionary*)member{
    PartnerMaterialModel *model = [PartnerMaterialModel mj_objectWithKeyValues:f_data];
    NSString *province = f_data[@"diysuozaidiqu"][@"province"];
    NSString *city = f_data[@"diysuozaidiqu"][@"city"];
    NSString *area = f_data[@"diysuozaidiqu"][@"area"];
    NSString *value = f_data[@"diysuozaidiqu"][@"value"];
    model.province = province==nil?@"":province;
    model.city = city==nil?@"":city;
    model.area = area==nil?@"":area;
    model.value = value==nil?@"":value;
    
    model.nickname = FORMAT(@"%@",member[@"nickname"]);
    model.mobile = FORMAT(@"%@",member[@"mobile"]);
    model.mobileverify = FORMAT(@"%@",member[@"mobileverify"]);
    model.avatar = FORMAT(@"%@",member[@"avatar"]);
    
    NSMutableArray *arr = [NSMutableArray array];
    
    if (fields[@"diyxingming"]) {
        PartnerMaterialFieldModel *mo = [PartnerMaterialFieldModel mj_objectWithKeyValues:fields[@"diyxingming"]];
        mo.myKey = @"diyxingming";
        mo.myName = model.diyxingming;
        [arr addObject:mo];
    }
    
    if (fields[@"diyweixinhao"]) {
        PartnerMaterialFieldModel *mo = [PartnerMaterialFieldModel mj_objectWithKeyValues:fields[@"diyweixinhao"]];
        mo.myKey = @"diyweixinhao";
        mo.myName = model.diyweixinhao;
        [arr addObject:mo];
    }
    
    if (fields[@"diyzhifubao"]) {
        PartnerMaterialFieldModel *mo = [PartnerMaterialFieldModel mj_objectWithKeyValues:fields[@"diyzhifubao"]];
        mo.myKey = @"diyzhifubao";
        mo.myName = model.diyzhifubao;
        [arr addObject:mo];
    }
    
    if (fields[@"diychangyongyinxingkahao"]) {
        PartnerMaterialFieldModel *mo = [PartnerMaterialFieldModel mj_objectWithKeyValues:fields[@"diychangyongyinxingkahao"]];
        mo.myKey = @"diychangyongyinxingkahao";
        mo.myName = model.diychangyongyinxingkahao;
        [arr addObject:mo];
    }
    
    if (fields[@"diykaihuxinxi"]) {
        PartnerMaterialFieldModel *mo = [PartnerMaterialFieldModel mj_objectWithKeyValues:fields[@"diykaihuxinxi"]];
        mo.myKey = @"diykaihuxinxi";
        mo.myName = model.diykaihuxinxi;
        [arr addObject:mo];
    }
    
    if (fields[@"diysuozaidiqu"]) {
        PartnerMaterialFieldModel *mo = [PartnerMaterialFieldModel mj_objectWithKeyValues:fields[@"diysuozaidiqu"]];
        mo.myKey = @"diysuozaidiqu";
        mo.myName = [NSString stringWithFormat:@"%@%@%@",model.province,model.city,model.area];
        [arr addObject:mo];
    }
    
    if (fields[@"diyxiangxidizhi"]) {
        PartnerMaterialFieldModel *mo = [PartnerMaterialFieldModel mj_objectWithKeyValues:fields[@"diyxiangxidizhi"]];
        mo.myKey = @"diyxiangxidizhi";
        mo.myName = model.diyxiangxidizhi;
        [arr addObject:mo];
    }
    
    
    model.fieldArr = arr;
    
    return model;
}


@end



