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
    [MyPageHttpTool applyPartnerCache:NO mid:self.inviteTf.text.integerValue realname:self.nameTf.text mobile:self.phoneTf.text token:[UserModel token] success:^(PartnerMaterialModel *model) {
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *errorMsg) {
        
        [weakSelf showErrorMsg:errorMsg];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}



@end
