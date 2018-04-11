//
//  ApplyPartnerController.m
//  me
//
//  Created by KLP on 2018/1/24.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ApplyPartnerController.h"
#import "ApplyPartnerCell.h"
#import "MyPageHttpTool.h"

#import "PartnerMaterialModel.h"

@interface ApplyPartnerController ()

@property (nonatomic, strong) UITextField *inviteTf;
@property (nonatomic, strong) UITextField *nameTf;
@property (nonatomic, strong) UITextField *phoneTf;
@property (nonatomic, strong) UITextField *weixinTf;

@property (nonatomic, strong) UILabel *checkLb;


@end

@implementation ApplyPartnerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"成为合伙人";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}



#pragma mark tableviews
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4.0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        ApplyPartnerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyPartnerHeaderCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row==1){
        ApplyPartnerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyPartnerTitleCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MJWeakSelf;
        cell.checkBlock = ^{
            [weakSelf checkPartner];
        };
        self.checkLb = cell.checkLb;
        self.inviteTf = cell.inviteTf;
        self.nameTf = cell.nameTf;
        self.phoneTf = cell.phoneTf;
        return cell;
    }else if (indexPath.row==2){
        MJWeakSelf;
        ApplyPartnerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyPartnerApplyBtnCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.applyBlock = ^{
            [weakSelf ApplyPartner];
        };
        return cell;
    }else if (indexPath.row==3){
        ApplyPartnerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyPartnerFooterCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}


- (void)ApplyPartner{
    MJWeakSelf;
    
    if (self.phoneTf.text.length!=11) {
        [self showErrorMsg:@"请输入11位合伙人手机号"];
        return;
    }
    
    if (self.nameTf.text.length==0) {
        [self showErrorMsg:@"请输入合伙人姓名"];
        return;
    }
    
    [self showLoading:@"正在申请中..."];
    [MyPageHttpTool applyPartnerCache:NO mid:self.inviteTf.text.integerValue realname:self.nameTf.text mobile:self.phoneTf.text token:[UserModel token] success:^(PartnerMaterialModel *model) {
        [weakSelf showSuccessMsg:@"成功提交申请"];
        if (self.needRefreshBlock) {
            self.needRefreshBlock();
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *errorMsg) {
        
        [weakSelf showErrorMsg:errorMsg];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}



- (void)checkPartner{
    MJWeakSelf;
    
    if (self.phoneTf.text.length!=11) {
        [self showErrorMsg:@"请输入11位合伙人手机号"];
        return;
    }
    
    if (self.nameTf.text.length==0) {
        [self showErrorMsg:@"请输入合伙人姓名"];
        return;
    }
    
    [self showLoading:@"查询中..."];
    
    [MyPageHttpTool checkPartnerCache:NO mid:self.inviteTf.text.integerValue realname:self.nameTf.text mobile:self.phoneTf.text token:[UserModel token] success:^(NSString *name) {
        [weakSelf showSuccessMsg:@"查询成功"];
        weakSelf.checkLb.text = name;
    } failure:^(NSString *errorMsg) {
        [weakSelf showErrorMsg:errorMsg];
        
    }];

}



@end
