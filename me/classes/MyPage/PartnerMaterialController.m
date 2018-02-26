//
//  PartnerMaterialController.m
//  me
//
//  Created by KLP on 2018/1/22.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "PartnerMaterialController.h"
#import "MyPageHttpTool.h"
#import "PartnerMaterialModel.h"
#import "PartnerMaterialFieldModel.h"
#import "PartnerMaterialCell.h"

#import "CitySelectionPicker.h"
#import "PickerShadowContainer.h"
#import "BindMobileController.h"
#import "ModifyMyAvatarAndNickNameController.h"


@interface PartnerMaterialController ()
@property (nonatomic, strong) PartnerMaterialModel *model;
@property (nonatomic, strong) AddressPCDModel *proCityDisModel;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *weixin;
@property (nonatomic, strong) NSString *zhifubao;
@property (nonatomic, strong) NSString *changyongyinghankahao;
@property (nonatomic, strong) NSString *kaihuxinxi;
@property (nonatomic, strong) NSString *suozaidiqu;
@property (nonatomic, strong) NSString *xiangxidizhi;




@end

@implementation PartnerMaterialController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"合伙人资料完善";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self refresh];
}

-(void)refresh
{
    [self loadDataFromLocal:NO];
}

-(void)loadDataFromLocal:(BOOL)local
{
    MJWeakSelf;
    [MyPageHttpTool getMyMaterialPartnerCache:local token:[UserModel token] success:^(PartnerMaterialModel *model) {
        weakSelf.model = model;
        [weakSelf.tableView reloadData];
        
        
        weakSelf.proCityDisModel = [[AddressPCDModel alloc]init];
        
        ProvinceModel* province = [[ProvinceModel alloc]init];
        CityModel* city = [[CityModel alloc]init];
        DistrictModel* district = [[DistrictModel alloc]init];
        province.name =  weakSelf.model.province;
        city.name = weakSelf.model.city;
        district.name = weakSelf.model.area;
        
        NSArray *values = [weakSelf.model.value componentsSeparatedByString:@" "];
        if (values.count==3) {
            province.value = values.firstObject;
            district.value = values.lastObject;
            city.value = values[1];
        }
        
        weakSelf.proCityDisModel.province = province;
        weakSelf.proCityDisModel.city = city;
        weakSelf.proCityDisModel.district = district;
        
        [weakSelf endRefresh];
    } failure:^(NSString *errormsg) {
        [weakSelf showErrorMsg:errormsg];
        [weakSelf endRefresh];
    }];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==2) {
        return self.model.fieldArr.count;
    }else{
        return 1.0;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.001;
    }else{
        return 2;
    }
    
}


-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        PartnerMaterialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PartnerMaterialHeaderCell" forIndexPath:indexPath];
       
        [cell.iconImageV setImageUrl:self.model.avatar];
        cell.nickNameLb.text = self.model.nickname;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section == 1){
        
        PartnerMaterialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PartnerMaterialMidCell" forIndexPath:indexPath];
        if ([self.model.mobileverify isEqualToString:@"1"]) {  //绑定了
            cell.mobileLb.text = [NSString stringWithFormat:@"%@(已绑定)",self.model.mobile];
        }else{
            cell.mobileLb.text = [NSString stringWithFormat:@"%@(未绑定)",self.model.mobile];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section == 2){
        PartnerMaterialFieldModel *mo = self.model.fieldArr[indexPath.row];
        PartnerMaterialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PartnerMaterialCell" forIndexPath:indexPath];
        cell.nameLb.text = mo.tp_name;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([mo.tp_must isEqualToString:@"1"]) {
            cell.dotLb.hidden = NO;
        }else{
            cell.dotLb.hidden = YES;
        }
        cell.myTf.placeholder = mo.placeholder;
        cell.myTf.text = nil;
        cell.myTf.text = mo.myName;
        
        if (indexPath.row == 0) {
            if (!self.name) {
                self.name = mo.myName;
            }
            MJWeakSelf;
            cell.textChangeBlock = ^(NSString *text) {
                weakSelf.name = text;
            };
            cell.myTf.text = self.name;
        }else if (indexPath.row == 1){
            if (!self.weixin) {
                self.weixin = mo.myName;
            }
            MJWeakSelf;
            cell.textChangeBlock = ^(NSString *text) {
                weakSelf.weixin = text;
            };
            cell.myTf.text = self.weixin;
        }else if (indexPath.row == 2){
            if (!self.zhifubao) {
                self.zhifubao = mo.myName;
            }
            MJWeakSelf;
            cell.textChangeBlock = ^(NSString *text) {
                weakSelf.zhifubao = text;
            };
            cell.myTf.text = self.zhifubao;
        }else if (indexPath.row == 3){
            if (!self.changyongyinghankahao) {
                self.changyongyinghankahao = mo.myName;
            }
            MJWeakSelf;
            cell.textChangeBlock = ^(NSString *text) {
                weakSelf.changyongyinghankahao = text;
            };
            cell.myTf.text = self.changyongyinghankahao;
        }else if (indexPath.row == 4){
            if (!self.kaihuxinxi) {
                self.kaihuxinxi = mo.myName;
            }
            MJWeakSelf;
            cell.textChangeBlock = ^(NSString *text) {
                weakSelf.kaihuxinxi = text;
            };
            cell.myTf.text = self.kaihuxinxi;
        }else if (indexPath.row == 5){
            if (!self.suozaidiqu) {
                self.suozaidiqu = mo.myName;
            }
            cell.myTf.text = self.suozaidiqu;
        }else if (indexPath.row == 6){
            if (!self.xiangxidizhi) {
                self.xiangxidizhi = mo.myName;
            }
            MJWeakSelf;
            cell.textChangeBlock = ^(NSString *text) {
                weakSelf.xiangxidizhi = text;
            };
            cell.myTf.text = self.xiangxidizhi;
        }
        
        
        if (mo.dataType == FieldDataTypeSingleLine) {
            cell.sureBtn.hidden = YES;
            cell.sureBtn.userInteractionEnabled = NO;
            cell.rightArrowImageV.hidden = YES;
        }else if (mo.dataType == FieldDataTypeCity){
            cell.sureBtn.hidden = NO;
            cell.sureBtn.userInteractionEnabled = YES;
            cell.rightArrowImageV.hidden = NO;
            MJWeakSelf;
            cell.sureBlock = ^{
                [weakSelf goToSelectArea];
            };
        }
        
        return cell;
    }else if (indexPath.section == 3){
        
        PartnerMaterialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PartnerMaterialFooterCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MJWeakSelf;
        cell.saveBlock = ^{
            [weakSelf savePartnerMaterial];
        };
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        ModifyMyAvatarAndNickNameController *bindVc = [[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:NSStringFromClass([ModifyMyAvatarAndNickNameController class])];
        bindVc.mobile = self.model.mobile;
        bindVc.nickName = self.model.nickname;
        bindVc.avatar = self.model.avatar;
        MJWeakSelf;
        bindVc.needToReload = ^{
            [weakSelf refresh];
        };
        [self.navigationController pushViewController:bindVc animated:YES];
        
    }else if (indexPath.section == 1){
        
        BindMobileController *bindVc = [[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:NSStringFromClass([BindMobileController class])];
        bindVc.mobile = self.model.mobile;
        [self.navigationController pushViewController:bindVc animated:YES];
        
        
    }
}

#pragma mark actions
-(void)goToSelectArea
{
    CitySelectionPicker* picke=[CitySelectionPicker defaultCityPickerWithSections:3];
    MJWeakSelf;
    [PickerShadowContainer showPickerContainerWithView:picke title:@"请选择地区" completion:^{
        weakSelf.proCityDisModel=picke.selectedCity;
        NSString *address = [NSString stringWithFormat:@"%@%@%@",weakSelf.proCityDisModel.province.name,weakSelf.proCityDisModel.city.name,weakSelf.proCityDisModel.district.name];
        
        for (NSInteger i=0; i<weakSelf.model.fieldArr.count; i++) {
            
            PartnerMaterialFieldModel *mo = weakSelf.model.fieldArr[i];
            if (mo.dataType == FieldDataTypeCity) {
                mo.myName = address;
                weakSelf.suozaidiqu = address;
                break;
            }
        }
        
        [weakSelf.tableView reloadData];
    }];
}

- (void)savePartnerMaterial{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.name forKey:@"memberdata[diyxingming]"];
    [dic setValue:self.weixin forKey:@"memberdata[diyweixinhao]"];
    [dic setValue:self.zhifubao forKey:@"memberdata[diyzhifubao]"];
    [dic setValue:self.changyongyinghankahao forKey:@"memberdata[diychangyongyinxingkahao]"];
    [dic setValue:self.kaihuxinxi forKey:@"memberdata[diykaihuxinxi]"];
    [dic setValue:self.xiangxidizhi forKey:@"memberdata[diyxiangxidizhi]"];
    
    NSMutableDictionary *addressDic = [NSMutableDictionary dictionary];
    [addressDic setValue:self.proCityDisModel.province.name forKey:@"province"];
    [addressDic setValue:self.proCityDisModel.city.name forKey:@"city"];
    [addressDic setValue:self.proCityDisModel.district.name forKey:@"area"];
    [addressDic setValue:[NSString stringWithFormat:@"%@ %@ %@",self.proCityDisModel.province.value,self.proCityDisModel.city.value,self.proCityDisModel.district.value] forKey:@"value"];
    
    [dic setValue:addressDic forKey:@"memberdata[diysuozaidiqu]"];
    
    
    [self showLoading:@"修改中..."];
    MJWeakSelf;
    [MyPageHttpTool editPartnerMaterial:dic withCompleted:^(id result, BOOL success) {
        if (success) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [weakSelf showSuccessMsg:@"修改成功"];
        }else{
            [weakSelf showErrorMsg:result];
        }
    }];
    
}




@end
