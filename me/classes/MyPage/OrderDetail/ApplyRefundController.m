//
//  ApplyRefundController.m
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ApplyRefundController.h"
#import "ApplyRefundCell.h"
#import "MyOrderDetailBottomView.h"
#import "ApplyItemSelectView.h"
#import "MyPageHttpTool.h"
#import "MyPageHttpTool.h"

#import "ReportTakePhotoViewVariedHeight.h"
#import "OrderDetailController.h"
#import "RefundProgressController.h"

@interface ApplyRefundController ()



@property (nonatomic,strong) NSString *RefundDes;       //退款说明
@property (nonatomic,strong) NSString *RefundMoney;     //退款价格
@property (nonatomic,strong) NSArray *RefundReasonArr;
@property (nonatomic,strong) NSArray *handlingArr;

@property (nonatomic,strong) NSString *RefundReason;        //退款原因
@property (nonatomic,strong) NSString *handling;            //退款处理方式

@property (nonatomic,strong) NSMutableArray *urlArr;


@property (nonatomic,assign) BOOL ishasData;


@property (nonatomic,strong) NSString *rtype;     //退款处理方式
@property (nonatomic,strong) NSString *reason;    //退款原因



@property (nonatomic,strong) ReportTakePhotoViewVariedHeight *takePhotoView;
@property (nonatomic,assign) CGFloat cell2Height;





@end

@implementation ApplyRefundController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"退款申请";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSArray *titleArr = @[@"取消申请",@"提交申请"];
    [self setupBottomViews:titleArr];
    
    NSArray *RefundReasonArr = @[@"不想要了",@"卖家缺货",@"拍错了/订单信息错误",@"其他"];
    self.RefundReasonArr = RefundReasonArr;
    
    NSArray *handlingArr = @[@"退款(仅退款不退货)",@"退货退款",@"换货"];
    self.handlingArr = handlingArr;
    
    
    if (self.isModify) {
        
        self.handling = self.handlingArr[self.pageModel.refundModel.rtype.integerValue];
        
        self.rtype = self.pageModel.refundModel.rtype;
        
        
        self.RefundReason = self.RefundReasonArr[self.pageModel.refundModel.reason.integerValue];
        
        self.reason = self.pageModel.refundModel.reason;
        self.RefundDes = self.pageModel.content;
        self.RefundMoney = self.pageModel.refundModel.applyprice;
        self.title = self.pageModel.title;
        
        if (self.pageModel.images.count != 0) {
            
            MJWeakSelf;
            [self showLoading:@"加载中..."];
            [MyPageHttpTool downAllImageWithCartoonModel:self.pageModel.imgs imageDownloadSuccess:^(NSArray *ImageArr) {
                [weakSelf showSuccessMsg:@"加载成功"];
                weakSelf.ishasData = true;
                weakSelf.takePhotoView.takeImgs = (NSMutableArray*)ImageArr;
                [weakSelf.tableView reloadData];
                
            } failure:^(NSString *msg) {
                [weakSelf showErrorMsg:msg];
            }];
            
            
        }else {
            self.ishasData = true;
            [self.tableView reloadData];
            
        }
        
        
    }else{
        
        [self refresh];
    }
    
    
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
            weakSelf.pageModel = [RefundPageModel mj_objectWithKeyValues:result];
            [weakSelf setupUIWithModel:weakSelf.pageModel];
        }else{
            [HUDManager showErrorMsg:result];
            weakSelf.ishasData = false;
            [weakSelf endRefresh];
        }
        
    }];
    
    
}

- (void)setupUIWithModel:(RefundPageModel *)pageModel{
    
    _pageModel = pageModel;
    self.title = _pageModel.title;
    
    self.handling = self.handlingArr[0];
    self.rtype = @"0";
    
    self.RefundReason = self.RefundReasonArr[0];
    self.reason = @"0";

    
    
    self.ishasData = true;
    [self.tableView reloadData];
    [self endRefresh];
    
}




- (void)setupBottomViews:(NSArray*)titleArr{
    
    MyOrderDetailBottomView *v = LOAD_XIB_CLASS(MyOrderDetailBottomView);
    CGRect fra=[self bottomFrame];
    v.frame = fra;
    v.firstColorTitleArr = titleArr;
    MJWeakSelf;
    v.selectBlock = ^(NSInteger index) {
        if (index == 0) {
            if (self.isModify) {
                [weakSelf cancelapplyToRefund:weakSelf.orderId];
            }else{
                [weakSelf.navigationController popViewControllerAnimated:true];
            }
            
        }else{
            [weakSelf commitApply];
        }

    };
    [self setBottomSubView:v];
    
}


#pragma mark -
#pragma mark - tableViewDelegate和tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.ishasData) {
        return 6;
    }else {
        return 0;
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        ApplyRefundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyRefundItemCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.itemNameLb.text = @"处理方式";
        
        MJWeakSelf;
        
        cell.itemMsglb.text = self.handling;
        
        cell.itemBtnClick = ^(CGRect rect) {
            
            [ApplyItemSelectView showWithButtonRect:rect SelectBlock:^(NSInteger index) {
                weakSelf.handling = weakSelf.handlingArr[index];
                weakSelf.rtype = [NSString stringWithFormat:@"%lu",index];
                [weakSelf.tableView reloadData];
                
            } TitleArr:weakSelf.handlingArr];
            
                        
        };
        
        return cell;
    }else if (indexPath.row == 1) {
        ApplyRefundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyRefundItemCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.itemNameLb.text = @"退款原因";
      
        cell.itemMsglb.text = self.RefundReason;
        
        MJWeakSelf;
        cell.itemBtnClick = ^(CGRect rect) {
            
            [ApplyItemSelectView showWithButtonRect:rect SelectBlock:^(NSInteger index) {
                weakSelf.RefundReason = weakSelf.RefundReasonArr[index];
                weakSelf.reason = [NSString stringWithFormat:@"%lu",index];
                [weakSelf.tableView reloadData];
                
            } TitleArr:weakSelf.RefundReasonArr];
            
        };
        
        return cell;
    }else if (indexPath.row == 2) {
        ApplyRefundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyRefundInput1Cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MJWeakSelf;
        
        cell.RefundDescriptionTf.text = self.RefundDes;
        
        cell.RefundDesDidChange = ^(NSString *text) {
            weakSelf.RefundDes = text;
        };
        
        return cell;
    }else if (indexPath.row == 3) {
        ApplyRefundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyRefundInput2Cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.RefundMoneyTf.text = self.RefundMoney;
        MJWeakSelf;
        cell.RefundMoneyDidChange = ^(NSString *text) {
            weakSelf.RefundMoney = text;
        };
        
        return cell;
    }else if (indexPath.row == 4) {
        ApplyRefundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyRefundImageCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [cell.contentView addSubview:self.takePhotoView];

        
        
        return cell;
    }else if (indexPath.row == 5) {
        ApplyRefundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyRefundFooterCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.RefundTipsLb.text = [NSString stringWithFormat:@"提示：您可退款的最大金额为¥%.2f",[self.pageModel.order.refundprice floatValue]];
        
        
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        CGFloat height = self.cell2Height==0?70:self.cell2Height;
        return height;
    }else {
        return UITableViewAutomaticDimension;
    }
}



- (void)commitApply{
    if (self.RefundMoney.length == 0) {
        [self showErrorMsg:@"请填写退款金额"];
        return;
    }
    
    
    if (self.RefundMoney.floatValue > self.pageModel.order.refundprice.floatValue) {
        [self showErrorMsg:@"申请退款金额不能大于可退款金额"];
        return;
    }
    
    
    
    
    
    if (self.takePhotoView.takeImgs.count != 0) {
        
        [self showLoading:@"申请中..."];
        self.urlArr = [NSMutableArray array];
        MJWeakSelf;
        // 创建组
        dispatch_group_t imageGroup = dispatch_group_create();
        
        for (UIImage *image in self.takePhotoView.takeImgs) {
            
            // 添加到组
            dispatch_group_enter(imageGroup);
            [MyPageHttpTool uploadMyIcon:image withCompleted:^(id result, BOOL success) {
                if (success) {
                    NSString *url = [NSString stringWithFormat:@"%@%@",uploadImageUrl,result[@"url"]];
                    [weakSelf.urlArr addObject:url];
                    dispatch_group_leave(imageGroup);
                }
                
            }];
            
        }
        
        // 所有图片上传完成 就会来到
        dispatch_group_notify(imageGroup, dispatch_get_main_queue(), ^{
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:self.rtype forKey:@"rtype"];
            [dic setValue:self.reason forKey:@"reason"];
            [dic setValue:self.RefundMoney forKey:@"price"];
            [dic setValue:self.RefundDes forKey:@"content"];
            [dic setValue:self.urlArr forKey:@"images"];
            [dic setValue:self.orderId forKey:@"id"];
            
            [MyPageHttpTool applyRefund:dic withCompleted:^(id result, BOOL success) {
                
                if (success) {
                    if (weakSelf.needRefreshBlock) {
                        weakSelf.needRefreshBlock();
                    }
                    [weakSelf showSuccessMsg:@"申请成功"];
                    [weakSelf popVc];
                }else {
                    [weakSelf showErrorMsg:result];
                }
                
            }];
            
        });
    }else {
        
        MJWeakSelf;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:self.rtype forKey:@"rtype"];
        [dic setValue:self.reason forKey:@"reason"];
        [dic setValue:self.RefundMoney forKey:@"price"];
        [dic setValue:self.RefundDes forKey:@"content"];
        [dic setValue:self.orderId forKey:@"id"];
        
        [MyPageHttpTool applyRefund:dic withCompleted:^(id result, BOOL success) {
            
            if (success) {
                if (weakSelf.needRefreshBlock) {
                    weakSelf.needRefreshBlock();
                }
                [weakSelf showSuccessMsg:@"申请成功"];
                [weakSelf popVc];
            }else {
                [weakSelf showErrorMsg:result];
            }
            
        }];
        
    }
    
    
}


- (void)popVc{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UserNeed_RefreshOrderStatus_Notification object:nil];
    
    NSArray *Vcs = self.navigationController.viewControllers;
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    for (NSInteger i=0; i<Vcs.count; i++) {
        UIViewController *vc = self.navigationController.viewControllers[i];
        if (![vc isKindOfClass:[OrderDetailController class]] && ![vc isKindOfClass:[RefundProgressController class]]) {
            [arr addObject:vc];
        }
    }
    
    self.navigationController.viewControllers = arr;
    [self.navigationController popViewControllerAnimated:YES];
}




//取消申请退款
- (void)cancelapplyToRefund:(NSString*)orderId {
    
    MJWeakSelf;
    [self showSystemAlertWithTitle:@"提醒" message:@"确认取消申请退款吗?" buttonTitle:@"确定" needDestructive:true cancleBlock:^(UIAlertAction *action) {
        
    } btnBlock:^(UIAlertAction *action) {
        
        [self showLoading:@"取消申请中..."];
        
        [MyPageHttpTool cancelRefundApply:orderId withCompleted:^(id result, BOOL success) {
            if (success) {
                
                if (weakSelf.needRefreshBlock) {
                    weakSelf.needRefreshBlock();
                }
                [weakSelf showSuccessMsg:@"成功取消"];
                [weakSelf popVc];
                
            }else{
                [weakSelf showErrorMsg:result];
            }
        }];
        
    }];
    
}


#pragma mark - 懒加载
- (ReportTakePhotoViewVariedHeight *)takePhotoView {
    if (_takePhotoView == nil) {
        MJWeakSelf;
        _takePhotoView = [[ReportTakePhotoViewVariedHeight alloc]initWithFrame:CGRectMake(85, 0, UIScreenWidth - 85, 100)];
        _takePhotoView.resultHeight = ^(CGFloat height) {
            
            NSLog(@"height:%f",height);
            weakSelf.cell2Height = height;
            [weakSelf.tableView reloadData];
        };
    }
    return _takePhotoView;
}






@end
