//
//  CitySelectionPicker.h
//  yangsheng
//
//  Created by Macx on 2017/8/3.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZModel.h"

@interface DistrictModel : ZZModel

@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* zipcode;

@end

@interface CityModel : ZZModel

@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSArray* districts;

@end

@interface ProvinceModel : ZZModel

@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSArray* citys;

@end

@interface CitySelectionPicker : UIPickerView

+(instancetype)defaultCityPickerWithSections:(NSInteger)sections;

@property (nonatomic,strong) NSMutableArray* provinces;
@property (nonatomic,strong,readonly) NSArray* selectedCity;

@end
