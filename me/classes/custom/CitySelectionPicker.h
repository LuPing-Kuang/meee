//
//  CitySelectionPicker.h
//  yangsheng
//
//  Created by Macx on 2017/8/3.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistrictModel : NSObject

@property (nonatomic,strong) NSString* value;
@property (nonatomic,strong) NSString* name;

@end

@interface CityModel : NSObject

@property (nonatomic,strong) NSString* value;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSArray* districts;

@end

@interface ProvinceModel : NSObject

@property (nonatomic,strong) NSString* value;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSArray* citys;

@end

@interface AddressPCDModel : NSObject

@property (nonatomic,strong) ProvinceModel* province;
@property (nonatomic,strong) CityModel* city;
@property (nonatomic,strong) DistrictModel* district;

@end

@interface CitySelectionPicker : UIPickerView

+(instancetype)defaultCityPickerWithSections:(NSInteger)sections;

@property (nonatomic,strong) NSMutableArray* provinces;
@property (nonatomic,strong,readonly) AddressPCDModel* selectedCity;

@end
