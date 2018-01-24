//
//  PartnerMaterialFieldModel.h
//  me
//
//  Created by KLP on 2018/1/22.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,FieldDataType)
{
    FieldDataTypeSingleLine = 0,
    FieldDataTypeMulLine = 1,
    FieldDataTypeDownBox = 2,
    FieldDataTypeMulSelectBox = 3,
    FieldDataTypePic = 5,
    FieldDataTypeIdCard = 6,
    FieldDataTypeDate = 7,
    FieldDataTypeDateRange = 8,
    FieldDataTypeCity = 9,
    FieldDataTypeSureWord = 10,
    FieldDataTypeTime = 11,
    FieldDataTypeTimeRange = 12,
    FieldDataTypeTips = 13,
    
    FieldDataTypeUnKnow = 14
};


@interface PartnerMaterialFieldModel : NSObject

@property (nonatomic, copy) NSString *data_type;
@property (nonatomic, copy) NSString *tp_name;
@property (nonatomic, copy) NSString *tp_must;
@property (nonatomic, copy) NSString *tp_is_default;
@property (nonatomic, copy) NSString *tp_default;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *myKey;
@property (nonatomic, copy) NSString *myName;




//非服务器字段
@property (nonatomic, assign) FieldDataType dataType;


@end
