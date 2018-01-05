//
//  MyPageDataModel.m
//  me
//
//  Created by jam on 2018/1/5.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyPageDataModel.h"

@implementation MyPageDataModel

+(instancetype)modelWithType:(MyPageDataType)type imageName:(NSString *)imageName title:(NSString *)title detail:(NSString *)detail badge:(NSInteger)badge associateObject:(id)obj
{
    MyPageDataModel* mo=[[MyPageDataModel alloc]init];
    mo.dataType=type;
    mo.imageName=imageName;
    mo.title=title;
    mo.detail=detail;
    mo.badge=badge;
    mo.associateObject=obj;
    return mo;
}

@end
