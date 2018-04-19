//
//  GetCashController.m
//  me
//
//  Created by 邝路平 on 2018/3/17.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "GetCashController.h"
#import "MyPageHttpTool.h"
#import "GetCashCell.h"
#import "PayTypeModel.h"

@interface GetCashController ()
@property (nonatomic,assign) NSInteger selectSection;
@property (nonatomic,assign) BOOL isHasData;

@property (nonatomic,strong) NSString *commission_ok;

@property (nonatomic,strong) NSString *AliPay_Name;
@property (nonatomic,strong) NSString *AliPay_Account;
@property (nonatomic,strong) NSString *AliPay_AccountAgain;

@property (nonatomic,strong) NSString *Bank_Account;
@property (nonatomic,strong) NSString *Bank_Name;
@property (nonatomic,strong) NSString *Bank_Num;
@property (nonatomic,strong) NSString *Bank_NumAgain;

@property (nonatomic,strong) PayTypeModel *aliPayModel;
@property (nonatomic,strong) PayTypeModel *weixinPayModel;
@property (nonatomic,strong) PayTypeModel *bankModel;


@end

@implementation GetCashController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我要提现";
    
    [self refresh];
    
    self.selectSection = 1;
    self.isHasData = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
}


-(void)refresh
{
    [self loadingDataRefreshing:YES];
}



-(void)loadMore
{
    [self loadingDataRefreshing:NO];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (!self.isHasData) {
        return 0;
    }
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1.0;
    }else if (section == 1){
        return 1.0;
    }else if (section == 2){
        if (!self.weixinPayModel) {
            return 0;
        }else{
           return 1.0;
        }
        
    }else if (section == 3){
        if (!self.aliPayModel) {
            return 0;
        }else{
            if (self.selectSection == 2) {
                return 4.0;
            }else{
                return 1.0;
            }
        }
        
    }else if (section == 4){
        if (!self.bankModel) {
            return 0;
        }else{
            if (self.selectSection == 3) {
                return 5.0;
            }else{
                return 1.0;
            }
        }
        
    }else{
        return 1.0;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 0) {
        return 10.0;
    }else {
        return 0.01;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        GetCashCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GetCashCellHeader"];
        cell.canGetCashLb.text = [NSString stringWithFormat:@"¥%@",self.commission_ok];
        return cell;
    }else if (indexPath.section == 1){
        GetCashCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GetCashCellSimple"];
        return cell;
    }else if (indexPath.section == 2){
        GetCashCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GetCashCellSection"];
        cell.iconImageV.image = [UIImage imageNamed:@"wechat"];
        cell.getCashMsgLb.text = @"提现到微信钱包";
        cell.selectBtn.tag = 1;
        if (self.selectSection == 1) {
            cell.selectBtn.selected = YES;
        }else{
            cell.selectBtn.selected = NO;
        }
        MJWeakSelf;
        cell.selectBlock = ^(NSInteger index) {
            [weakSelf selectPayMethod:index];
        };
        [cell showBank];
        return cell;
        
    }else if (indexPath.section == 3){
        
        if (indexPath.row == 0) {
            GetCashCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GetCashCellSection"];
            cell.iconImageV.image = [UIImage imageNamed:@"支付宝"];
            cell.getCashMsgLb.text = @"提现到支付宝";
            cell.selectBtn.tag = 2;
            MJWeakSelf;
            cell.selectBlock = ^(NSInteger index) {
                [weakSelf selectPayMethod:index];
            };
            
            if (self.selectSection == 2) {
                cell.selectBtn.selected = YES;
            }else{
                cell.selectBtn.selected = NO;
            }
            [cell showBank];
            return cell;
            
        }else{
            if (indexPath.row == 1) {
                GetCashCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GetCashCellSectionCell"];
                cell.itemNameLb.text = @"姓名";
                cell.itemTf.placeholder = @"请输入姓名";
                cell.itemTf.userInteractionEnabled = YES;
                cell.rightArrow.hidden = YES;
                MJWeakSelf;
                cell.textChangeBlock = ^(NSString *text) {
                    weakSelf.AliPay_Name = text;
                };
                
                cell.itemTf.text = self.AliPay_Name;
                return cell;
                
            }else if (indexPath.row == 2){
                GetCashCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GetCashCellSectionCell"];
                cell.itemNameLb.text = @"支付宝账号";
                cell.itemTf.placeholder = @"请输入支付宝账号";
                cell.itemTf.userInteractionEnabled = YES;
                MJWeakSelf;
                cell.textChangeBlock = ^(NSString *text) {
                    weakSelf.AliPay_Account = text;
                };
               
                cell.itemTf.text = self.AliPay_Account;
                cell.rightArrow.hidden = YES;
                return cell;
                
            }else if (indexPath.row == 3){
                GetCashCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GetCashCellSectionCell"];
                cell.itemNameLb.text = @"确认账号";
                cell.itemTf.placeholder = @"请确认账号";
                cell.itemTf.userInteractionEnabled = YES;
                cell.rightArrow.hidden = YES;
                MJWeakSelf;
                cell.textChangeBlock = ^(NSString *text) {
                    weakSelf.AliPay_AccountAgain = text;
                };
              
                cell.itemTf.text = self.AliPay_AccountAgain;
                return cell;
                
            }
            
        }
        
        
    }else if (indexPath.section == 4){
        
        if (indexPath.row == 0) {
            GetCashCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GetCashCellSection"];
            cell.getCashMsgLb.text = @"提现到银行卡";
            cell.selectBtn.tag = 3;
            MJWeakSelf;
            cell.selectBlock = ^(NSInteger index) {
                [weakSelf selectPayMethod:index];
            };
            if (self.selectSection == 3) {
                cell.selectBtn.selected = YES;
            }else{
                cell.selectBtn.selected = NO;
            }
            [cell hideBank];
            return cell;
        }else{
            if (indexPath.row == 1) {
                GetCashCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GetCashCellSectionCell"];
                cell.itemNameLb.text = @"姓名";
                cell.itemTf.placeholder = @"请输入姓名";
                cell.itemTf.userInteractionEnabled = YES;
                cell.rightArrow.hidden = YES;
                MJWeakSelf;
                cell.textChangeBlock = ^(NSString *text) {
                    weakSelf.Bank_Account = text;
                };
                
                cell.itemTf.text = self.Bank_Account;
                return cell;
                
            }else if (indexPath.row == 2){
                GetCashCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GetCashCellSectionCell"];
                cell.itemNameLb.text = @"银行名称";   //调试中
                cell.itemTf.placeholder = @"请输入银行名称";
                cell.itemTf.userInteractionEnabled = YES;
                cell.rightArrow.hidden = YES;
                MJWeakSelf;
                cell.textChangeBlock = ^(NSString *text) {
                    weakSelf.Bank_Name = text;
                };
               
                cell.itemTf.text = self.Bank_Name;
                return cell;
                
            }else if (indexPath.row == 3){
                GetCashCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GetCashCellSectionCell"];
                cell.itemNameLb.text = @"银行卡号";
                cell.itemTf.placeholder = @"请输入银行卡号";
                cell.itemTf.userInteractionEnabled = YES;
                cell.rightArrow.hidden = YES;
                MJWeakSelf;
                cell.textChangeBlock = ^(NSString *text) {
                    weakSelf.Bank_Num = text;
                };
                
                cell.itemTf.text = self.Bank_Num;
                return cell;
                
            }else if (indexPath.row == 4){
                GetCashCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GetCashCellSectionCell"];
                cell.itemNameLb.text = @"确认卡号";
                cell.itemTf.placeholder = @"请确认卡号";
                cell.itemTf.userInteractionEnabled = YES;
                cell.rightArrow.hidden = YES;
                MJWeakSelf;
                cell.textChangeBlock = ^(NSString *text) {
                    weakSelf.Bank_NumAgain = text;
                };
               
                cell.itemTf.text = self.Bank_NumAgain;
                return cell;
                
            }
        }
        
        
    }else if (indexPath.section == 5){
        
        GetCashCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GetCashCellFooter"];
        MJWeakSelf;
        cell.sureBlock = ^{
            [weakSelf GetCash];
        };
        return cell;
        
    }
    
    
    return [[UITableViewCell alloc]init];
}





-(void)loadingDataRefreshing:(BOOL)refreshing
{
    MJWeakSelf;
    
    [MyPageHttpTool getCashPageWithCompleted:^(id result, BOOL success) {
        
        if (success) {
            weakSelf.commission_ok = result[@"commission_ok"];
            NSDictionary *dic = result[@"type"];
            NSArray *allkeys = dic.allKeys;
            
            for (NSInteger i=0; i<allkeys.count; i++) {
                NSString *key = [NSString stringWithFormat:@"%@",allkeys[i]];
                
                if ([key isEqualToString:@"1"]) {
                    
                    PayTypeModel *weixinmodel = [PayTypeModel mj_objectWithKeyValues:dic[key]];
                    weakSelf.weixinPayModel = weixinmodel;
                    if ([weixinmodel.checked isEqualToString:@"1"]) {
                        weakSelf.selectSection = 1;
                    }
                }
                
                if ([key isEqualToString:@"2"]){
                    
                    PayTypeModel *alimodel = [PayTypeModel mj_objectWithKeyValues:dic[key]];
                    weakSelf.aliPayModel = alimodel;
                    if ([alimodel.checked isEqualToString:@"1"]) {
                        weakSelf.selectSection = 2;
                    }
                    
                    weakSelf.AliPay_Name = weakSelf.aliPayModel.realname;
                    weakSelf.AliPay_Account = weakSelf.aliPayModel.alipay;
                    weakSelf.AliPay_AccountAgain = weakSelf.aliPayModel.alipay;
                }
                
                if ([key isEqualToString:@"3"]){
                    PayTypeModel *bankmodel = [PayTypeModel mj_objectWithKeyValues:dic[key]];
                    weakSelf.bankModel = bankmodel;
                    if ([bankmodel.checked isEqualToString:@"1"]) {
                        weakSelf.selectSection = 3;
                    }
                    
                    weakSelf.Bank_Account = weakSelf.bankModel.realname;
                    weakSelf.Bank_Name = weakSelf.bankModel.bankname;
                    weakSelf.Bank_Num = weakSelf.bankModel.bankcard;
                    weakSelf.Bank_NumAgain = weakSelf.bankModel.bankcard;
                }
                
                
            }
        
            weakSelf.isHasData = YES;
            [weakSelf.tableView reloadData];
            [weakSelf endRefresh];
        }else{
            [weakSelf endRefresh];
            [HUDManager showErrorMsg:result];

        }
        
    }];
    
}




- (void)selectPayMethod:(NSInteger)index{
    
    self.selectSection = index;
    [self.tableView reloadData];
    
}


- (void)GetCash{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (self.selectSection == 1) { //微信支付
        [dic setValue:@"1" forKey:@"type"];
        
    }else if (self.selectSection == 2){ //支付宝支付
        
        if (self.AliPay_Name.length == 0) {
            [self showErrorMsg:@"请输入姓名"];
            return;
        }
        
        if (self.AliPay_Account.length == 0 || self.AliPay_AccountAgain.length == 0) {
            [self showErrorMsg:@"请输入支付宝账号"];
            return;
        }
        
        if (![self.AliPay_Account isEqualToString:self.AliPay_AccountAgain]) {
            [self showErrorMsg:@"两次输入的支付宝账号不一致"];
            return;
        }
        
        [dic setValue:@"2" forKey:@"type"];
        [dic setValue:self.AliPay_Name forKey:@"realname"];
        [dic setValue:self.AliPay_Account forKey:@"alipay"];
        [dic setValue:self.AliPay_AccountAgain forKey:@"alipay1"];
        
    }else if (self.selectSection == 3){ //银行卡支付
        
        if (self.Bank_Account.length == 0) {
            [self showErrorMsg:@"请输入姓名"];
            return;
        }
        
        if (self.Bank_Name.length == 0) {
            [self showErrorMsg:@"请输入银行名称"];
            return;
        }
        
        if (self.Bank_Num.length == 0 || self.Bank_NumAgain.length == 0) {
            [self showErrorMsg:@"请输入银行账号"];
            return;
        }
        
        if (![self.Bank_Num isEqualToString:self.Bank_NumAgain]) {
            [self showErrorMsg:@"两次输入的银行账号不一致"];
            return;
        }
        
        if (self.Bank_Num.length < 16 || self.Bank_Num.length > 18) {
            [self showErrorMsg:@"银行卡号应为16到18位"];
            return;
        }
        
        if (self.Bank_NumAgain.length < 16 || self.Bank_NumAgain.length > 18) {
            [self showErrorMsg:@"确认银行卡号应为16到18位"];
            return;
        }
        
        
        [dic setValue:@"3" forKey:@"type"];
        [dic setValue:self.Bank_Account forKey:@"realname"];
        [dic setValue:self.Bank_Name forKey:@"bankname"];
        [dic setValue:self.Bank_Num forKey:@"bankcard"];
        [dic setValue:self.Bank_NumAgain forKey:@"bankcard1"];
        
    }
    
    [self showLoading:@"申请中..."];
    MJWeakSelf;
    [MyPageHttpTool applyCash:dic withCompleted:^(id result, BOOL success) {
        if (success) {
            [weakSelf showSuccessMsg:@"已提交,请等待审核!"];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [weakSelf showErrorMsg:result];
        }
        
    }];
    
    
    
}











@end
