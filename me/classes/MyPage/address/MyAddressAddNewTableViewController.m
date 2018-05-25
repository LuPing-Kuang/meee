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
#import "UserDataLoader.h"

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
    
    if (self.addressModel) {
        self.realname.text = _addressModel.realname;
        self.mobile.text = _addressModel.mobile;
        self.area.text = _addressModel.area;
        self.detail.text = _addressModel.address;
        
        if (_addressModel.isdefault.integerValue==1) {
            self.defaultSwitch.on = YES;
        }else{
            self.defaultSwitch.on = NO;
        }
    }
    
}

- (void)setAddressModel:(ProductionOrderAddressModel *)addressModel{
    _addressModel = addressModel;
    
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
        self.area.text=proCityDisModel.district.name;
    }];
}

- (IBAction)saveBtnClick:(UIButton *)sender {
        
    if (self.realname.text.length==0) {
        [self showErrorMsg:@"请填写收货人地址"];
        return;
    }
    
    if (self.mobile.text.length==0) {
        [self showErrorMsg:@"请填写手机号码"];
        return;
    }
    
    if (self.area.text.length==0) {
        [self showErrorMsg:@"请选择地区"];
        return;
    }
    
    if (self.detail.text.length==0) {
        [self showErrorMsg:@"请填写详细地址"];
        return;
    }
    
    
    [HUDManager showLoading:@"提交中..."];
    MJWeakSelf;
    
    BOOL isDefault = self.defaultSwitch.on;
    
    NSString *value = [NSString stringWithFormat:@"%@%@%@",proCityDisModel.province.value,proCityDisModel.city.value,proCityDisModel.district.value];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.realname.text forKey:@"realname"];
    [dic setValue:self.mobile.text forKey:@"mobile"];
    [dic setValue:self.detail.text forKey:@"address"];
    
    [dic setValue:proCityDisModel.province.name forKey:@"province"];
    [dic setValue:proCityDisModel.city.name forKey:@"city"];
    [dic setValue:self.area.text forKey:@"area"];
    [dic setValue:value forKey:@"datavalue"];
    [dic setValue:[NSNumber numberWithInteger:isDefault] forKey:@"isdefault"];
    
    if (self.addressModel) {
        [dic setValue:self.addressModel.idd forKey:@"id"];
    }
    
    [UserDataLoader addAddressData:dic withCompleted:^(id result, BOOL success) {
        if (success) {
            if (weakSelf.addressModel) {
                [HUDManager showSuccessMsg:@"修改成功"];
            }else{
                [HUDManager showSuccessMsg:@"添加成功"];
            }
            
            if (weakSelf.refreshBlock) {
                weakSelf.refreshBlock();
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [HUDManager showErrorMsg:result];
        }
    }];

    
}












@end
