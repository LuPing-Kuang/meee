//
//  PartnerMaterialFieldModel.m
//  me
//
//  Created by KLP on 2018/1/22.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "PartnerMaterialFieldModel.h"

@implementation PartnerMaterialFieldModel

- (FieldDataType)dataType{
    NSInteger index = self.data_type.integerValue;
    switch (index) {
        case 0:
            return FieldDataTypeSingleLine;
            break;
        case 1:
            return FieldDataTypeMulLine;
            break;
        case 2:
            return FieldDataTypeDownBox;
            break;
        case 3:
            return FieldDataTypeMulSelectBox;
            break;
        case 5:
            return FieldDataTypePic;
            break;
        case 6:
            return FieldDataTypeIdCard;
            break;
        case 7:
            return FieldDataTypeDate;
            break;
        case 8:
            return FieldDataTypeDateRange;
            break;
        case 9:
            return FieldDataTypeCity;
            break;
        case 10:
            return FieldDataTypeSureWord;
            break;
        case 11:
            return FieldDataTypeTime;
            break;
        case 12:
            return FieldDataTypeTimeRange;
            break;
        case 13:
            return FieldDataTypeTips;
            break;
        default:
            break;
    }
    
    return FieldDataTypeUnKnow;
}



@end
