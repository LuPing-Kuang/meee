//
//  MyAddressAddNewTableViewController.m
//  me
//
//  Created by jam on 2018/1/11.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyAddressAddNewTableViewController.h"
#import "CitySelectionPicker.h"
#import "PickerShadowContainer.h"

@interface MyAddressAddNewTableViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *realname;
@property (weak, nonatomic) IBOutlet UITextField *mobile;
@property (weak, nonatomic) IBOutlet UITextField *area;
@property (weak, nonatomic) IBOutlet UITextField *detail;
@property (weak, nonatomic) IBOutlet UISwitch *defaultSwitch;

@end

@implementation MyAddressAddNewTableViewController
{
    AddressPCDModel* proCityDisModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"新建地址";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark textFielddelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.returnKeyType=UIReturnKeyDone;
    if (textField==self.area) {
        [self goToSelectArea];
        return NO;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark tableviews

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

#pragma mark actions

-(void)goToSelectArea
{
    CitySelectionPicker* picke=[CitySelectionPicker defaultCityPickerWithSections:3];
    [PickerShadowContainer showPickerContainerWithView:picke title:@"请选择地区" completion:^{
        proCityDisModel=picke.selectedCity;
        self.area.text=[NSString stringWithFormat:@"%@%@%@",proCityDisModel.province.name,proCityDisModel.city.name,proCityDisModel.district.name];
    }];
}

- (void)submitNewAddress:(id)sender {
    
}

@end
