//
//  PartnerMaterialModel.m
//  me
//
//  Created by KLP on 2018/1/22.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "PartnerMaterialModel.h"

@implementation PartnerMaterialModel

+ (instancetype)initWithf_dataDic:(NSDictionary*)f_data fields:(NSDictionary*)fields{
    PartnerMaterialModel *model = [PartnerMaterialModel mj_objectWithKeyValues:f_data];
    NSString *province = f_data[@"province"];
    NSString *city = f_data[@"city"];
    NSString *area = f_data[@"area"];
    NSString *value = f_data[@"value"];
    model.province = province==nil?@"":province;
    model.city = city==nil?@"":city;
    model.area = area==nil?@"":area;
    model.value = value==nil?@"":value;
    
    NSArray *keys = fields.allKeys;
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *key in keys){
        NSDictionary *dic = fields[key];
        PartnerMaterialFieldModel *mo = [PartnerMaterialFieldModel mj_objectWithKeyValues:dic];
        mo.myKey = key;
        
        if ([mo.myKey isEqualToString:@"diyxingming"]) {
            mo.myName = model.diyxingming;
        }else if ([mo.myKey isEqualToString:@"diyweixinhao"]){
            mo.myName = model.diyweixinhao;
        }else if ([mo.myKey isEqualToString:@"diyzhifubao"]){
            mo.myName = model.diyzhifubao;
        }else if ([mo.myKey isEqualToString:@"diychangyongyinxingkahao"]){
            mo.myName = model.diychangyongyinxingkahao;
        }else if ([mo.myKey isEqualToString:@"diykaihuxinxi"]){
            mo.myName = model.diykaihuxinxi;
        }else if ([mo.myKey isEqualToString:@"diysuozaidiqu"]){
            mo.myName = [NSString stringWithFormat:@"%@%@%@",model.province,model.city,model.area];
        }else if ([mo.myKey isEqualToString:@"diyxiangxidizhi"]){
            mo.myName = model.diyxiangxidizhi;
        }
        
        [arr addObject:mo];
    }
    
    model.fieldArr = arr;
    
    return model;
}


@end



