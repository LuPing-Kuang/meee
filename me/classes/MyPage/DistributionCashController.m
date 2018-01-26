//
//  DistributionCashController.m
//  me
//
//  Created by KLP on 2018/1/18.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "DistributionCashController.h"
#import "DistributionCashCell.h"
#import "MyPageHttpTool.h"
#import "PartnerCommissionModel.h"

@interface DistributionCashController ()
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UIButton *bottomBtn;
@property (nonatomic, strong) PartnerCommissionModel *commissionMdodel;


@end

@implementation DistributionCashController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分销佣金";
    
    UIBarButtonItem *getCashDetailBtn=[[UIBarButtonItem alloc]initWithTitle:@"提现明细" style:UIBarButtonItemStylePlain target:self action:@selector(getCashDetailBtnClick)];
    self.navigationItem.rightBarButtonItem=getCashDetailBtn;

    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    self.bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-44 - 64, self.view.frame.size.width, 44)];
    self.bottomBtn.backgroundColor = _importantColor;
    [self.bottomBtn setTitle:@"我要提现" forState:UIControlStateNormal];
    [self.bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.bottomBtn];
    [self.bottomBtn addTarget:self action:@selector(getCashBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self refresh];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1.0;
    }else if (section == 1){
        return 1.0;
    }else if (section == 2){
        return 4.0;
    }else if (section == 3){
        return 2.0;
    }else if (section == 4){
        return 1.0;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        DistributionCashCell* cell=[tableView dequeueReusableCellWithIdentifier:@"DistributionCashHeaderCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.totalCashLb.text = [NSString stringWithFormat:@"%@元",self.commissionMdodel.commission_total];
        return cell;
    }else if (indexPath.section==1){
        DistributionCashCell* cell=[tableView dequeueReusableCellWithIdentifier:@"DistributionCashCenterCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            cell.iconImageV.image = [UIImage imageNamed:@"可提现佣金"];
            cell.itemNameLb.text = @"可提现佣金";
            cell.cashLb.textColor = _importantColor;
            cell.cashLb.text = [NSString stringWithFormat:@"%@元",self.commissionMdodel.commission_ok];
        }
        
        return cell;
    }else if (indexPath.section==2){
        DistributionCashCell* cell=[tableView dequeueReusableCellWithIdentifier:@"DistributionCashCenterCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cashLb.textColor = [UIColor darkGrayColor];
        
        if (indexPath.row==0) {
            cell.iconImageV.image = [UIImage imageNamed:@"已申请佣金"];
            cell.itemNameLb.text = @"已申请佣金";
            cell.cashLb.text = [NSString stringWithFormat:@"%@元",self.commissionMdodel.commission_apply];
        }else if (indexPath.row==1){
            cell.iconImageV.image = [UIImage imageNamed:@"待打款佣金"];
            cell.itemNameLb.text = @"待打款佣金";
            cell.cashLb.text = [NSString stringWithFormat:@"%@元",self.commissionMdodel.commission_check];
        }else if (indexPath.row==2){
            cell.iconImageV.image = [UIImage imageNamed:@"待打款佣金"];
            cell.itemNameLb.text = @"无效佣金";
            cell.cashLb.text = [NSString stringWithFormat:@"%@元",self.commissionMdodel.commission_fail];
        }else if (indexPath.row==3){
            cell.iconImageV.image = [UIImage imageNamed:@"成功提现佣金"];
            cell.itemNameLb.text = @"成功提现佣金";
            cell.cashLb.text = [NSString stringWithFormat:@"%@元",self.commissionMdodel.commission_pay];
        }
        
        return cell;
    }else if (indexPath.section==3){
        DistributionCashCell* cell=[tableView dequeueReusableCellWithIdentifier:@"DistributionCashCenterCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.cashLb.textColor = [UIColor darkGrayColor];
        
        if (indexPath.row==0) {
            cell.iconImageV.image = [UIImage imageNamed:@"待收款佣金"];
            cell.itemNameLb.text = @"待收款佣金";
            cell.cashLb.text = [NSString stringWithFormat:@"%@元",self.commissionMdodel.commission_wait];
        }else if (indexPath.row==1){
            cell.iconImageV.image = [UIImage imageNamed:@"未结算佣金"];
            cell.itemNameLb.text = @"未结算佣金";
            cell.cashLb.text = [NSString stringWithFormat:@"%@元",self.commissionMdodel.commission_lock];
        }
        
        return cell;
    }else if (indexPath.section==4){
        DistributionCashCell* cell=[tableView dequeueReusableCellWithIdentifier:@"DistributionCashFooterCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
}



-(void)refresh
{
    [self loadingDataRefreshing:YES];
}



-(void)loadMore
{
    [self loadingDataRefreshing:NO];
}

-(void)loadingDataRefreshing:(BOOL)refreshing
{
    MJWeakSelf;
    [MyPageHttpTool getMyPartnerCommissionCache:NO token:[UserModel token] success:^(PartnerCommissionModel *partner) {
        weakSelf.commissionMdodel = partner;
        
        [weakSelf.tableView reloadData];
        [weakSelf endRefresh];
    } failure:^(NSString *errorMsg) {
        [HUDManager showErrorMsg:errorMsg];
        [weakSelf endRefresh];
    }];
    
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offy=scrollView.contentOffset.y;
    CGFloat h=scrollView.frame.size.height;
    CGFloat b=scrollView.contentInset.bottom;

    CGRect appf=self.bottomBtn.frame;
    appf.origin.y=offy+h-b;
    appf.size.height=b;
    self.bottomBtn.frame=appf;

    [self.bottomBtn removeFromSuperview];
    [self.tableView addSubview:self.bottomBtn];
}



//提现明细
- (void)getCashDetailBtnClick{
    [self showSuccessMsg:@"提现明细"];
}


//我要提现
- (void)getCashBtnClick{
    [self showSuccessMsg:@"我要提现"];
}




@end
