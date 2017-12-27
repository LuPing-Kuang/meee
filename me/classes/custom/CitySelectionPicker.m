//
//  CitySelectionPicker.m
//  yangsheng
//
//  Created by Macx on 2017/8/3.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "CitySelectionPicker.h"

//static NSMutableArray* provincesStaticArray;

@implementation DistrictModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        self.name=[dictionary valueForKey:@"name"];
        //NSLog(@"            3:%@",self.name);
//        self.zipcode=[dictionary valueForKey:@"zipcode"];
    }
    return self;
}

@end

@implementation CityModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        self.name=[dictionary valueForKey:@"name"];
        //NSLog(@"        2:%@",self.name);
        NSArray* arr=[dictionary valueForKey:@"regions"];
        NSMutableArray* rrm=[NSMutableArray array];
        if ([arr respondsToSelector:@selector(lastObject)]) {
            for (NSDictionary* dic in arr) {
                DistrictModel* m=[[DistrictModel alloc]initWithDictionary:dic];
                [rrm addObject:m];
            }
        }
        else if([arr respondsToSelector:@selector(allKeys)])
        {
            DistrictModel* m=[[DistrictModel alloc]initWithDictionary:(NSDictionary*)arr];
            [rrm addObject:m];
        }
        
        self.districts=rrm;
    }
    return self;
}

@end

@implementation ProvinceModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        self.name=[dictionary valueForKey:@"name"];
        //NSLog(@"1:%@",self.name);
        NSArray* arr=[dictionary valueForKey:@"regions"];
        NSMutableArray* rrm=[NSMutableArray array];
        if ([arr respondsToSelector:@selector(lastObject)]) {
            for (NSDictionary* dic in arr) {
                CityModel* m=[[CityModel alloc]initWithDictionary:dic];
                [rrm addObject:m];
            }
        }
        else if([arr respondsToSelector:@selector(allKeys)])
        {
            CityModel* m=[[CityModel alloc]initWithDictionary:(NSDictionary*)arr];
            [rrm addObject:m];
        }
        self.citys=rrm;
    }
    return self;
}

@end

@interface CitySelectionPicker()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,assign) NSInteger sections;

@end

@implementation CitySelectionPicker

+(instancetype)defaultCityPickerWithSections:(NSInteger)sections
{
    CitySelectionPicker* picker=[[CitySelectionPicker alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 200)];
    picker.backgroundColor=[UIColor whiteColor];
    picker.sections=sections;
    picker.delegate=picker;
    picker.dataSource=picker;
    [picker reloadAllComponents];
    return picker;
}

-(void)setSections:(NSInteger)sections
{
    if (sections>3) {
        sections=3;
    }
    else if(sections<0)
    {
        sections=0;
    }
    _sections=sections;
}

-(NSArray*)provinces
{
    if (_provinces==nil) {
        _provinces=[NSMutableArray array];
        NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"cityJson2.txt"];
        NSError* err=nil;
        NSString* json=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err];
        NSData * data2 = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* result=[NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:nil];
        
        NSArray* root=[result valueForKey:@"regions"];
        NSArray* pros=[root.firstObject valueForKey:@"regions"];
        for (NSDictionary* pm in pros) {
            ProvinceModel* p=[[ProvinceModel alloc]initWithDictionary:pm];
            [_provinces addObject:p];
        }
    }
    return _provinces;
}

-(NSArray*)selectedCity
{
//    return nil;
    NSMutableArray* arr=[NSMutableArray array];
    for (NSInteger i=0; i<self.sections; i++) {
        NSInteger selectedRowInComponent=[self selectedRowInComponent:i];
        NSInteger rowForComponent=[self pickerView:self numberOfRowsInComponent:i];
        if (selectedRowInComponent<rowForComponent) {
            NSString* title=[self pickerView:self titleForRow:selectedRowInComponent forComponent:i];
            if (title.length==0) {
                title=@" ";
            }
            [arr addObject:title];
        }
       
    }
//    return nil;
    return arr;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.sections;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==0)
    {
        return self.provinces.count;
    }
    else if(component==1)
    {
        NSInteger se=[self selectedRowInComponent:0];
        ProvinceModel* pro=[self.provinces objectAtIndex:se];
        return pro.citys.count;
    }
    else if(component==2)
    {
        NSInteger se=[self selectedRowInComponent:0];
        ProvinceModel* pro=[self.provinces objectAtIndex:se];
        se=[self selectedRowInComponent:1];
        CityModel* cit=[pro.citys objectAtIndex:se];
        return cit.districts.count;
    }
    return 0;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component==0)
    {
        return [[self.provinces objectAtIndex:row]name];
    }
    else if(component==1)
    {
        NSInteger se=[self selectedRowInComponent:0];
        ProvinceModel* pro=[self.provinces objectAtIndex:se];
        return [[pro.citys objectAtIndex:row]name];
    }
    else if(component==2)
    {
        NSInteger se=[self selectedRowInComponent:0];
        ProvinceModel* pro=[self.provinces objectAtIndex:se];
        se=[self selectedRowInComponent:1];
        CityModel* cit=[pro.citys objectAtIndex:se];
        return [[cit.districts objectAtIndex:row]name];
    }
    return 0;
}

//-(UIView*)viewForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
//    label.text=[self pickerView:self titleForRow:row forComponent:component];
//    label.textColor=[UIColor redColor];
//    return label;
//}
//
//-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    return view;
//}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView reloadAllComponents];
}

@end
