//
//  RefundProgressController.m
//  me
//
//  Created by 邝路平 on 2018/4/3.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "RefundProgressController.h"
#import "MyPageHttpTool.h"
#import "MyOrderDetailBottomView.h"
#import "RefundPageModel.h"
#import "RefundProgressCell.h"

#import "ApplyRefundController.h"


@interface RefundProgressController ()

@property (nonatomic,strong) RefundPageModel *pageModel;
@property (nonatomic,assign) BOOL ishasData;

@property (nonatomic,strong) NSString *refundProcess;
@property (nonatomic,assign) CGFloat headerHeight;

@property (nonatomic,strong) NSArray *RefundReasonArr;
@property (nonatomic,strong) NSArray *handlingArr;

@end

@implementation RefundProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.title = @"退款申请";
    
    NSArray *RefundReasonArr = @[@"不想要了",@"卖家缺货",@"拍错了/订单信息错误",@"其他"];
    self.RefundReasonArr = RefundReasonArr;
    
    NSArray *handlingArr = @[@"退款(仅退款不退货)",@"退货退款",@"换货"];
    self.handlingArr = handlingArr;
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self refresh];
    [self setBottomBarHidden:true];
    self.refundProcess = @"";
    
}


-(void)refresh
{
    [self loadingDataRefreshing:YES];
}


-(void)loadingDataRefreshing:(BOOL)refreshing
{
    MJWeakSelf;
    [MyPageHttpTool applyRefundPage:self.orderId withCompleted:^(id result, BOOL success) {
        
        if (success) {
            
            RefundPageModel *model = [RefundPageModel mj_objectWithKeyValues:result];
            model.refundModel = [RefundDetailModel mj_objectWithKeyValues:result[@"refund"]];
            weakSelf.pageModel = model;
            
        }else{
            [HUDManager showErrorMsg:result];
            weakSelf.ishasData = false;
            [weakSelf endRefresh];
        }
        
    }];
    
    
}


- (void)setPageModel:(RefundPageModel *)pageModel{
    _pageModel = pageModel;
    self.title = _pageModel.title;
    
    if (_pageModel.refundModel.text.length != 0) {
        NSArray *arr = [_pageModel.refundModel.text componentsSeparatedByString:@"\\n"];
        for (NSInteger i = 0; i<arr.count; i++) {
            if (i == arr.count - 1) {
                self.refundProcess = [NSString stringWithFormat:@"%@%@",self.refundProcess,arr[i]];
            }else{
                self.refundProcess = [NSString stringWithFormat:@"%@%@\n",self.refundProcess,arr[i]];
            }
            
        }
        self.headerHeight = (arr.count + 2) * 20 + 32;
    }
    
    self.ishasData = true;
    [self.tableView reloadData];
    [self endRefresh];
    
    NSArray *titleArr = @[@"取消申请",@"修改申请"];
    [self setupBottomViews:titleArr];
    
}



- (void)setupBottomViews:(NSArray*)titleArr{
    
    MyOrderDetailBottomView *v = LOAD_XIB_CLASS(MyOrderDetailBottomView);
    CGRect fra=[self bottomFrame];
    v.frame = fra;
    v.firstColorTitleArr = titleArr;
    MJWeakSelf;
    v.selectBlock = ^(NSInteger index) {
        if (index == 0) {
            [weakSelf cancelapplyToRefund:weakSelf.orderId];
        }else{
            [weakSelf changeApplyToRefund:weakSelf.orderId];
        }
        
    };
    [self setBottomSubView:v];
    [self setBottomBarHidden:false];
    
}




#pragma mark -
#pragma mark - tableViewDelegate和tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.ishasData) {
        return 3;
    }else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0 || section == 1) {
        return 1;
    }else {
        return 4;
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        RefundProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RefundProgressHeaderCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.merchantTipsLb.text = [NSString stringWithFormat:@"等待商家处理%@",self.pageModel.title];
        cell.tipsDetailLb.text = self.refundProcess;
        
        return cell;
        
    }else if (indexPath.section == 1) {
        RefundProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RefundProgressSectionCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else {
        RefundProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RefundProgressSimpleCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            cell.itemNameLb.text = @"处理方式";
            
            cell.itemMsgLb.text = self.handlingArr[self.pageModel.refundModel.rtype.integerValue];
            
            
        }else if (indexPath.row == 1) {
            
            cell.itemNameLb.text = self.pageModel.refundreason;
            cell.itemMsgLb.text = self.RefundReasonArr[self.pageModel.refundModel.reason.integerValue];
            
            
        }else if (indexPath.row == 2) {
            
            cell.itemNameLb.text = self.pageModel.refundexplain;
            
            cell.itemMsgLb.text = self.pageModel.content;
            
        }else if (indexPath.row == 3) {
            cell.itemNameLb.text = @"申请时间";
            
            cell.itemMsgLb.text = self.pageModel.refundModel.createtime;
        }
        
        
        return cell;
        
    }
    
    return [[UITableViewCell alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return self.headerHeight;
    }else {
        return UITableViewAutomaticDimension;
    }
    
}


//修改申请退款金额
- (void)changeApplyToRefund:(NSString*)orderId {
    ApplyRefundController *vc = [[UIStoryboard storyboardWithName:@"MyPage" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([ApplyRefundController class])];
    vc.orderId = self.orderId;
    vc.pageModel = self.pageModel;
    vc.isModify = true;
    
    [self.navigationController pushViewController:vc animated:true];
}


//取消申请退款
- (void)cancelapplyToRefund:(NSString*)orderId {
    
    MJWeakSelf;
    [self showSystemAlertWithTitle:@"提醒" message:@"确认取消申请退款吗?" buttonTitle:@"确定" needDestructive:true cancleBlock:^(UIAlertAction *action) {
        
    } btnBlock:^(UIAlertAction *action) {
        
        [self showLoading:@"取消申请中..."];
        
        [MyPageHttpTool cancelRefundApply:orderId withCompleted:^(id result, BOOL success) {
            if (success) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:UserNeed_RefreshOrderStatus_Notification object:nil];
                
                if (weakSelf.needRefreshBlock) {
                    weakSelf.needRefreshBlock();
                }
                [weakSelf showSuccessMsg:@"成功取消"];
                [weakSelf.navigationController popViewControllerAnimated:true];
                
            }else{
                [weakSelf showErrorMsg:result];
            }
        }];
        
    }];
    
}






@end
